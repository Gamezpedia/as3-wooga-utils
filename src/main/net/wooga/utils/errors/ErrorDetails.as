package net.wooga.utils.errors {
	public class ErrorDetails {
		public static const CLIENT:String = "client";
		public static const SERVER:String = "server";

		public static const ERROR:String = "error";

		private var _type:String;
		private var _info:String;
		private var _origin:String;
		private var _severity:String;

		public function ErrorDetails(type:String, info:String = "", origin:String = CLIENT, severity:String = ERROR) {
			_type = type;
			_info = info;
			_origin = origin;
			_severity = severity;
		}

		public function get severity():String {
			return _severity;
		}

		public function set severity(value:String):void {
			_severity = value;
		}

		public function get type():String {
			return _type;
		}

		public function get info():String {
			return _info;
		}

		public function get origin():String {
			return _origin;
		}

		public function toString():String {
			return _origin + " > " + _type + ":" + _info;
		}
	}
}
