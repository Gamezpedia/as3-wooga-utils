package net.wooga.utils.ticker {
	public class AbstractTicker implements ITicking {
		protected var _tickers:Array = [];

		public function tick(time:Number = 0):void {
			if (_tickers.length) {
				handleTickers(time);
			}
		}

		protected function handleTickers(time:Number):void {

		}

		public function addCallback(startTime:Number, interval:int, callback:Function, repeats:int, executeAtOnce:Boolean = false):void {
			var ticker:ITicker = new TickerVO(startTime, interval, callback, repeats);
			addTicker(ticker);

			if (executeAtOnce) {
				executeTicker(ticker);
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
	}
}

import net.wooga.utils.ticker.ITicker;

class TickerVO implements ITicker {
	private var _interval:int;
	private var _nextTickAt:Number;
	private var _callback:Function;
	private var _repeats:Number;

	public function TickerVO(startTime:Number, interval:int, callback:Function, repeats:int) {
		_interval = interval;
		_callback = callback;
		_repeats = repeats;
		_nextTickAt = startTime + _interval;
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
		_nextTickAt += _interval;
	}

	public function contains(interval:int, callback:Function):Boolean {
		return _interval == interval && _callback == callback;
	}
}
