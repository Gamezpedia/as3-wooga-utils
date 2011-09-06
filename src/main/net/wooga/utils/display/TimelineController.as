package net.wooga.utils.display {
	import flash.display.MovieClip;

	public class TimelineController {
		private var _clip:MovieClip;
		private var _frameOverhead:Number = 0;

		public function get clip():MovieClip {
			return _clip;
		}

		public function set clip(value:MovieClip):void {
			_clip = value;
		}

		public function play(step:Number = 1.0):void {
			if (step <= 0) {
				return;
			}

			_frameOverhead += step % 1;
			var frameSteps:int = int(step);

			if (_frameOverhead >= 1) {
				frameSteps++;
				_frameOverhead--;
			}

			var frame:int = _clip.currentFrame + frameSteps;
			frame %= _clip.totalFrames;
			frame ||= _clip.totalFrames;

			_clip.gotoAndStop(frame);
		}
	}
}
