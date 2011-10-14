package net.wooga.utils.types {
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class Assets {
		public static function getMovieClip(id:String):MovieClip {
			return getInstance(id) as MovieClip;
		}

		public static function getSprite(id:String):Sprite {
			return getInstance(id) as Sprite;
		}

		public static function getBitmap(id:String):Bitmap {
			return getInstance(id) as Bitmap;
		}

		private static function getInstance(id:String):* {
			return Classes.getInstance(id);
		}
	}
}
