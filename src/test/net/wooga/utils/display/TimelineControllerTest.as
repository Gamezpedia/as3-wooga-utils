package net.wooga.utils.display {
	import flash.display.MovieClip;

	import org.flexunit.asserts.assertEquals;

	public class TimelineControllerTest {
		private var _timeline:TimelineController;

		[Before]
		public function init():void {
			_timeline = new TimelineController();
		}

		[Test]
		public function should_set_clip():void {
			var clip:MovieClip = new MovieClip();
			_timeline.player = clip;

			assertEquals(clip, _timeline.player);
			assertEquals(clip.totalFrames, _timeline.totalFrames);

			var currentFrame:int = Math.max(0, clip.currentFrame - 1);
			assertEquals(currentFrame, _timeline.currentFrame);
		}

		[Test]
		public function should_execute_callback():void {
			runTimeline(0, 0);
			runTimeline(1, 2);
			runTimeline(2, 1);
			runTimeline(2, 2);
			runTimeline(5, 2);
		}

		private function runTimeline(steps:int, repeats:int):void {
			var calls:int = 0;

			var callback:Function = function(timeline:TimelineController):void {
				calls++;
			};

			_timeline.addCallback(1, callback);
			_timeline.repeats = repeats;
			_timeline.player = new MovieClip();
			_timeline.play(steps);

			var expectedCalls:int = Math.min(steps, repeats);
			assertEquals(expectedCalls, calls);
		}
	}
}
