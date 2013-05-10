package net.wooga.utils.errors {
	public class ErrorDetails {
		public static const CLIENT:String = "client";
		public static const SERVER:String = "server";

		private var _type:String;
		private var _info:String;
		private var _origin:String;

		public function ErrorDetails(type:String, info:String = "", origin:String = CLIENT) {
			_type = type;
			_info = info;
			_origin = origin;
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
