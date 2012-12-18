package net.wooga.utils.ticker {
	public class TimeTicker extends AbstractTicker {
		override protected function handleTicks(time:Number):void {
			var ticker:ITick = getFirstTicker();

			while (ticker && ticker.nextTickAt <= time) {
				executeTick(ticker, 1);
				ticker.resetNextTick();
				updateSorting();

				ticker = getFirstTicker();
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
