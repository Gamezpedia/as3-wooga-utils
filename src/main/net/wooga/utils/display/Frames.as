package net.wooga.utils.display {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	import net.wooga.utils.types.Assets;
	import net.wooga.utils.types.Bitmaps;
	import net.wooga.utils.types.Displays;

	public class Frames {
		private static var _savedFrames:int = 0;
		private static var _createdFrames:int = 0;

		private static var _frames:Dictionary = new Dictionary();

		public static function getFrames(type:String, colorMap:Dictionary = null, scale:Number = 1.0):Vector.<FrameDataVO> {
			var id:String = createFrameId(type, colorMap, scale);

			if (!_frames[id]) {
				var asset:MovieClip = Assets.getMovieClip(type);
				_frames[id] = parseTimeline(id, asset, colorMap, scale);
			}

			return _frames[id] as Vector.<FrameDataVO>;
		}

		public static function hasFrames(type:String, colorMap:Dictionary = null, scale:Number = 1.0):Boolean {
			var id:String = createFrameId(type, colorMap, scale);

			return _frames[id] != null;
		}

		private static function createFrameId(type:String, colorMap:Dictionary, scale:Number):String {
			var colors:Array = [];

			for each (var num:Number in colorMap) {
				colors.push(num);
			}

			if (colors.length) {
				colors.sort(Array.NUMERIC);
			}

			colors.unshift(type);
			colors.push(scale);
			type = colors.join("_");

			return type;
		}

		public static function addFrames(type:String, frames:Vector.<FrameDataVO>):void {
			_frames[type] = frames;
		}

		public static function parseTimeline(name:String, clip:MovieClip, colors:Dictionary = null, scale:Number = 1.0, frames:Vector.<FrameDataVO> = null):Vector.<FrameDataVO> {
			frames ||= new Vector.<FrameDataVO>();
			frames.reverse();

			var totalFrames:int = clip.totalFrames;
			var prevFrame:FrameDataVO;
			var clipRect:Rectangle = getClipRectangle(clip, totalFrames);

			//for (var frame:int = 1; frame <= totalFrames; ++frame) {
			for (var frame:int = totalFrames; frame > 0; --frame) {
				prevFrame = parseFrame(frame, frames, clip, colors, name, clipRect, scale, prevFrame);
			}

			return frames.reverse();
		}

		private static function parseFrame(frame:int, frames:Vector.<FrameDataVO>, clip:MovieClip, colors:Dictionary, name:String, clipRect:Rectangle, scale:Number, prevFrame:FrameDataVO):FrameDataVO {
			var frameData:FrameDataVO = getFrameData(frame, frames);
			clip.gotoAndStop(frame);

			if (colors) {
				Displays.colorizeClip(clip, colors);
			}

			parseFrameData(name, clip, clipRect, scale, frameData);

			if (prevFrame) {
				//compareFrameData(frameData, prevFrame);
			}

			return frameData;
		}

		private static function compareFrameData(currentFrame:FrameDataVO, prevFrame:FrameDataVO):void {
			var diff:Object = currentFrame.bitmapData.compare(prevFrame.bitmapData);

			if (diff == 0) {
				currentFrame.bitmapData = prevFrame.bitmapData;
				currentFrame.usePreviousFrame = true;
				_savedFrames++;
				//var ratio:Number = _savedFrames / _createdFrames;
				//l(_savedFrames + " / " + _createdFrames + " = " + ratio);
			}
		}

		private static function getClipRectangle(clip:MovieClip, totalFrames:int):Rectangle {
			var top:Number = Number.MAX_VALUE;
			var left:Number = Number.MAX_VALUE;
			var bottom:Number = Number.MIN_VALUE;
			var right:Number = Number.MIN_VALUE;

			for (var i:int = 1; i <= totalFrames; ++i) {
				clip.gotoAndStop(i);
				var rect:Rectangle = clip.getRect(clip);

				if (top > rect.top) {
					top = rect.top;
				}

				if (bottom < rect.bottom) {
					bottom = rect.bottom;
				}

				if (left > rect.left) {
					left = rect.left;
				}

				if (right < rect.right) {
					right = rect.right;
				}
			}

			var width:Number = Math.abs(left - right);
			var height:Number = Math.abs(top - bottom);

			return new Rectangle(left, top, width, height);
		}

		public static function parseFrameData(name:String, clip:DisplayObject, rect:Rectangle = null, scale:Number = 1.0, frameData:FrameDataVO = null):FrameDataVO {
			rect ||= clip.getRect(clip);

			var bitmapData:BitmapData = Bitmaps.drawBitmap(clip, rect, scale);
			var visRect:Rectangle = Bitmaps.getVisibleRect(bitmapData);
			var visBitmapData:BitmapData = Bitmaps.createBitmapData(visRect.width, visRect.height);
			visBitmapData.copyPixels(bitmapData, visRect, Bitmaps.DEFAULT_POINT);

			frameData ||= new FrameDataVO();
			frameData.name = name;
			frameData.bitmapData = visBitmapData;
			frameData.offsetX = rect.x + visRect.x;
			frameData.offsetY = rect.y + visRect.y;
			frameData.scale = scale;

			return frameData;
		}

		private static function getFrameData(frame:int, frames:Vector.<FrameDataVO>):FrameDataVO {
			var frameData:FrameDataVO;

			if (frame < frames.length) {
				frameData = frames[frame - 1] as FrameDataVO;
			} else {
				frameData = new FrameDataVO();
				_createdFrames++;
				frames.push(frameData);
			}

			return frameData;
		}

	}
}
