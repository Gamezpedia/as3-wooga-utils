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

		public static function drawBitmap(display:DisplayObject, rect:Rectangle = null, scale:Number = 1.0, transparent:Boolean = true, color:uint = TRANSPARENT):BitmapData {
			rect ||= display.getRect(display);

			var width:int = Math.ceil(rect.width * scale);
			var height:int = Math.ceil(rect.height * scale);
			var bitmapData:BitmapData;

			if (width && height) {
				var matrix:Matrix = new Matrix();
				matrix.tx = -rect.x;
				matrix.ty = -rect.y;
				matrix.scale(scale, scale);

				bitmapData = new BitmapData(width, height, transparent, color);
				bitmapData.draw(display, matrix);
			}

			return bitmapData;
		}

		public static function getVisibleRect(bitmapData:BitmapData):Rectangle {
			return bitmapData.getColorBoundsRect(Bitmaps.OPAQUE, Bitmaps.TRANSPARENT, false);
		}

		public static function createScreenShot(display:DisplayObject, rect:Rectangle = null, scale:Number = 1.0):BitmapData {
			if (!rect) {
				var corner:Point = display.globalToLocal(DEFAULT_POINT);
				rect = new Rectangle(corner.x, corner.y, display.stage.stageWidth, display.stage.stageHeight);
			}

			var bitmapData:BitmapData = drawBitmap(display, rect, scale);

			return bitmapData;
		}
	}
}
