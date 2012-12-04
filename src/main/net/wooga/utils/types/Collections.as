package net.wooga.utils.types {
	import flash.utils.Dictionary;

	import org.as3commons.collections.framework.IIterable;
	import org.as3commons.collections.framework.IIterator;

	public class Collections {
		private static var _emptyTypes:Dictionary = new Dictionary();

		public static function get EMPTY_ITERATOR():IIterator {
			return _emptyTypes[IIterator] ||= new EmptyIterator();
		}

		public static function get EMPTY_ITERABLE():IIterable {
			return _emptyTypes[IIterable] ||= new EmptyIterable();
		}
	}
}

import net.wooga.utils.types.Collections;

import org.as3commons.collections.framework.IIterable;
import org.as3commons.collections.framework.IIterator;

class EmptyIterator implements IIterator {
	public function hasNext():Boolean {
		return false;
	}

	public function next():* {
		return null;
	}
}

class EmptyIterable implements IIterable {
	public function iterator(cursor:* = null):IIterator {
		return Collections.EMPTY_ITERATOR;
	}
}
