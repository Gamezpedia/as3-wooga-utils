package net.wooga.utils.sound {
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;

	public class SoundService {
		public static const INFINITE_LOOP:int = -1;

		private var _sounds:Dictionary = new Dictionary();
		private var _channels:Dictionary = new Dictionary();
		private var _muted:Boolean = false;
		private var _volume:Number = 1.0;

		public function storeSound(id:String, sound:Sound):void {
			_sounds[id] ||= sound;
		}

		public function getSound(id:String):Sound {
			return _sounds[id] as Sound;
		}

		public function playSound(id:String, loops:int = 1, volume:Number = 1.0, startTime:Number = 0, autoRemove:Boolean = true):SoundChannel {
			var sound:Sound = getSound(id);

			return sound ? createChannel(sound, startTime, loops, volume, autoRemove) : null;
		}

		public function removeChannel(channel:SoundChannel):void {
			channel.stop();
			channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			delete _channels[channel];
		}

		public function set volume(value:Number):void {
			_volume = value;

			updateVolume();
		}

		public function get volume():Number {
			return _volume;
		}

		public function set muted(value:Boolean):void {
			_muted = value;

			updateVolume();
		}

		public function get muted():Boolean {
			return _muted;
		}

		public function getTotalTime(channel:SoundChannel):Number {
			return getSoundOfChannel(channel).length;
		}

		private function getSoundOfChannel(channel:SoundChannel):Sound {
			return _channels[channel] as Sound;
		}

		private function createChannel(sound:Sound, startTime:Number, loops:int, volume:Number, autoRemove:Boolean):SoundChannel {
			loops = (loops == INFINITE_LOOP) ? int.MAX_VALUE : loops;
			var transform:SoundTransform = new SoundTransform(volume);
			var channel:SoundChannel = sound.play(startTime, loops, transform);

			if (autoRemove) {
				channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			}

			_channels[channel] = sound;

			return channel;
		}

		private function onSoundComplete(event:Event):void {
			var channel:SoundChannel = SoundChannel(event.target);
			removeChannel(channel);
		}

		private function updateVolume():void {
			var channel:SoundChannel;
			var curentVolume:Number = _muted ? 0 : _volume;

			for (var item:* in _channels) {
				channel = item as SoundChannel;
				channel.soundTransform = new SoundTransform(curentVolume);
			}
		}
	}
}
