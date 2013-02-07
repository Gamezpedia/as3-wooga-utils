package net.wooga.utils.types {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Bitmaps {
		public static const DEFAULT_POINT:Point = new Point(0, 0);
		public static const TRANSPARENT:uint = 0x00000000;
		public static const OPAQUE:uint = 0xFF000000;

		public static function draw(display:DisplayObject, rect:Rectangle = null, scale:Number = 1.0, transparent:Boolean = true, color:uint = TRANSPARENT):BitmapData {
			rect ||= display.getBounds(display);

			var bitmapData:BitmapData;
			rect = roundRect(rect, scale);
			var width:Number = rect.width;
			var height:Number = rect.height;

			if (width && height) {
				var matrix:Matrix = new Matrix();
				matrix.tx = -rect.x;
				matrix.ty = -rect.y;
				matrix.scale(scale, scale);

				bitmapData = new BitmapData(rect.width, rect.height, transparent, color);
				bitmapData.draw(display, matrix);
			}

			return bitmapData;
		}

		public static function roundRect(rect:Rectangle, scale:Number = 1.0):Rectangle {
			var width:Number = rect.width * scale;
			var height:Number = rect.height * scale;
			var x:Number = rect.x;
			var y:Number = rect.y;
			var xInteger:int = Math.floor(x);
			var yInteger:int = Math.floor(y);
			var xFraction:Number = x - xInteger;
			var yFraction:Number = y - yInteger;
			var newWidth:int = Math.ceil(width + xFraction);
			var newHeight:int = Math.ceil(height + yFraction);

			rect.x = xInteger;
			rect.y = yInteger;
			rect.width = newWidth || 1;
			rect.height = newHeight || 1;

			return rect;
		}

		public static function getVisibleRect(bitmapData:BitmapData):Rectangle {
			return bitmapData.getColorBoundsRect(Bitmaps.OPAQUE, Bitmaps.TRANSPARENT, false);
		}

		public static function scale(bitmapData:BitmapData, scale:Number):BitmapData {
			scale = Math.abs(scale);

			var width:int = bitmapData.width * scale || 1;
			var height:int = bitmapData.height * scale || 1;
			var transparent:Boolean = bitmapData.transparent;
			var result:BitmapData = new BitmapData(width, height, transparent);
			var matrix:Matrix = new Matrix();
			matrix.scale(scale, scale);
			result.draw(bitmapData, matrix);

			return result;
		}

		public static function createScreenShot(display:DisplayObject, rect:Rectangle = null, scale:Number = 1.0):BitmapData {
			if (!rect) {
				var corner:Point = display.globalToLocal(DEFAULT_POINT);
				rect = new Rectangle(corner.x, corner.y, display.stage.stageWidth, display.stage.stageHeight);
			}

			var bitmapData:BitmapData = draw(display, rect, scale);

			return bitmapData;
		}
	}
}
