package net.wooga.utils.display {
	import org.flexunit.asserts.assertEquals;

	public class TimelineControllerTest {
		private var _timeline:TimelineController;

		[Before]
		public function init():void {
			_timeline = new TimelineController();
		}

		[Test]
		public function should_init_conntroller():void {
			var totalFrames:int = 15;

			_timeline.initPlayerData(totalFrames);

			assertEquals(totalFrames, _timeline.totalFrames);
			assertEquals(0, _timeline.currentFrame);
		}

		[Test]
		public function should_call_frame_setter():void {
			_timeline.initPlayerData(10);

			var calls:int = 0;

			var callback:Function = function(frame:Object):void {
				calls++;
			};

			_timeline.onSetFrame = callback;
			_timeline.play(1);
			assertEquals(1, calls);

			_timeline.play(5);
			assertEquals(2, calls);

			_timeline.play(1);
			_timeline.play(1);
			assertEquals(4, calls);
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

			_timeline.initPlayerData(1, 0);
			_timeline.addCallback(1, callback);
			_timeline.repeats = repeats;
			_timeline.play(steps);

			var expectedCalls:int = Math.min(steps, repeats);
			assertEquals(expectedCalls, calls);
		}
	}
}
