package net.wooga.utils.display {
	import flash.display.MovieClip;
	import flash.utils.Dictionary;

	import net.wooga.utils.types.Assets;
	import net.wooga.utils.types.Displays;

	public class Frames {
		private static var _frames:Dictionary = new Dictionary();

		public static function getFrames(type:String, colors:Dictionary = null):Vector.<FrameDataVO> {
			var id:String = createFrameId(type, colors);

			if (!_frames[id]) {
				var asset:MovieClip = Assets.getMovieClip(type);
				_frames[id] = Displays.parseTimeline(asset, colors);
			}

			return _frames[id] as Vector.<FrameDataVO>;
		}

		private static function createFrameId(type:String, colors:Dictionary):String {
			for (var key:String in colors) {
				type += "_" + key;
			}

			return type;
		}

		public static function hasFrames(type:String):Boolean {
			return _frames[type] != null;
		}

		public static function addFrames(type:String, frames:Vector.<FrameDataVO>):void {
			_frames[type] = frames;
		}
	}
}
