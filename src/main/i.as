package {
	import net.wooga.utils.dev.Debugging;

	import org.as3commons.logging.level.INFO;

	public function i(message:*, params:Array = null, owner:Object = "", level:int = INFO):void {
		Debugging.log(message, params, owner, level);
	}
}
