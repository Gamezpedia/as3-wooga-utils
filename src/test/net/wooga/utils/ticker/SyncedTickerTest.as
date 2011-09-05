package net.wooga.utils.ticker {
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;

	public class SyncedTickerTest {
		/*private var _ticker:ITicking;

		[Before]
		public function init():void {
			_ticker = new SyncedTicker();
		}

		[Test]
		public function should_add_and_execute_callback():void {
			var wasCalled:Boolean = false;
			var callback:Function = function():void { wasCalled = true; };
			_ticker.addCallback(100, callback, 1, 0, true);
			assertTrue(wasCalled);
		}

		[Test]
		public function should_execute_callback_on_tick():void {
			var callCount:int = 0;
			var allSteps:int = 0;
			var stepDelta:Number = 0;

			var callback:Function = function(steps:int, delta:Number):void {
				callCount++;
				allSteps = steps;
				stepDelta = delta;
			};

			_ticker.addCallback(500, callback, 10, 0);
			_ticker.tick(10000, 1000);

			assertEquals(callCount, 1);
			assertEquals(allSteps, 2);
			assertEquals(stepDelta, 500);
		}*/
	}
}
