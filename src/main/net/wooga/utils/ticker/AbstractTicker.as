package net.wooga.utils.ticker {
	public class AbstractTicker implements ITicking {
		public function tick(time:Number):void {

		}

		public function addCallback(tick:int, callback:Function, repeats:int, time:Number, executeAtOnce:Boolean = false):void {
			var ticker:ITicker = createTicker(tick, callback, repeats, time);
			addTicker(ticker);

			if (executeAtOnce) {
				executeTicker(ticker, 1);
			}
		}

		public function removeCallback(tick:int, callback:Function):void {
			var ticker:ITicker = getTicker(tick, callback);
			removeTicker(ticker);
		}

		protected function addTicker(ticker:ITicker):void {

		}

		protected function getTicker(tick:int, callback:Function):ITicker {
			return null;
		}

		protected function removeTicker(ticker:ITicker):void {

		}

		protected function executeTicker(ticker:ITicker, tickCount:Number):void {
			ticker.execute(tickCount);

			if (ticker.repeats <= 0) {
				removeTicker(ticker);
			}
		}

		private function createTicker(tick:int, callback:Function, repeats:int, time:Number):ITicker {
			return new TickerVO(tick, callback, repeats, time);
		}
	}
}

import net.wooga.utils.ticker.ITicker;

class TickerVO implements ITicker {
	private var _tick:int;
	private var _nextTickAt:Number;
	private var _callback:Function;
	private var _repeats:Number;

	public function TickerVO(tick:int, callback:Function, repeats:Number, time:Number) {
		_tick = tick;
		_callback = callback;
		_repeats = repeats;
		_nextTickAt = time + _tick;
	}

	public function get repeats():Number {
		return _repeats;
	}

	public function get nextTickAt():Number {
		return _nextTickAt;
	}

	public function execute(factor:Number):void {
		if (factor > _repeats) {
			factor = _repeats;
		}

		_repeats -= factor;
		_callback(factor);
	}

	public function updateNextTick():void {
		_nextTickAt += _tick;
	}

	public function contains(tick:int, callback:Function):Boolean {
		return _tick == tick && _callback == callback;
	}
}
