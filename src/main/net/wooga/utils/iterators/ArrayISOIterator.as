package net.wooga.utils.iterators {
	import net.wooga.utils.types.ArrayISO;

	import org.as3commons.collections.framework.IIterator;

	public class ArrayISOIterator implements IIterator {
		private var _items:ArrayISO;
		private var _currentX:int = 0;
		private var _currentY:int = 0;

		public function ArrayISOIterator(items:ArrayISO) {
			_items = items;
		}

		public function hasNext():Boolean {
			if (currentItem) {
				return true;
			}
			
			return false;
		}

		public function next():* {
			return null;
		}

		private function get currentItem():* {
			return _items.getItem(_currentX, _currentY);
		}

		private function get currentRow():Array {
			return _items.getRow(_currentY);
		}
	}
}
