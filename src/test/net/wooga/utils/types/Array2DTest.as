package net.wooga.utils.types {
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;

	public class Array2DTest {
		private var _array:Array2D;

		[Before]
		public function init():void {
			_array = new Array2D(4, 3);
		}

		[Test]
		public function should_retrieve_items_by_x_and_y():void {
			_array.items = [null, [null, 3], null];

			assertNull(_array.getItem(0, 0));
			assertEquals(3, _array.getItem(1, 1));
			assertNull(_array.getItem(2, 1));

			_array.addItem(5, 3, 2);
			assertEquals(5, _array.getItem(3, 2));

			_array.addItem(5, 3, 3);
			assertNull(_array.getItem(3, 3));
		}
	}
}
