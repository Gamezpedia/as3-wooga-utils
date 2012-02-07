package {
	import net.wooga.utils.dev.Debugging;

	import org.as3commons.logging.level.ERROR;

	public function e(message:*, params:Array = null, owner:Object = "", level:int = ERROR):void {
		Debugging.log(message, params, owner, level);
	}
}
