package net.wooga.utils.display {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	import net.wooga.utils.types.Assets;
	import net.wooga.utils.types.Bitmaps;

	public class Frames {
		private static var _savedFrames:int = 0;
		private static var _createdFrames:int = 0;

		private static var _frames:Dictionary = new Dictionary();

		public static function getFrames(type:String, colors:Dictionary = null):Vector.<FrameDataVO> {
			var id:String = createFrameId(type, colors);

			if (!_frames[id]) {
				var asset:MovieClip = Assets.getMovieClip(type);
				_frames[id] = parseTimeline(id, asset, colors);
			}

			return _frames[id] as Vector.<FrameDataVO>;
		}

		public static function hasFrames(type:String, colors:Dictionary = null):Boolean {
			var id:String = createFrameId(type, colors);

			return _frames[id] != null;
		}

		private static function createFrameId(type:String, colors:Dictionary):String {
			var keys:Array = [];

			for (var key:String in colors) {
				keys.push(Number(key));
			}

			if (keys.length) {
				keys.sort(Array.NUMERIC);
				keys.unshift(type);
				type = keys.join("_");
			}

			return type;
		}

		public static function addFrames(type:String, frames:Vector.<FrameDataVO>):void {
			_frames[type] = frames;
		}

		public static function parseTimeline(name:String, clip:MovieClip, colors:Dictionary = null, scale:Number = 1.0, frames:Vector.<FrameDataVO> = null):Vector.<FrameDataVO> {
			frames ||= new Vector.<FrameDataVO>();

			var totalFrames:int = clip.totalFrames;
			var prevFrame:FrameDataVO;
			var clipRect:Rectangle = getClipRectangle(clip, totalFrames);

			for (var frame:int = 1; frame <= totalFrames; ++frame) {
				prevFrame = parseFrame(frame, frames, clip, colors, name, clipRect, scale, prevFrame);
			}

			return frames;
		}

		private static function parseFrame(frame:int, frames:Vector.<FrameDataVO>, clip:MovieClip, colors:Dictionary, name:String, clipRect:Rectangle, scale:Number, prevFrame:FrameDataVO):FrameDataVO {
			var frameData:FrameDataVO = getFrameData(frame, frames);
			clip.gotoAndStop(frame);

			if (colors) {
				colorizeClip(clip, colors);
			}

			parseFrameData(name, clip, clipRect, scale, frameData);

			if (prevFrame) {
				compareFrameData(frameData, prevFrame);
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

		private static function colorizeClip(clip:MovieClip, colors:Dictionary):void {
			var numChildren:int = clip.numChildren;

			for (var i:int = 0; i < numChildren; ++i) {
				var child:Sprite = clip.getChildAt(i) as Sprite;

				if (child && colors[child.name] != null) {
					colorize(child, colors[child.name]);
				}
			}
		}

		public static function colorize(child:DisplayObject, color:uint):void {
			var bitmask:uint = 0xFF;
			var offset:uint = 0;
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.redOffset = (color >> 16) - offset;
			colorTransform.greenOffset = (color >> 8 & bitmask) - offset;
			colorTransform.blueOffset = (color & bitmask & bitmask) - offset;
			child.transform.colorTransform = colorTransform;
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

		public static function parseFrameData(name:String, clip:DisplayObject, rect:Rectangle, scale:Number = 1.0, frameData:FrameDataVO = null):FrameDataVO {
			var bitmapData:BitmapData = Bitmaps.drawBitmap(rect, scale, clip);
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
