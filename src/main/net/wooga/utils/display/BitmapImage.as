package net.wooga.utils.display {
	import flash.display.Bitmap;
	import flash.display.Sprite;

	public class BitmapImage extends Sprite {
		private var _bitmap:Bitmap = new Bitmap();
		private var _frameData:FrameDataVO;

		public function BitmapImage() {
			_bitmap.name = "content";
			addChild(_bitmap);
		}

		public function get bitmap():Bitmap {
			return _bitmap;
		}

		public function get frameData():FrameDataVO {
			return _frameData;
		}

		public function setBitmap(data:FrameDataVO):void {
			_frameData = data;
			_bitmap.bitmapData = data.bitmapData;
			_bitmap.x = data.regX * data.scaleX;
			_bitmap.y = data.regY * data.scaleX;
			//_bitmap.scaleX = _bitmap.scaleY = data.scale;
		}
	}
}
