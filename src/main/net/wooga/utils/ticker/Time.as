package net.wooga.utils.ticker {
	public class Time {
		public static const SECOND:int = 1000;

		private static const FPS_MEASURE_COUNT:int = 100;

		private var _lastTimeStamp:Number;
		private var _currentTimeStamp:Number;

		private var _timeConstant:Number = 1.0;
		private var _targetFrameRate:Number;
		private var _maxFrameCount:int;
		private var _lastFrameTimes:Array = [];
		private var _currentTime:Number = 0;
		private var _frameRateFactor:Number = 0;
		private var _currentFrameRate:Number = 0;
		private var _averageFrameRate:Number = 0;
		private var _lastFrameTime:Number = 0;
		private var _lastFrameRates:Array = [];
		private var _isRunning:Boolean;

		public function init(startTime:Number, timeStamp:int, targetFrameRate:int = 30, maxFrameCount:int = 20):void {
			_isRunning = true;
			_targetFrameRate = targetFrameRate;
			_maxFrameCount = maxFrameCount;
			_currentTimeStamp = timeStamp;
			_lastTimeStamp = _currentTimeStamp - SECOND / _targetFrameRate;
			_currentTime = startTime;

			e(":::::::::::::::: init time " + _currentTime + " " + _currentTimeStamp);
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

		public function get averageFrameRate():Number {
			return _averageFrameRate;
		}

		public function get targetFrameRate():Number {
			return _targetFrameRate;
		}

		public function set targetFrameRate(value:Number):void {
			_targetFrameRate = value;
		}

		public function get lastFrameTime():Number {
			return _lastFrameTime;
		}

		public function update(timeStamp:int):void {
			if (_isRunning) {
				_lastTimeStamp = _currentTimeStamp;
				_currentTimeStamp = timeStamp;

				_lastFrameTime = (_currentTimeStamp - _lastTimeStamp) * _timeConstant;
				_currentTime += _lastFrameTime;
				updateLastFrameRates();

				_currentFrameRate = calcCurrentFrameRate();
				_frameRateFactor = _targetFrameRate / _currentFrameRate;

				calcAverageFrameRate();
			}
		}

		private function calcAverageFrameRate():void {
			_lastFrameRates.push(_currentFrameRate);

			if (_lastFrameRates.length > FPS_MEASURE_COUNT) {
				_lastFrameRates.shift();
			}

			var sum:Number = 0;

			for each (var fps:Number in _lastFrameRates) {
				sum += fps;
			}

			_averageFrameRate = sum / _lastFrameRates.length;
		}

		private function updateLastFrameRates():void {
			_lastFrameTimes.push(_lastFrameTime);

			if (_lastFrameTimes.length > _maxFrameCount) {
				_lastFrameTimes.shift();
			}
		}

		private function calcCurrentFrameRate():Number {
			var sum:Number = 0;

			for each (var value:Number in _lastFrameTimes) {
				sum += value;
			}

			return _lastFrameTimes.length / sum * SECOND * _timeConstant;
		}
	}
}
