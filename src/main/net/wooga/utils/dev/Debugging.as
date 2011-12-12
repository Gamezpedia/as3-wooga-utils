package net.wooga.utils.dev {
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;
	import org.as3commons.logging.level.DEBUG;
	import org.as3commons.logging.level.ERROR;
	import org.as3commons.logging.level.FATAL;
	import org.as3commons.logging.level.INFO;
	import org.as3commons.logging.level.WARN;

	public class Debugging {
		private static var _owners:Array;
		private static var _breakPointHandler:Function;
		private static var _inspectHandler:Function;

		public static function hasOwner(owner:Object):Boolean {
			return _owners.indexOf(owner) != -1;
		}

		public static function set owners(value:Array):void {
			_owners = value;
		}

		public static function set breakPointHandler(value:Function):void {
			_breakPointHandler = value;
		}

		public static function set inspectHandler(value:Function):void {
			_inspectHandler = value;
		}

		public static function setBreakPoint(caller:*, name:String = ""):void {
			if (_breakPointHandler != null) {
				_breakPointHandler(caller, name);
			}
		}

		public static function inspect(object:*):void {
			if (_inspectHandler != null) {
				_inspectHandler(object);
			}
		}

		public static function log(message:*, params:Array = null, owner:Object = "", level:int = DEBUG):void {
			if (hasOwner(owner)) {
				var logger:ILogger = getLogger(owner);

				if (level <= FATAL && logger.fatalEnabled) {
					logger.fatal(message, params);
				} else if (level <= ERROR && logger.errorEnabled) {
					logger.error(message, params);
				} else if (level <= WARN && logger.warnEnabled) {
					logger.warn(message, params);
				} else if (level <= INFO && logger.infoEnabled) {
					logger.info(message, params);
				} else if (level <= DEBUG && logger.debugEnabled) {
					logger.debug(message, params);
				}
			}
		}
	}
}
