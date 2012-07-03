package net.wooga.utils.external {
	import flash.external.ExternalInterface;

	import net.wooga.utils.interfaces.IExternalInterfaceService;

	public class JavaScriptService {
		private static const CALLBACK_NAME:String = "callFlash";

		private var _service:IExternalInterfaceService

		public function JavaScriptService(service:IExternalInterfaceService) {
			_service = service;

			if (ExternalInterface.available) {
				ExternalInterface.addCallback(CALLBACK_NAME, callFlash);
			}
		}

		private function callFlash(id:String, ...args:Array):void {
			_service.handleCall(id, args);
		}

		public function callJS(id:String, args:Array = null):* {
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
