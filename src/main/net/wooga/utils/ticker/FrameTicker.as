package net.wooga.utils.ticker {
	public class FrameTicker extends AbstractTicker {
		//public function addCallback(startTime:Number, interval:int, callback:Function, repeats:int, executeAtOnce:Boolean = false):void {
		/*public function addCallback(tick:ITick):void {
			//var tick:ITick = new CallbackTick(callback, interval, repeats);
			addTick(tick);

			if (tick.executeAtOnce) {
				executeTick(tick);
			}
		}*/

		/*public function removeCallback(interval:int, callback:Function):void {
			var tick:ITick = getTick(interval, callback);
			removeTick(tick);
		}

		protected function getTick(tick:int, callback:Function):ITick {
			for each (var ticker:CallbackTick in _ticks) {
				if (ticker.contains(tick, callback)) {
					return ticker;
				}
			}

			return null;
		}*/

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
