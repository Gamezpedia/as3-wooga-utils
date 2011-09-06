package net.wooga.utils.ticker {
	public class TimeTicker extends AbstractTicker {
		override protected function handleTickers(time:Number):void {
			var ticker:ITicker = getFirstTicker();
			var nextTicker:ITicker;
			var tickCount:int = 0;

			while (ticker.nextTickAt <= time) {
				tickCount++;
				ticker.resetNextTick();
				updateSorting();

				nextTicker = getFirstTicker();

				if (ticker != nextTicker) {
					executeTicker(ticker, tickCount);
					tickCount = 0;
					ticker = nextTicker;
				}
			}

			if (tickCount) {
				executeTicker(ticker, tickCount);
			}
		}

		override protected function addTicker(ticker:ITicker):void {
			super.addTicker(ticker);

			updateSorting();
		}

		private function updateSorting():void {
			_tickers.sortOn("nextTickAt");
		}

		private function getFirstTicker():ITicker {
			return _tickers[0] as ITicker;
		}
	}
}
