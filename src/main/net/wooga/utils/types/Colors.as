package net.wooga.utils.types {
	import flash.geom.ColorTransform;

	public class Colors {
		private static const BITMASK:uint = 0xFF;

		public static function transform(color:uint = 0, alpha:Number = 1.0, brightness:Number = 1.0, offset:int = 0):ColorTransform {
			var transform:ColorTransform = new ColorTransform();
			transform.redOffset = (color >> 16) - offset;
			transform.greenOffset = (color >> 8 & BITMASK) - offset;
			transform.blueOffset = (color & BITMASK & BITMASK) - offset;
			transform.redMultiplier *= brightness;
			transform.greenMultiplier *= brightness;
			transform.blueMultiplier *= brightness;
			transform.alphaMultiplier = alpha;

			return transform;
		}
	}
}
