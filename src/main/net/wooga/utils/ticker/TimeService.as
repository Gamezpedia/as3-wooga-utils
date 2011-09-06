package net.wooga.utils.ticker {
	import flash.utils.getTimer;

	public class TimeService {
		private static const SECOND:int = 1000;

		private var _lastTimeStamp:Number;
		private var _currentTimeStamp:Number;

		private var _timeConstant:Number = 1.0;
		private var _targetFrameRate:Number;
		private var _maxFrameCount:int;
		private var _lastFrameTimes:Array = [];
		private var _currentTime:Number = 0;
		private var _frameRateFactor:Number = 0;
		private var _currentFrameRate:Number = 0;

		public function init(startTime:Number, targetFrameRate:int, maxFrameCount:int = 20):void {
			_targetFrameRate = targetFrameRate;
			_maxFrameCount = maxFrameCount;
			_lastTimeStamp = _currentTimeStamp = getTimer();
			_currentTime = startTime + _currentTimeStamp;
		}

		public function set timeConstant(value:Number):void {
			if (value >= 0 && value != _timeConstant) {
				_timeConstant = value;
			}
		}

		public function get timeConstant():Number {
			return _timeConstant;
		}

		public function get currentTime():Number {
			return _currentTime;
		}

		public function get frameRateFactor():Number {
			return _frameRateFactor;
		}

		public function get currentFrameRate():Number {
			return _currentFrameRate;
		}

		public function set targetFrameRate(value:Number):void {
			_targetFrameRate = value;
		}

		public function update():void {
			_lastTimeStamp = _currentTimeStamp;
			_currentTimeStamp = getTimer();

			var timeStep:Number = (_currentTimeStamp - _lastTimeStamp) * _timeConstant;
			//trace("timeStep", timeStep, _currentTimeStamp);
			_currentTime += timeStep;

			updateLastFrameRates(timeStep);
			_currentFrameRate = calcCurrentFrameRate();
			_frameRateFactor = _targetFrameRate / _currentFrameRate * _timeConstant;
		}

		private function updateLastFrameRates(timeStep:Number):void {
			_lastFrameTimes.push(timeStep);
			
			if (_lastFrameTimes.length > _maxFrameCount) {
				_lastFrameTimes.shift();
			}
		}

		private function calcCurrentFrameRate():Number {
			var sum:Number = 0;

			for each (var value:Number in _lastFrameTimes) {
				sum += value;
			}

			return _lastFrameTimes.length / sum * SECOND;
		}
	}
}
