package net.wooga.utils.ticker {
	public class TimeTicker extends AbstractTicker {
		override protected function handleTicks(time:Number):void {
			var ticker:ITick = getFirstTicker();
			var nextTicker:ITick;
			var tickCount:int = 0;

			while (ticker.nextTickAt <= time) {
				tickCount++;
				ticker.resetNextTick();
				updateSorting();

				nextTicker = getFirstTicker();

				if (ticker != nextTicker) {
					executeTick(ticker, tickCount);
					tickCount = 0;
					ticker = nextTicker;
				}
			}

			if (tickCount) {
				executeTick(ticker, tickCount);
			}
		}

		override public function addTick(ticker:ITick):void {
			super.addTick(ticker);

			updateSorting();
		}

		private function updateSorting():void {
			_ticks.sortOn("nextTickAt");
		}

		private function getFirstTicker():ITick {
			return _ticks[0] as ITick;
		}
	}
}
