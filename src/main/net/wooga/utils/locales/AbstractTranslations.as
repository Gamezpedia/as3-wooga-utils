package net.wooga.utils.locales {
	import net.wooga.utils.types.Strings;

	public class AbstractTranslations {
		private var _locale:String;
		private var _textMap:Object;

		public function get locale():String {
			return _locale;
		}

		public function set locale(value:String):void {
			_locale = value;
		}

		public function set textMap(value:Object):void {
			_textMap = value;
		}

		public function getText(text:String, params:Object = null, left:String = null, right:String = null):String {
			text = Strings.replacePatterns(text, params, left, right);

			while (_textMap[text]) {
				text = Strings.replacePatterns(_textMap[text], params, left, right);
			}

			return text;
		}


		public function hasKey(key:String):Boolean {
			return key in _textMap;
		}
	}
}
