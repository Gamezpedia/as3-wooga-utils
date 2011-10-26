package net.wooga.utils.display {
	import flash.utils.Dictionary;

	public class TimelineController {
		private var _callbacks:Dictionary = new Dictionary();
		private var _loops:int = 1;
		private var _loop:int = 0;
		private var _frameOverhead:Number = 0;
		private var _totalFrames:int;
		private var _currentFrame:int;
		private var _setFrameHandler:Function;

		public function init(handler:Function, totalFrames:int, currentFrame:int = 0):void {
			_setFrameHandler = handler;
			_frameOverhead = 0;
			_totalFrames = totalFrames;
			_currentFrame = currentFrame;

			handleCallback();
			callFrameHandler();
		}

		public function set loops(value:int):void {
			_loops = value;
			_loop = 0;
		}

		public function get loops():int {
			return _loops;
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

		public function play(step:Number):void {
			if (isLooping) {
				var frameSteps:int = calcFrameSteps(step);
				handleFrameSteps(frameSteps);

				callFrameHandler();
			}
		}

		private function callFrameHandler():void {
			if (_setFrameHandler != null) {
				_setFrameHandler(_currentFrame);
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
				if (isLooping && updateCurrentFrame()) {
					handleCallback();
				} else {
					break;
				}
			}

			/*_currentFrame += frameSteps;
			_currentFrame %= _totalFrames;
			handleCallback();*/
		}

		private function updateCurrentFrame():Boolean {
			if (_currentFrame != _totalFrames - 1) {
				++_currentFrame;
			} else if (isLooping) {
				++_loop;

				if (isLooping) {
					_currentFrame = 0;
				}
			} else {
				return false;
			}

			return true;
		}

		private function get isLooping():Boolean {
			return _loop < _loops;
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
