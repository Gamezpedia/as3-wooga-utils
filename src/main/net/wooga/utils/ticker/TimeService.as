package net.wooga.utils.ticker {
	import flash.events.Event;
	import flash.utils.getTimer;

	public class TimeService {
		private var _startTime:Number;
		private var _lastTime:Number;
		private var _targetFrameRate:Number;
		private var _maxFrameCount:int;
		private var _lastFrameTimes:Array = [];
		private var _timeNow:Number = 0;
		private var _frameRateFactor:Number = 0;
		private var _currentFrameRate:Number = 0;

		public function init(startTime:Number, targetFrameRate:int, maxFrameCount:int = 20):void {
			_startTime = _lastTime = startTime - getTimer();
			_targetFrameRate = targetFrameRate;
			_maxFrameCount = maxFrameCount;
			_lastFrameTimes.push(1000 / _targetFrameRate);
		}

		public function get timeNow():Number {
			return _timeNow ||= _startTime + getTimer();
		}

		public function get lastTime():Number {
			return _lastTime;
		}

		public function get frameRateFactor():Number {
			return _frameRateFactor ||= _targetFrameRate / currentFrameRate;
		}

		public function get currentFrameRate():Number {
			return _currentFrameRate ||= calcCurrentFPS();
		}

		public function set targetFrameRate(value:Number):void {
			_targetFrameRate = value;
		}

		public function onEnterFrame(event:Event = null):void {
			_lastFrameTimes.push(timeNow - _lastTime);

			if (_lastFrameTimes.length > _maxFrameCount) {
				_lastFrameTimes.shift();
			}

			_lastTime = timeNow;
			_currentFrameRate = _frameRateFactor = _timeNow = 0;
		}

		private function calcCurrentFPS():Number {
			var sum:Number = 0;

			for each (var value:Number in _lastFrameTimes) {
				sum += value;
			}

			var average:Number = sum / _lastFrameTimes.length;

			return 1000 / average;
		}
	}
}
