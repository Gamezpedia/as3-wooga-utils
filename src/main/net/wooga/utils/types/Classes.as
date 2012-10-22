package net.wooga.utils.types {
	import flash.system.ApplicationDomain;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	import org.as3commons.lang.ClassUtils;

	public class Classes {
		public static function getClass(id:String):Class {
			var classObject:Class;

			if (ApplicationDomain.currentDomain.hasDefinition(id)) {
				classObject = getDefinitionByName(id) as Class;
			}

			return classObject;
		}

		public static function getInstance(id:String, args:Array = null):Object {
			var classObject:Class = getClass(id);
			var classInstance:Object;

			if (classObject) {
				classInstance = ClassUtils.newInstance(classObject, args);
			} else {
				e("no class for " + id);
			}

			return classInstance;
		}

		public static function getConstantPrefix(classObject:Class):String {
			return ClassUtils.getFullyQualifiedName(classObject) + ".";
		}

		public static function isClassOfType(CheckedClass:Class, Type:Class):Boolean {
			var typeName:String = getQualifiedClassName(Type);
			var isDisplayObject:Boolean = describeType(CheckedClass).factory.*.(name() == "extendsClass" || name() == "implementsInterface").(@type == typeName).length() > 0;

			return isDisplayObject;
		}
	}
}
