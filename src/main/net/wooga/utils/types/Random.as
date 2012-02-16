package net.wooga.utils.types {
	/**
	 *   A random number generator
	 *   @author Jackson Dunstan
	 */
	public class Random
	{
		/** Current seed value */
		private static var _seed:int = 0;

		/**
		 *   Get the current seed value
		 *   @return The current seed value
		 */
		public static function get seed(): int
		{
			return _seed;
		}

		/**
		 *   Set the current seed value
		 *   @param seed The current seed value
		 */
		public static function set seed(seed:int): void
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
	}
}