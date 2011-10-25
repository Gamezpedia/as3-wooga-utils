package net.wooga.utils.ticker {
	import flash.utils.getTimer;

	public class TimeTest {
		private var _time:Time;

		[Before]
		public function init():void {
			_time = new Time();
		}

		[Test]
		public function should_init_service():void {
			var currentTime:Number = 1000;
			var frameRate:int = 20;
			var frameRateFactor:Number = 2;

			_time.init(currentTime, frameRate);
			_time.targetFrameRate = frameRate * frameRateFactor;

			_time.update(getTimer());

			//assertEquals(currentTime + getTimer(), _time.currentTime);
			//assertEquals(frameRate, _time.currentFrameRate);
			//assertEquals(Infinity, _time.currentFrameRate);
			//assertEquals(0, _time.frameRateFactor);
		}
	}
}
