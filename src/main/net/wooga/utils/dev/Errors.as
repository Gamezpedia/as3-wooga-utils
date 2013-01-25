package net.wooga.utils.dev {
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.sendToURL;

	public class Errors {
		private static var _url:String;
		private static var _count:uint = 0;

		public static function set url(value:String):void {
			_url = value;
		}

		public static function increaseCount():void {
			_count++;
		}

		public static function get count():uint {
			return _count;
		}

		public static function reportError():void {
			var request:URLRequest = new URLRequest(_url);
			request.method = URLRequestMethod.POST;

			sendToURL(request);
		}
	}
}
