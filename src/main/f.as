package {
	import net.wooga.utils.dev.Debugging;

	import org.as3commons.logging.level.FATAL;

	public function f(message:*, params:Array = null, owner:Object = "", level:int = FATAL):void {
		Debugging.log(message, params, owner, level);
	}
}
