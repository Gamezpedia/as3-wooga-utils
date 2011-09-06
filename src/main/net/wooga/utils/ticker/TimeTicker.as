package net.wooga.utils.ticker {
	public class TimeTicker extends AbstractTicker {
		private var _tickers:Array = [];

		override public function tick(time:Number):void {
			if (!_tickers.length) {
				return;
			}

			var ticker:ITicker = getFirstTicker();
			var nextTicker:ITicker;
			var tickCount:int = 0;

			while (ticker.nextTickAt <= time) {
				tickCount++;
				ticker.updateNextTick();
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
			_tickers.push(ticker);
			updateSorting();
		}

		override protected function getTicker(tick:int, callback:Function):ITicker {
			for each (var ticker:ITicker in _tickers) {
				if (ticker.contains(tick,  callback)) {
					return ticker;
				}
			}

			return null;
		}

		override protected function removeTicker(ticker:ITicker):void {
			var index:int = _tickers.indexOf(ticker);

			if (index >= 0) {
				_tickers.splice(index, 1);
			}
		}

		private function updateSorting():void {
			_tickers.sortOn("nextTickAt");
		}

		private function getFirstTicker():ITicker {
			return _tickers[0] as ITicker;
		}
	}
}
