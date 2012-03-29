package net.wooga.utils.types {
	public class Strings {
		public static function replacePatterns(text:String, params:Object, leftDelimiter:String, rightDelimiter:String):String {
			for (var key:String in params) {
				var value:String = params[key];
				text = replacePattern(text, key, value, leftDelimiter, rightDelimiter);
			}

			return text;
		}

		public static function replacePattern(text:String, key:String, value:String, leftDelimiter:String, rightDelimiter:String):String {
			var pattern:String = leftDelimiter + key + rightDelimiter;

			if (text != null && text.indexOf(pattern) >= 0) {
				var list:Array = text.split(pattern);
				var result:String = list.join(value);

				return result
			} else {
				return text;
			}
		}

		public static function reverse(targetString:String):String {
			return targetString.split("").reverse().join("");
		}
	}
}
