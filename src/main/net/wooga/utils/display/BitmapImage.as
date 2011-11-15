package net.wooga.utils.display {
	import flash.display.Bitmap;
	import flash.display.Sprite;

	public class BitmapImage extends Sprite {
		private var _bitmap:Bitmap = new Bitmap();

		public function BitmapImage(data:FrameDataVO) {
			_bitmap.name = "content";
			addChild(_bitmap);

			setBitmap(data);
		}

		public function get bitmap():Bitmap {
			return _bitmap;
		}

		public function setBitmap(data:FrameDataVO):void {
			_bitmap.bitmapData = data.bitmapData;
			_bitmap.x = data.offsetX;
			_bitmap.y = data.offsetY;
			_bitmap.scaleX = _bitmap.scaleY = 1 / data.scale;
		}
	}
}
