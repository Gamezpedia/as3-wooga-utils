package net.wooga.utils.types {
	import org.as3commons.collections.framework.IIterable;
	import org.as3commons.collections.framework.IIterator;

	public class Collections {
		public static const EMPTY_ITERATOR:IIterator = new EmptyIterator();
		public static const EMPTY_ITERABLE:IIterable = new EmptyIterable();
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
