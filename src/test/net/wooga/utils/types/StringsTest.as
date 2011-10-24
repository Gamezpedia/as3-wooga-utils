package net.wooga.utils.types {
	import org.flexunit.asserts.assertEquals;

	public class StringsTest {
		private var _ld:String = "\\[\\[";
		private var _rd:String = "\\]\\]";

		[Test]
		public function should_replace_pattern():void {
			var key:String = "name";
			var value:String = "Joe";
			var text:String = "[[bla]], [[" + key + "]], [[" + key + "]]!";
			var result:String = Strings.replacePattern(text, key, value, _ld, _rd);
			var expected:String = "[[bla]], " + value + ", " + value + "!";

			assertEquals(expected, result);
		}

		[Test]
		public function should_replace_patterns():void {
			var params:Object = { a: 1, b: 2, c: 3 };
			var text:String = "[[d]],[[c]],[[b]],[[c]],[[a]]";
			var result:String = Strings.replacePatterns(text, params, _ld, _rd);
			var expected:String = "[[d]]," + params.c + "," + params.b + "," + params.c + "," + params.a;

			assertEquals(expected, result);
		}

		[Test]
		public function should_reverse_string():void{
			assertEquals("tset", Strings.reverse("test"));
		}
	}
}
