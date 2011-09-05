package net.wooga.utils.ticker {
	import org.flexunit.asserts.assertEquals;

	public class TimeTickerTest {
		private var _ticker:ITicking;

		[Before]
		public function init():void {
			_ticker = new TimeTicker();
		}

		[Test]
		public function should_execute_callback_on_tick():void {
			var callCount:int = 0;
			var tickFactor:Number = 0;

			var callback:Function = function(factor:Number):void {
				callCount++;
				tickFactor += factor;
			};

			_ticker.addCallback(1000, callback, 5, 500);
			_ticker.tick(2000);
			assertEquals(1, callCount);
			assertEquals(1, tickFactor);

			_ticker.tick(3500);
			assertEquals(2, callCount);
			assertEquals(3, tickFactor);

			_ticker.tick(10000);
			assertEquals(3, callCount);
			assertEquals(5, tickFactor);
		}
	}
}
