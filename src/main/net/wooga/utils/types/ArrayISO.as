package net.wooga.utils.types {
	import net.wooga.utils.iterators.ArrayISOIterator;

	import org.as3commons.collections.framework.IIterator;

	public class ArrayISO extends Array2D {
		override public function iterator(cursor:* = null):IIterator {
			return new ArrayISOIterator(this);
		}
	}
}
