package net.wooga.utils.display {
	import flash.display.MovieClip;
	import flash.utils.Dictionary;

	public class TimelineController {
		private var _callbacks:Dictionary = new Dictionary();
		private var _clip:MovieClip;
		private var _totalRepeats:int = 1;
		private var _repeatsLeft:int = 1;
		private var _frameOverhead:Number = 0;
		private var _totalFrames:int;
		private var _currentFrame:int;

		public function get clip():MovieClip {
			return _clip;
		}

		public function set clip(value:MovieClip):void {
			_clip = value;
			_frameOverhead = 0;
			_totalFrames = _clip.totalFrames;
			_currentFrame = _clip.currentFrame || 1;
			_currentFrame--;
		}

		public function set repeats(value:int):void {
			_totalRepeats = _repeatsLeft = value;
		}

		public function get repeats():int {
			return _totalRepeats;
		}

		public function get totalFrames():int {
			return _totalFrames;
		}

		public function get currentFrame():int {
			return _currentFrame;
		}

		public function addCallback(frame:int, callback:Function):void {
			var callbacks:Dictionary = _callbacks[frame] ||= new Dictionary();
			callbacks[callback] = callback;
		}

		public function removeCallback(frame:int, callback:Function):void {
			var callbacks:Dictionary = getCallbacks(frame);
			delete callbacks[callback];
		}

		public function clearCallbacks():void {
			_callbacks = new Dictionary();
		}

		public function play(step:Number = 1.0):void {
			if (_repeatsLeft && step > 0) {
				var frameSteps:int = calcFrameSteps(step);
				handleFrameSteps(frameSteps);
				_clip.gotoAndStop(_currentFrame);
			}
		}

		private function calcFrameSteps(step:Number):int {
			_frameOverhead += step % 1;
			var frameSteps:int = int(step);

			if (_frameOverhead >= 1) {
				frameSteps++;
				_frameOverhead--;
			}

			return frameSteps;
		}

		private function handleFrameSteps(frameSteps:int):void {
			while (frameSteps--) {
				if (_repeatsLeft) {
					updateCurrentFrame();
					handleCallback();
				} else {
					frameSteps = 0;
				}
			}
		}

		private function updateCurrentFrame():void {
			++_currentFrame;

			if (_currentFrame >= _totalFrames) {
				--_repeatsLeft;
				_currentFrame %= _totalFrames;
				_currentFrame ||= _totalFrames;
			}
		}

		private function handleCallback():void {
			var callbacks:Dictionary = getCallbacks(_currentFrame);

			for each (var callback:Function in callbacks) {
				callback(this);
			}
		}

		private function getCallbacks(frame:int):Dictionary {
			return _callbacks[frame] as Dictionary;
		}
	}
}
