package net.wooga.utils.events {
	import flash.events.Event;

	public class InfoEvent extends Event {
		private var _id:String;
		private var _info:*;

		public function InfoEvent(type:String = "", id:String = null, info:* = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type || "", bubbles, cancelable);

			_id = id;
			_info = info;

			//l(this.toString());
		}

		public function get id():String {
			return _id;
		}

		public function get info():* {
			return _info;
		}

		override public function clone():Event {
			return new InfoEvent(type, id, info);
		}

		override public function toString():String {
			var str:String = type;

			if (_id != null) {
				str += " : " + _id;
			}

			if (_info != null) {
				str += " : " + _info.toString();
			}

			return str;
		}
	}
}
