package net.wooga.utils.ticker {
	public class FrameTicker extends AbstractTicker {
		override protected function handleTicks(frameFactor:Number):void {
			for each (var ticker:ITick in _ticks) {
				--ticker.nextTickAt;

				if (!ticker.nextTickAt) {
					executeTick(ticker, frameFactor);
					ticker.resetNextTick();
				}
			}
		}
	}
}
