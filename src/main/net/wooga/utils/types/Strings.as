package net.wooga.utils.types {
	import org.as3commons.lang.StringUtils;

	public class Strings {
		public static function replacePatterns(text:String, params:Object, leftDelimiter:String, rightDelimiter:String):String {
			for (var key:String in params) {
				var value:String = params[key];

				text = replacePattern(text, key, value, leftDelimiter, rightDelimiter);
			}

			return text;
		}

		public static function replacePattern(text:String, key:String, value:String, leftDelimiter:String, rightDelimiter:String):String {
			if (text != null) {
				var pattern:String = leftDelimiter + key + rightDelimiter;

				return StringUtils.replace(text, pattern, value);
			} else {
				return null;
			}
		}
	}
}
