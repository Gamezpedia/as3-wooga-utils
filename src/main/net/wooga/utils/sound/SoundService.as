package net.wooga.utils.sound {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;

	public class SoundService {
		private var _sounds:Dictionary = new Dictionary();

		public function storeSound(id:String, sound:Sound):void {
			_sounds[id] ||= sound;
		}

		public function playSound(id:String):SoundChannel {
			var sound:Sound = _sounds[id] as Sound;

			return sound.play();
		}
	}
}
