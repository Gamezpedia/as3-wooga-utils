package net.wooga.utils.types {
	import org.as3commons.lang.ClassUtils;

	public class Classes {
		public static function getInstance(id:String, args:Array = null):Object {
			var classObject:Class = ClassUtils.forName(id);

			return ClassUtils.newInstance(classObject, args);
		}

		public static function getConstantPrefix(classObject:Class):String {
			return ClassUtils.getFullyQualifiedName(classObject) + ".";
		}
	}
}
