package net.wooga.utils.logging {
	import flash.utils.Dictionary;

	import net.wooga.utils.external.JavaScriptService;
	import net.wooga.utils.interfaces.IExternalService;

	import org.as3commons.logging.level.DEBUG;
	import org.as3commons.logging.level.ERROR;
	import org.as3commons.logging.level.FATAL;
	import org.as3commons.logging.level.INFO;
	import org.as3commons.logging.level.WARN;
	import org.as3commons.logging.setup.ILogTarget;

	public class JSConsoleTarget implements ILogTarget {
		private var _levels:Dictionary = new Dictionary();
		private var _service:IExternalService = new JavaScriptService();

		public function JSConsoleTarget() {
			_levels[DEBUG] = "debug";
			_levels[INFO] = "info";
			_levels[WARN] = "warn";
			_levels[ERROR] = "error";
			_levels[FATAL] = "error";
		}

		public function log(name:String, shortName:String, level:int, timeStamp:Number, message:*, parameters:Array, person:String):void {
			var data:Object = {};
			data["stack"] = getCallList();

			_service.call("log", [_levels[level], timeStamp, message, data]);
		}

		private function getCallList():Array {
			var error:Error = new Error();
			var stackTrace:String = error.getStackTrace();
			var stackList:Array = stackTrace.split("\n");
			var removeCount:int = 7;

			for (var i:int = 0; i < removeCount; ++i) {
				stackList.shift();
			}

			var callList:Array = [];

			for each (var line:String in stackList) {
				var call:String = parseStackLine(line);
				callList.push(call);
			}

			return callList;
		}

		private function parseStackLine(line:String):String {
			var list:Array = line.split(" ");
			var cleanLine:String = list[list.length - 1];
			var list2:Array = cleanLine.split("[");
			var call:String = list2[0];

			if (list2.length > 1) {
				var file:String = list2[1];
				var list3:Array = file.split(":");
				var tail:String = list3[1];
				var list4:Array = tail.split("]");
				var number:String = list4[0];
				call += ":" + number
			}

			return call;
		}
	}
}
