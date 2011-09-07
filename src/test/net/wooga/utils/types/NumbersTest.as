package net.wooga.utils.types {
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;

	public class NumbersTest {
		[Test]
		public function should_convert_radians_to_degrees():void {
			assertEquals(0, Numbers.convertRadToDegree(0));
			assertEquals(90, Numbers.convertRadToDegree(0.5 * Math.PI));
			assertEquals(180, Numbers.convertRadToDegree(Math.PI));
			assertEquals(360, Numbers.convertRadToDegree(2 * Math.PI));
			assertEquals(720, Numbers.convertRadToDegree(4 * Math.PI));
		}

		[Test]
		public function should_convert_degrees_to_radians():void {
			assertEquals(0, Numbers.convertDegreeToRad(0));
			assertEquals(0.5 * Math.PI, Numbers.convertDegreeToRad(90));
			assertEquals(Math.PI, Numbers.convertDegreeToRad(180));
			assertEquals(2 * Math.PI, Numbers.convertDegreeToRad(360));
			assertEquals(4 * Math.PI, Numbers.convertDegreeToRad(720));
		}

		[Test]
		public function should_constrain_number_between_min_and_max():void {
			assertEquals(1, Numbers.constrain(1, 0, 2));
			assertEquals(0, Numbers.constrain(-1, 0, 2));
			assertEquals(2, Numbers.constrain(3, 0, 2));
		}

		[Test]
		public function should_check_if_number_is_within_min_and_max():void {
			assertTrue(Numbers.isWithin(1, 0, 2));
			assertFalse(Numbers.isWithin(-1, 0, 2));
			assertFalse(Numbers.isWithin(3, 0, 2));
		}

		[Test]
		public function should_return_random_number_between_min_and_max():void {
			var min:Number;
			var max:Number;
			var value:Number;

			for (var i:int = 0; i < 10000; i++) {
				min = Math.random() * Number.MIN_VALUE;
				max = Math.random() * Number.MAX_VALUE;
				value = Numbers.randomNumberBetween(min, max);

				assertTrue(Numbers.isWithin(value, min, max));
			}
		}

		[Test]
		public function should_return_random_int_between_min_and_max():void {
			var min:int;
			var max:int;
			var value:int;

			for (var i:int = 0; i < 10000; i++) {
				min = Math.random() * int.MIN_VALUE;
				max = Math.random() * int.MAX_VALUE;
				value = Numbers.randomIntBetween(min, max);

				assertTrue(Numbers.isWithin(value, min, max));
			}
		}

		[Test]
		public function should_normalize_number():void {
			assertEquals(-1, Numbers.normalize(-3.4));
			assertEquals(1, Numbers.normalize(5.4));
			assertEquals(1, Numbers.normalize(0));
			assertEquals(0, Numbers.normalize(0, true));
		}

		[Test]
		public function should_return_the_proportional_scale_to_fit_one_rect_into_another():void {
			assertEquals(3, Numbers.scaleWithinRect(2, 3, 8, 9));
			assertEquals(2, Numbers.scaleWithinRect(3, 2, 6, 5));
		}
	}
}
