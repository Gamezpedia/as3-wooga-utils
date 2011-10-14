package net.wooga.utils.types {
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.fail;

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

		[Test]
		public function should_not_fit_items_into_array():void {
			try {
				_array.items = [null, null, null, null, null];

				fail("should fail");
			} catch (error:Error) {
				assertEquals(Array2D.ITEMS_TOO_BIG_ERROR, error.message);
			}
		}
	}
}
