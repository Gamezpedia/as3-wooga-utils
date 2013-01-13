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
		private static var _frames:Dictionary = new Dictionary();

		public static function getFrames(type:String, colorMap:Dictionary = null, scale:Number = 1.0):Vector.<FrameDataVO> {
			var id:String = createFrameId(type, colorMap, scale);
			var frames:Vector.<FrameDataVO> = _frames[id];

			if (!frames) {
				var asset:MovieClip = Assets.getMovieClip(type);
				_frames[id] = frames = parseTimeline(id, asset, colorMap, scale);
			}

			return frames;
		}

		public static function resetFrameCache():void {
			_frames = new Dictionary();
		}

		public static function hasFrames(type:String, colorMap:Dictionary = null, scale:Number = 1.0):Boolean {
			var id:String = createFrameId(type, colorMap, scale);

			return _frames[id] != null;
		}

		public static function parseFrameData(name:String, clip:DisplayObject, rect:Rectangle = null, scale:Number = 1.0, frameData:FrameDataVO = null):FrameDataVO {
			rect ||= clip.getRect(clip);

			var bitmapData:BitmapData = Bitmaps.draw(clip, rect, scale);
			/*var visRect:Rectangle = Bitmaps.getVisibleRect(bitmapData);
			visRect.width ||= 1;
			visRect.height ||= 1;
			var visBitmapData:BitmapData = new BitmapData(visRect.width, visRect.height, true, Bitmaps.TRANSPARENT);
			visBitmapData.copyPixels(bitmapData, visRect, Bitmaps.DEFAULT_POINT);*/

			frameData ||= new FrameDataVO();
			frameData.name = name;
			frameData.bitmapData = bitmapData;//visBitmapData;
			frameData.regX = rect.x;// + visRect.x;
			frameData.regY = rect.y;// + visRect.y;
			frameData.scaleX = frameData.scaleY = scale;

			return frameData;
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

			if (scale) {
				colors.push(scale);
			}

			type = colors.join("_");

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

		private static function parseFrame(frame:int, frames:Vector.<FrameDataVO>, clip:MovieClip, colors:Dictionary, name:String, rect:Rectangle, scale:Number, prevFrame:FrameDataVO):FrameDataVO {
			var frameData:FrameDataVO = getFrameData(frame, frames);
			clip.gotoAndStop(frame);

			if (colors) {
				Displays.colorizeClip(clip, colors);
			}

			parseFrameData(name, clip, rect, scale, frameData);

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
			}
		}

		private static function getClipRectangle(clip:MovieClip, totalFrames:int):Rectangle {
			var top:Number = Number.MAX_VALUE;
			var bottom:Number = Number.MIN_VALUE;
			var left:Number = Number.MAX_VALUE;
			var right:Number = Number.MIN_VALUE;

			for (var i:int = 1; i <= totalFrames; ++i) {
				clip.gotoAndStop(i);
				var rect:Rectangle = clip.getRect(clip);
				top = Math.min(top, rect.top);
				bottom = Math.max(bottom, rect.bottom);
				left = Math.min(left, rect.left);
				right = Math.max(right, rect.right);
			}

			var width:Number = Math.abs(left - right);
			var height:Number = Math.abs(top - bottom);

			return new Rectangle(left, top, width, height);
		}

		private static function getFrameData(frame:int, frames:Vector.<FrameDataVO>):FrameDataVO {
			var frameData:FrameDataVO;

			if (frame < frames.length) {
				frameData = frames[frame - 1] as FrameDataVO;
			} else {
				frameData = new FrameDataVO();
				frames.push(frameData);
			}

			return frameData;
		}

	}
}
