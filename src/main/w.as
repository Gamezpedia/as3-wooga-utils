package {
	import net.wooga.utils.dev.Debugging;

	import org.as3commons.logging.level.WARN;

	public function w(message:*, params:Array = null, owner:Object = "", level:int = WARN):void {
		Debugging.log(message, params, owner, level);
	}
}
