package net.wooga.utils.ticker {
	import org.as3commons.lang.ArrayUtils;

	public class AbstractTicker {
		protected var _ticks:Array = [];

		public function addTick(tick:ITick):void {
			_ticks.push(tick);

			if (tick.executeAtOnce) {
				executeTick(tick);
			}
		}

		public function removeTick(id:String):void {
			for each (var tick:ITick in _ticks) {
				if (tick.id == id) {
					deleteTick(tick);
					return;
				}
			}
		}

		public function tick(time:Number = 0):void {
			if (_ticks.length) {
				handleTicks(time);
			}
		}

		protected function handleTicks(time:Number):void {

		}

		protected function executeTick(tick:ITick, tickCount:Number = 1):void {
			tick.execute(tickCount);

			if (tick.repeats <= 0) {
				deleteTick(tick);
			}
		}

		private function deleteTick(tick:ITick):void {
			ArrayUtils.removeItem(_ticks, tick);
		}
	}
}
