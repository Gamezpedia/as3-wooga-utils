package {
	import net.wooga.utils.dev.Debugging;

	import org.as3commons.logging.level.DEBUG;

	public function l(message:*, params:Array = null, owner:Object = "", level:int = DEBUG):void {
		Debugging.log(message, params, owner, level);
	}
}
