package net.wooga.utils.types {
	public class Bits {
		public static function isTreshholdInValue(treshHold:int, value:int):Boolean {
			return ((treshHold & value) == treshHold);
		}
	}
}
