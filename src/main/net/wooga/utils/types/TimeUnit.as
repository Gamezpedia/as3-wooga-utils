package net.wooga.utils.types {
	public class TimeUnit {
		public static const SECOND:int = 1000;
		public static const MINUTE:int = 60 * SECOND;
		public static const HOUR:int = 60 * MINUTE;
		public static const DAY:int = 24 * HOUR;
		public static const WEEKS:int = 7 * DAY;

		public static function initMilliSeconds(value:Number):TimeUnit {
			var unit:TimeUnit = new TimeUnit();
			unit.milliSeconds = value;

			return unit;
		}

		public static function initSeconds(value:Number):TimeUnit {
			var unit:TimeUnit = new TimeUnit();
			unit.seconds = value;

			return unit;
		}

		public static function initMinutes(value:Number):TimeUnit {
			var unit:TimeUnit = new TimeUnit();
			unit.minutes = value;

			return unit;
		}

		private var _milliSeconds:Number = 0;
		private var _seconds:Number = 0;
		private var _minutes:Number = 0;
		private var _hours:Number = 0;
		private var _days:Number = 0;
		private var _weeks:Number = 0;

		public function get milliSeconds():Number {
			return _milliSeconds;
		}

		public function set milliSeconds(value:Number):void {
			store(value);
		}

		public function get seconds():Number {
			return _seconds;
		}

		public function set seconds(value:Number):void {
			store(value, SECOND);
		}

		public function get minutes():Number {
			return _minutes;
		}

		public function set minutes(value:Number):void {
			store(value, MINUTE);
		}

		public function get hours():Number {
			return _hours;
		}

		public function set hours(value:Number):void {
			store(value, HOUR);
		}

		public function get days():Number {
			return _days;
		}

		public function set weeks(value:Number):void {
			store(value, DAY);
		}

		public function get weeks():Number {
			return _weeks;
		}

		public function set days(value:Number):void {
			store(value, DAY);
		}

		private function store(value:Number, unit:int = 1):void {
			_milliSeconds = value * unit;
			_seconds = _milliSeconds / SECOND;
			_minutes = _milliSeconds / MINUTE;
			_hours = _milliSeconds / HOUR;
			_days = _milliSeconds / DAY;
			_weeks = _milliSeconds / WEEKS;
		}
	}
}
