package net.wooga.utils.external {
	import flash.external.ExternalInterface;

	import net.wooga.utils.interfaces.IExternalHandler;
	import net.wooga.utils.interfaces.IExternalService;

	public class JavaScriptService implements IExternalService {
		private static const CALLBACK_NAME:String = "callFlash";

		private var _handler:IExternalHandler;

		public function JavaScriptService(handler:IExternalHandler) {
			_handler = handler;

			if (ExternalInterface.available) {
				ExternalInterface.addCallback(CALLBACK_NAME, callFlash);
			}
		}

		private function callFlash(id:String, ...args:Array):void {
			_handler.handleCall(id, args);
		}

		public function call(id:String, args:Array = null):* {
			var result:* = null;

			if (ExternalInterface.available) {
				args ||= [];
				args.unshift(id);

				result = ExternalInterface.call.apply(null, args);
			}

			return result;
		}
	}
}
