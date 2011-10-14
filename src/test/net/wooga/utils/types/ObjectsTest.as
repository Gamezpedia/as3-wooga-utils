package net.wooga.utils.types {
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertStrictlyEquals;

	public class ObjectsTest {
		[Test]
		public function should():void {
			var into:Object = { a: 1, b: 2 };
			var from:Object = { b: 4, c: 3 };
			var result:Object = Objects.merge(into, from);

			assertStrictlyEquals(result, into);
			assertEquals(1, result.a);
			assertEquals(4, result.b);
			assertEquals(3, result.c);
		}
	}
}
