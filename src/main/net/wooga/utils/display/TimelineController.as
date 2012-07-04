package net.wooga.utils.display {
	import net.wooga.utils.interfaces.IAnimation;

	public class TimelineController implements IAnimation {
		private var _loops:int = 1;
		private var _loop:int = 0;
		private var _frameOverhead:Number = 0;
		private var _totalFrames:int;
		private var _currentFrame:int;
		private var _setFrameHandler:Function;
		private var _finishedHandler:Function;

		public function init(frameHandler:Function, totalFrames:int, currentFrame:int = 0):void {
			_frameOverhead = 0;
			_setFrameHandler = frameHandler;
			_totalFrames = totalFrames;
			_currentFrame = currentFrame;

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

		public function play(steps:Number = 1.0):void {
			if (_loop < _loops) {
				_frameOverhead += steps % 1;
				var frameSteps:int = int(steps);

				if (_frameOverhead >= 1) {
					++frameSteps;
					_frameOverhead--;
				}

				handleFrameSteps(frameSteps);
				callFrameHandler();
			} else {
				_finishedHandler(this);
			}
		}

		private function callFrameHandler():void {
			if (_setFrameHandler != null) {
				_setFrameHandler(_currentFrame);
			}
		}

		private function handleFrameSteps(frameSteps:int):void {
			while (frameSteps-- && _loop < _loops && updateCurrentFrame()) {
			}
		}

		private function updateCurrentFrame():Boolean {
			if (_currentFrame != _totalFrames - 1) {
				++_currentFrame;
			} else if (_loop < _loops) {
				++_loop;

				if (_loop < _loops) {
					_currentFrame = 0;
				}
			} else {
				return false;
			}

			return true;
		}

		public function set finishedHandler(value:Function):void {
			_finishedHandler = value;
		}
	}
}
