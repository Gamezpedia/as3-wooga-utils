package net.wooga.utils.iterators {
	import net.wooga.utils.types.Array2D;

	import org.as3commons.collections.framework.IIterator;

	public class Array2DIterator implements IIterator {
		public static const NO_NEXT_ERROR:String = "has no next item";

		private var _items:Array2D;
		private var _currentX:int = 0;
		private var _currentY:int = 0;

		public function Array2DIterator(array2D:Array2D) {
			_items = array2D;
		}

		public function hasNext():Boolean {
			if (currentItem) {
				return true;
			}

			var row:Array = nextNonEmptyRow;

			while(row) {
				if (row.length <= _currentX) {
					_currentX = 0;
					_currentY++;
					row = nextNonEmptyRow;
				} else if (row[_currentX] == null) {
					_currentX++;
				} else {
					return true;
				}
			}

			return false;
		}

		private function get nextNonEmptyRow():Array {
			while(!currentRow || !currentRow.length) {
				_currentY++;

				if (!_items || _currentY >= _items.length) {
					break;
				}
			}

			return currentRow;
		}

		private function get currentItem():* {
			return _items.getItem(_currentX, _currentY);
		}

		public function next():* {
			if (hasNext()) {
				var item:* = currentItem;
				++_currentX;

				return item;
			} else {
				throw new Error(NO_NEXT_ERROR);

				return null;
			}
		}

		private function get currentRow():Array {
			return _items.getRow(_currentY);
		}
	}
}
