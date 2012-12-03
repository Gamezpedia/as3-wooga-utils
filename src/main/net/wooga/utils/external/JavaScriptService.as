package net.wooga.utils.external {
	import flash.external.ExternalInterface;

	import net.wooga.utils.interfaces.IExternalHandler;
	import net.wooga.utils.interfaces.IExternalService;

	public class JavaScriptService implements IExternalService {
		private var _handler:IExternalHandler;
		private var _callbackName:String;

		public function JavaScriptService(handler:IExternalHandler = null, callbackName:String = null) {
			_handler = handler;

			if (callbackName && ExternalInterface.available) {
				_callbackName = callbackName;
				ExternalInterface.addCallback(callbackName, callFlash);
			}
		}

		private function callFlash(id:String, ...args:Array):void {
			_handler && _handler.handleCall(id, args);
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
