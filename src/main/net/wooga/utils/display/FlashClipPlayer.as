package net.wooga.utils.display {
	import flash.display.MovieClip;

	import net.wooga.utils.interfaces.IMoviePlayer;

	public class FlashClipPlayer implements IMoviePlayer {
		private var _timeline:TimelineController = new TimelineController();
		private var _clip:MovieClip;

		public function FlashClipPlayer(clip:MovieClip) {
			_clip = clip;
			_timeline.init(setFrame, _clip.totalFrames, _clip.currentFrame - 1);
		}

		public function play(step:Number):void {
			_timeline.play(step);
		}

		public function set frame(value:int):void {
			//var step:in
		}

		public function get totalFrames():int {
			return _clip.totalFrames;
		}

		public function get currentFrame():int {
			return _clip.currentFrame;
		}

		private function setFrame(frame:int):void {
			_clip.gotoAndStop(frame + 1);
		}
	}
}
