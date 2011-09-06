package net.wooga.utils.ticker {
	public class FrameTicker extends AbstractTicker {
		override public function tick(time:Number):void {
			if (!_tickers.length) {
				return;
			}

			for each (var ticker:ITicker in _tickers) {
				ticker.nextTickAt--;
				
				if (!ticker.nextTickAt) {
					executeTicker(ticker);
					ticker.resetNextTick();
				}
			}
		}
	}
}
