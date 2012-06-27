package net.wooga.utils.types {
	/**
	 *   A random number generator
	 *   @author Jackson Dunstan
	 */
	public class Random
	{
		/** Current seed value */
		private static var _seed:Number = 0; //changed type to Number to prevent integer overflow (asc 24/4/12)

		/**
		 *   Get the current seed value
		 *   @return The current seed value
		 */
		public static function get seed(): Number
		{
			return _seed;
		}

		/**
		 *   Set the current seed value
		 *   @param seed The current seed value
		 */
		public static function set seed(seed:Number): void
		{
			_seed = seed;
		}

		/**
		 *   Get the next integer in the pseudo-random sequence
		 *   @param n (optional) Maximum value
		 *   @return The next integer in the pseudo-random sequence
		 */
		public static function getInt(n:int = int.MAX_VALUE): int
		{
			return n > 0 ? getNumber() * n : getNumber();
		}

		/**
		 *   Get the next random number in the pseudo-random sequence
		 *   @return The next random number in the pseudo-random sequence
		 */
		public static function getNumber(): Number
		{
			_seed = (_seed*9301+49297) % 233280;
			return _seed / 233280.0;
		}

		private var _seed:Number = 0;

		public function Random(seed:Number) {
			_seed = seed;
		}
		
		/**
		 *   Get the current seed value
		 *   @return The current seed value
		 */
		public function get seed(): Number
		{
			return _seed;
		}

		/**
		 *   Set the current seed value
		 *   @param seed The current seed value
		 */
		public function set seed(seed:Number): void
		{
			_seed = seed;
		}

		/**
		 *   Get the next integer in the pseudo-random sequence
		 *   @param n (optional) Maximum value
		 *   @return The next integer in the pseudo-random sequence
		 */
		public function getInt(n:int = int.MAX_VALUE): int
		{
			return n > 0 ? getNumber() * n : getNumber();
		}

		/**
		 *   Get the next random number in the pseudo-random sequence
		 *   @return The next random number in the pseudo-random sequence
		 */
		public function getNumber(): Number
		{
			_seed = (_seed*9301+49297) % 233280;
			return _seed / 233280.0;
		}
	}
}
