package net.wooga.utils.display {
	import org.flexunit.asserts.assertEquals;

	public class TimelineControllerTest {
		private var _timeline:TimelineController;

		[Before]
		public function init():void {
			_timeline = new TimelineController();
		}

		[Test]
		public function should_init_controller():void {
			var totalFrames:int = 15;

			_timeline.init(null, totalFrames);

			assertEquals(totalFrames, _timeline.totalFrames);
			assertEquals(0, _timeline.currentFrame);
		}

		[Test]
		public function should_call_frame_setter():void {
			var calls:int = 0;
			var lastFrame:int = 0;

			var callback:Function = function(frame:int):void {
				calls++;
				lastFrame = frame;
			};

			_timeline.init(callback, 10);
			assertEquals(1, calls);
			assertEquals(0, lastFrame);

			_timeline.play(1);
			assertEquals(2, calls);
			assertEquals(1, lastFrame);

			_timeline.play(7);
			assertEquals(3, calls);
			assertEquals(8, lastFrame);

			_timeline.play(2);
			assertEquals(4, calls);
			assertEquals(9, lastFrame);
		}

		[Test]
		public function should_play_to_last_frame():void {
			var lastFrame:int;

			var callback:Function = function(frame:int):void {
				lastFrame = frame;
			};

			_timeline.init(callback, 10);

			_timeline.play(1);
			assertEquals(1, lastFrame);

			_timeline.play(10);
			assertEquals(9, lastFrame);
		}

		[Test]
		public function should_loop():void {
			var lastFrame:int;

			var callback:Function = function(frame:int):void {
				lastFrame = frame;
			};

			_timeline.init(callback, 3);
			_timeline.loops = 10;

			_timeline.play(1);
			assertEquals(1, lastFrame);

			_timeline.play(1);
			assertEquals(2, lastFrame);

			_timeline.play(1);
			assertEquals(0, lastFrame);

			_timeline.play(1);
			assertEquals(1, lastFrame);

			_timeline.play(4);
			assertEquals(2, lastFrame);
		}
	}
}
