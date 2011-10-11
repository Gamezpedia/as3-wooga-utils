package net.wooga.utils.types {
	import net.wooga.utils.iterators.Array2DIterator;

	import org.as3commons.collections.framework.IIterable;
	import org.as3commons.collections.framework.IIterator;

	public class Array2D implements IIterable {
		private var _items:Array = [];
		private var _maxXLength:int;
		private var _maxYLength:int;

		public function Array2D(maxXLength:int = int.MAX_VALUE, maxYLength:int = int.MAX_VALUE) {
			_maxXLength = maxXLength;
			_maxYLength = maxYLength;
		}

		public function set items(value:Array):void {
			_items = value;
		}

		public function get length():int {
			return _items.length;
		}

		public function addItem(item:*, x:int, y:int):void {
			if (x < _maxXLength && y < _maxYLength) {
				var row:Array = getRow(y, []);
				row[x] = item;
			}
		}

		public function getRow(y:int, defValue:Array = null):Array {
			if (y < _maxYLength) {
				return _items[y] ||= defValue;
			} else {
				return null;
			}
		}

		public function getItem(x:int, y:int):* {
			var row:Array = getRow(y);

			return row ? row[x] : null;
		}

		public function iterator(cursor:* = null):IIterator {
			return new Array2DIterator(this);
		}
	}
}
