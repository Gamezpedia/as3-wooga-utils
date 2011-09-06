package net.wooga.utils.ticker {
	public class AbstractTicker implements ITicking {
		protected var _tickers:Array = [];

		public function tick(time:Number):void {

		}

		public function addCallback(tick:int, callback:Function, repeats:int, time:Number = 0, executeAtOnce:Boolean = false):void {
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
			_tickers.push(ticker);
		}

		protected function getTicker(tick:int, callback:Function):ITicker {
			for each (var ticker:ITicker in _tickers) {
				if (ticker.contains(tick, callback)) {
					return ticker;
				}
			}

			return null;
		}

		protected function removeTicker(ticker:ITicker):void {
			var index:int = _tickers.indexOf(ticker);

			if (index >= 0) {
				_tickers.splice(index, 1);
			}
		}

		protected function executeTicker(ticker:ITicker, tickCount:Number = 1):void {
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

	public function set nextTickAt(value:Number):void {
		_nextTickAt = value;
	}

	public function execute(factor:Number):void {
		if (factor > _repeats) {
			factor = _repeats;
		}

		_repeats -= factor;
		_callback(factor);
	}

	public function resetNextTick():void {
		_nextTickAt += _tick;
	}

	public function contains(tick:int, callback:Function):Boolean {
		return _tick == tick && _callback == callback;
	}
}
