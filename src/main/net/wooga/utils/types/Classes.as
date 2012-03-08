package net.wooga.utils.types {
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;

	import org.as3commons.lang.ClassUtils;

	public class Classes {
		public static function getClass(id:String):Class {
			var classObject:Class = ClassUtils.forName(id);

			return classObject;
		}

		public static function getInstance(id:String, args:Array = null):Object {
			var classObject:Class = getClass(id);

			return ClassUtils.newInstance(classObject, args);
		}

		public static function getConstantPrefix(classObject:Class):String {
			return ClassUtils.getFullyQualifiedName(classObject) + ".";
		}

		public static function isClassOfType(CheckedClass:Class, Type:Class):Boolean {
			var typeName:String = getQualifiedClassName(Type);
			var isDisplayObject:Boolean = describeType(CheckedClass).factory.*.(name() == "extendsClass" || name() == "implementsInterface").(@type == typeName).length() > 0;

			return isDisplayObject;
			//			return (new CheckedClass() is Type);
		}
	}
}
