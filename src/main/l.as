package {
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;
	import org.as3commons.logging.level.DEBUG;
	import org.as3commons.logging.level.ERROR;
	import org.as3commons.logging.level.FATAL;
	import org.as3commons.logging.level.INFO;
	import org.as3commons.logging.level.WARN;

	public function l(message:String, level:int = 0x0020, owner:Object = ""):void {
		var logger:ILogger = getLogger(owner);

		if (level <= FATAL && logger.fatalEnabled) {
			logger.fatal(message);
		} else if (level <= ERROR && logger.errorEnabled) {
			logger.error(message);
		} else if (level <= WARN && logger.warnEnabled) {
			logger.warn(message);
		} else if (level <= INFO && logger.infoEnabled) {
			logger.info(message);
		} else if (level <= DEBUG && logger.debugEnabled) {
			logger.debug(message);
		}
	}
}
