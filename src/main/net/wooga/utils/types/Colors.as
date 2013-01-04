package net.wooga.utils.types {
	import flash.geom.ColorTransform;

	public class Colors {
		public static function transform(color:uint = 0, alpha:Number = 1.0, offset:uint = 0):ColorTransform {
			var bitmask:uint = 0xFF;
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.redOffset = (color >> 16) - offset;
			colorTransform.greenOffset = (color >> 8 & bitmask) - offset;
			colorTransform.blueOffset = (color & bitmask & bitmask) - offset;
			colorTransform.alphaMultiplier = alpha;

			return colorTransform;
		}
	}
}
