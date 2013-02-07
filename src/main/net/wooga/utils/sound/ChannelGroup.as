package net.wooga.utils.sound {

	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;

	public class ChannelGroup{
		private var _muted:Boolean = false;
		private var _volume:Number = 1.0;
		private var _channels:Dictionary = new Dictionary();

		public function add(channel:SoundChannel, sound:Sound, autoRemove:Boolean):void {

			_channels[channel] = sound;

			if (autoRemove && channel) {
				channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			}
		}

		public function remove(channel:SoundChannel):void {
			channel.stop();
			channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);

			delete _channels[channel];
		}

		public function removeAllChannels():void
		{
				for(var channel:* in _channels)
				{
					if(channel)
					var soundChannel:SoundChannel = SoundChannel(channel);
					{
						remove(soundChannel);
					}
				}
			_channels = new Dictionary();
		}

		private function onSoundComplete(event:Event):void {
			var channel:SoundChannel = SoundChannel(event.target);
			remove(channel);
		}

		private function stopSound(channel:SoundChannel):void
		{
			remove(channel);
		}

		public function set volume(value:Number):void {
			_volume = value;

			updateVolume();
		}

		public function get volume():Number {
			return _volume;
		}

		public function set muted(mute:Boolean):void {
			_muted = mute;

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

		private function updateVolume():void {
			var currentVolume:Number = _muted ? 0 : _volume;
			var channel:SoundChannel;

			for (var item:* in _channels) {
				channel = item as SoundChannel;
				channel.soundTransform = new SoundTransform(currentVolume);
			}
		}
	}
}
