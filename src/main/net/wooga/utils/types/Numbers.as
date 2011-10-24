package net.wooga.utils.types {
	public class Numbers {
		private static const RAD_TO_DEG:Number = 180 / Math.PI;
		private static const DEG_TO_RAD:Number = Math.PI / 180;

		public static function convertRadToDegree(rad:Number):Number {
			return rad * RAD_TO_DEG;
		}

		public static function convertDegreeToRad(degree:Number):Number {
			return degree * DEG_TO_RAD;
		}

		/**
		 * constrain a value within given boundaries
		 *
		 * @param value value to constrain
		 * @param min lower border
		 * @param max upper border
		 * @return the constrained value
		 */
		public static function constrain(value:Number, min:Number, max:Number):Number {
			if (min > max) {
				var temp:Number = min;
				min = max;
				max = temp;
			}

			if (value <= min) {
				value = min;
			} else if (value >= max) {
				value = max;
			}

			return value;
		}

		public static function isWithin(value:Number, min:Number, max:Number):Boolean {
			return value >= min && value <= max;
		}

		public static function randomNumberBetween(min:Number, max:Number):Number {
			if (min > max) {
				var temp:Number = min;
				min = max;
				max = temp;
			}

			var range:Number = max - min;

			return Math.random() * range + min;
		}

		public static function randomIntBetween(min:int, max:int):int {
			if (min > max) {
				var temp:Number = min;
				min = max;
				max = temp;
			}

			var range:Number = max - min + 1;
			var result:Number = Math.floor(Math.random() * range) + min;

			return int(result % int.MAX_VALUE);
		}

		public static function get randomInt():int {
			return randomIntBetween(int.MIN_VALUE, int.MAX_VALUE);
		}

		public static function get randomNumber():Number {
			return randomNumberBetween(Number.MIN_VALUE, Number.MAX_VALUE);
		}

		public static function normalize(value:Number, keepZero:Boolean = false):int {
			if (!value && keepZero) {
				return 0;
			}

			return value < 0 ? -1 : 1;
		}

		public static function scaleWithinRect(width:Number, height:Number, contWidth:Number, contHeight:Number):Number {
			return Math.min(contWidth / width, contHeight / height);
		}

		public static function roundDecimal(num:Number, precision:int):Number {
			var decimal:Number = Math.pow(10, precision);
			return Math.round(decimal * num) / decimal;
		}
	}
}
