package net.wooga.utils.types {
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;

	public class Assets {
		public static function getMovieClip(id:String):MovieClip {
			var assetClass:Class = getAssetClass(id);

			return assetClass ? new assetClass() : null;
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
