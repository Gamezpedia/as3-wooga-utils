package net.wooga.utils.display {
	import flash.display.MovieClip;
	import flash.utils.Dictionary;

	import net.wooga.utils.types.Assets;
	import net.wooga.utils.types.Displays;

	public class Frames {
		private static var _frames:Dictionary = new Dictionary();

		public static function getFrames(type:String):Vector.<FrameDataVO> {
			if (!_frames[type]) {
				var asset:MovieClip = Assets.getMovieClip(type);
				_frames[type] = Displays.parseTimeline(asset);
			}

			return _frames[type] as Vector.<FrameDataVO>;
		}

		public static function hasFrames(type:String):Boolean {
			return _frames[type] != null;
		}

		public static function addFrames(type:String, frames:Vector.<FrameDataVO>):void {
			_frames[type] = frames;
		}
	}
}
