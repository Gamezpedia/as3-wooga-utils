package net.wooga.utils.events {
	import flash.events.Event;

	public class InfoEvent extends Event {
		private static var _cache:Vector.<InfoEvent> = new <InfoEvent>[];

		public static function create(type:String = "", id:String = null, info:* = null, bubbles:Boolean = false, cancelable:Boolean = false):InfoEvent {
			var event:InfoEvent;

			if (_cache.length) {
				event = _cache.shift() as InfoEvent;
				event.init(type, id, info);
			} else {
				event = new InfoEvent(type, id, info, bubbles, cancelable);
			}

			return event;
		}

		private var _type:String;
		private var _id:String;
		private var _info:*;

		public function InfoEvent(type:String = "", id:String = null, info:* = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super("", bubbles, cancelable);

			init(type, id, info);
		}

		public function init(type:String, id:String, info:*):void {
			_type = type;
			_id = id;
			_info = info;

			//l(this.toString());
		}

		override public function get type():String {
			return _type;
		}

		public function set type(value:String):void {
			_type = value;
		}

		public function get id():String {
			return _id;
		}

		public function get info():* {
			return _info;
		}

		override public function clone():Event {
			return create(_type, _id, _info, bubbles, cancelable);
		}

		override public function toString():String {
			var str:String = _type;

			if (_id != null) {
				str += " : " + _id;
			}

			if (_info != null) {
				str += " : " + _info.toString();
			}

			return str;
		}

		public function store():void {
			if (_cache.indexOf(this) == -1) {
				_cache.push(this);
			}
		}
	}
}
