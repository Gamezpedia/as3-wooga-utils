package net.wooga.utils.display {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	import net.wooga.utils.types.Assets;

	public class Frames {
		private static var _savedFrames:int = 0;
		private static var _createdFrames:int = 0;
		private static const TRANSPARENT:uint = 0xFF000000;
		private static const SOLID:uint = 0x00000000;
		private static const DEFAULT_POINT:Point = new Point(0, 0);

		private static var _frames:Dictionary = new Dictionary();

		public static function getFrames(type:String, colors:Dictionary = null):Vector.<FrameDataVO> {
			var id:String = createFrameId(type, colors);

			if (!_frames[id]) {
				var asset:MovieClip = Assets.getMovieClip(type);
				_frames[id] = parseTimeline(id, asset, colors);
			}

			return _frames[id] as Vector.<FrameDataVO>;
		}

		private static function createFrameId(type:String, colors:Dictionary):String {
			var keys:Array = [];

			for (var key:String in colors) {
				keys.push(Number(key));
			}

			keys.sort(Array.NUMERIC);
			keys.unshift(type);

			return keys.join("_");
		}

		public static function hasFrames(type:String):Boolean {
			return _frames[type] != null;
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
				var frameData:FrameDataVO = getFrameData(frame, frames);
				clip.gotoAndStop(frame);

				if (colors) {
					colorizeClip(clip, colors);
				}

				parseFrameData(name, clip, clipRect, scale, frameData);

				if (prevFrame) {
					compareFrameData(frameData, prevFrame);
				}

				prevFrame = frameData;
			}

			return frames;
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
			var bitmapData:BitmapData = drawBitmap(rect, scale, clip);

			var visRect:Rectangle = bitmapData.getColorBoundsRect(TRANSPARENT, SOLID, false);
			var visBitmapData:BitmapData = createBitmapData(visRect.width, visRect.height);
			visBitmapData.copyPixels(bitmapData, visRect, DEFAULT_POINT);

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

		private static function drawBitmap(rect:Rectangle, scale:Number, clip:DisplayObject):BitmapData {
			var width:Number = rect.width * scale;
			var height:Number = rect.height * scale;
			var bitmapData:BitmapData;

			if (width && height) {
				var matrix:Matrix = new Matrix();
				matrix.tx = -rect.x;
				matrix.ty = -rect.y;
				matrix.scale(scale, scale);

				bitmapData = createBitmapData(width, height);
				bitmapData.draw(clip, matrix);
			}

			return bitmapData;
		}

		private static function createBitmapData(width:Number, height:Number):BitmapData {
			width = Math.ceil(width) || 1;
			height = Math.ceil(height) || 1;

			return new BitmapData(width, height, true, SOLID);
		}
	}
}
