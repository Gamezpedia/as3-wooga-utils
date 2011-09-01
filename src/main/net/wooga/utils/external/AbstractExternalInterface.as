package net.wooga.utils.external {
	import flash.external.ExternalInterface;

	public class AbstractExternalInterface {
		private static const CALLBACK_NAME:String = "callFlash";

		public function AbstractExternalInterface() {
			if (ExternalInterface.available) {
				ExternalInterface.addCallback(CALLBACK_NAME, callFlash);
			}
		}

		private function callFlash(id:String, ... args:Array):void {
			handleCall(id, args);
		}

		protected function handleCall(id:String, args:Array):void {
			throw new Error("override handleCall");
		}

		public function callJS(id:String, args:Array = null):* {
			var result:* = null;

			if (ExternalInterface.available) {
				var params:Array = [id];

				if (args) {
					params = params.concat(args);
				}

				result = ExternalInterface.call.apply(null, args);
			}

			return result;
		}
	}
}
