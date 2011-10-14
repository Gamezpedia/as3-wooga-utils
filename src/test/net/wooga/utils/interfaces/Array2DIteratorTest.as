package net.wooga.utils.interfaces {
	import net.wooga.utils.types.Array2D;

	import org.as3commons.collections.framework.IIterator;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;

	public class Array2DIteratorTest {
		private var _array:Array2D;

		[Before]
		public function init():void {
			_array = new Array2D(4, 3);
		}

		[Test]
		public function should_iterate():void {
			_array.items = [
				[],
				[null, 3],
				null
			];
			var iterator:IIterator = _array.iterator();

			assertTrue(iterator.hasNext());
			assertTrue(iterator.hasNext());
			assertEquals(3, iterator.next());
			assertFalse(iterator.hasNext());
			assertNull(iterator.next());
			assertNull(iterator.next());
			assertNull(iterator.next());
			assertNull(iterator.next());
		}
	}
}
