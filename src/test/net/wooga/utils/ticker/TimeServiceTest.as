package net.wooga.utils.ticker {
	import org.flexunit.asserts.assertEquals;

	public class TimeServiceTest {
		private var _timeService:TimeService;

		[Before]
		public function init():void {
			_timeService = new TimeService();
		}

		[Test]
		public function should_init_service():void {
			var currentTime:Number = 1000;
			var frameRate:int = 20;
			var frameRateFactor:Number = 2;

			_timeService.init(currentTime, frameRate);
			_timeService.targetFrameRate = frameRate * frameRateFactor;

			assertEquals(currentTime, _timeService.timeNow);
			assertEquals(frameRate, _timeService.currentFrameRate);
			assertEquals(frameRateFactor, _timeService.frameRateFactor);
		}
	}
}
