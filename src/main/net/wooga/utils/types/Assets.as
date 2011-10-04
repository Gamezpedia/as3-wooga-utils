package net.wooga.utils.types {
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;

	public class Assets {
		public static function getMovieClip(id:String):MovieClip {
			var assetClass:Class = getAssetClass(id);
			var assetInstance:MovieClip = null;

			if (assetClass) {
				assetInstance = new assetClass();
			}

			return assetInstance;
		}


		public static function getAssetClass(id:String):Class {
			var resultclass:Class;

			try {
				resultclass = getDefinitionByName(id) as Class;
			} catch(error:ReferenceError) {
				
			}

			return resultclass;
		}
	}
}
