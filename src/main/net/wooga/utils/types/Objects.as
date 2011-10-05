package net.wooga.utils.types {
	public class Objects {
		public static function merge(into:Object, from:Object):Object {
			for (var key:String in from) {
				into[key] = from[key];
			}

			return into;
		}
	}
}
