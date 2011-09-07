package net.wooga.utils.ticker {
	import flash.utils.getTimer;

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

			_timeService.update();

			assertEquals(currentTime + getTimer(), _timeService.currentTime);
			//assertEquals(frameRate, _timeService.currentFrameRate);
			//assertEquals(Infinity, _timeService.currentFrameRate);
			//assertEquals(0, _timeService.frameRateFactor);
		}
	}
}
