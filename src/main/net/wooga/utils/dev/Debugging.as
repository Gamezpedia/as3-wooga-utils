package net.wooga.utils.dev {
	public class Debugging {
		private static var _breakPointHandler:Function;
		private static var _inspectHandler:Function;

		public static function set breakPointHandler(value:Function):void {
			_breakPointHandler = value;
		}

		public static function set inspectHandler(value:Function):void {
			_inspectHandler = value;
		}

		public static function setBreakPoint(caller:*,  name:String = ""):void {
			if (_breakPointHandler != null) {
				_breakPointHandler(caller, name);
			}
		}

		public static function inspect(object:*):void {
			if (_inspectHandler != null) {
				_inspectHandler(object);
			}
		}
	}
}
