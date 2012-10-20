package net.wooga.utils.display {
	import flash.display.Bitmap;
	import flash.display.Sprite;

	public class BitmapImage extends Sprite {
		private var _bitmap:Bitmap = new Bitmap();

		public function BitmapImage() {
			_bitmap.name = "content";
			addChild(_bitmap);
		}

		public function get bitmap():Bitmap {
			return _bitmap;
		}

		public function setBitmap(data:FrameDataVO):void {
			_bitmap.bitmapData = data.bitmapData;
			_bitmap.x = data.offsetX * data.scale;
			_bitmap.y = data.offsetY * data.scale;
			//_bitmap.scaleX = _bitmap.scaleY = data.scale;
		}
	}
}
