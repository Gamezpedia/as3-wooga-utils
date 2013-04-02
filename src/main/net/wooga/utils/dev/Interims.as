package net.wooga.utils.dev {
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	public class Interims {
		private static var _times:Dictionary = new Dictionary();

		public static function init(message:String = "", label:String = ""):String {
			_times[label] = [getTimer()];

			var times:Array = _times[label];
			var startTime:int = times[0];

			message = "interim " + label + " started at " + startTime + "ms: " + message;

			return track(message, label);
		}

		public static function track(message:String = "", label:String = ""):String {
			var time:int = getTimer();
			var times:Array = _times[label];
			var startTime:int = times[0];
			var lastTime:int = times[times.length - 1];
			var sinceStart:int = time - startTime;
			var sinceLast:int = time - lastTime;

			if (sinceStart) {
				message += " >>> total: " + sinceStart + "ms";
			}

			if (sinceLast) {
				message += ", delta: " + sinceLast + "ms";
			}

			times.push(time);

			return message;
		}
	}
}
