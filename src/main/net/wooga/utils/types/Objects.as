package net.wooga.utils.types {
	import flash.utils.ByteArray;

	public class Objects {
		public static function merge(into:Object, from:Object):Object {
			for (var key:String in from) {
				into[key] = from[key];
			}

			return into;
		}

		public static function copy(data:Object):Object {
			return merge({}, data);
		}

		public static function clone(data:Object):Object {
			var cloned:ByteArray = new ByteArray();
			cloned.writeObject(data);
			cloned.position = 0;

			return cloned.readObject();
		}
	}
}
