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
			_timeline.clip = clip;

			assertEquals(clip, _timeline.clip);
			assertEquals(clip.totalFrames, _timeline.totalFrames);
			assertEquals(clip.currentFrame, _timeline.currentFrame);
		}

		[Test]
		public function should_execute_callback():void {
			runTimeline(0, 0);
			runTimeline(1, 1);
			runTimeline(5, 2);
		}

		private function runTimeline(steps:int, loops:int):void {
			_timeline.loops = loops;

			var calls:int = 0;

			var callback:Function = function(timeline:TimelineController):void {
				calls++;
			};

			_timeline.addCallback(1, callback);
			_timeline.clip = new MovieClip();

			_timeline.play(steps);

			var expectedCalls:int = Math.min(steps, loops + 1);
			assertEquals(expectedCalls, calls);
		}
	}
}
