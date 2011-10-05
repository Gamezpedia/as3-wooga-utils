package net.wooga.utils.types {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;

	public class Assets {
		public static function getMovieClip(id:String):MovieClip {
			var assetClass:Class = getClass(id);
			var assetInstance:MovieClip = null;

			if (assetClass) {
				assetInstance = new assetClass();
			}

			return assetInstance;
		}

		public static function getSprite(id:String):Sprite {
			var assetClass:Class = getClass(id);
			var assetInstance:Sprite = null;

			if (assetClass) {
				assetInstance = new assetClass();
			}

			return assetInstance;
		}

		public static function getClass(id:String):Class {
			var resultclass:Class;

			try {
				resultclass = getDefinitionByName(id) as Class;
			} catch(error:ReferenceError) {
				
			}

			return resultclass;
		}
	}
}
