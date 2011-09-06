package net.wooga.utils.ticker {
	public class FrameTicker extends AbstractTicker {
		override protected function handleTickers(time:Number):void {
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
