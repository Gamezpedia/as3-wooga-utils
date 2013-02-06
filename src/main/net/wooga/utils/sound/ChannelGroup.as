package net.wooga.utils.sound {
	import com.greensock.TweenMax;

	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;

	import net.wooga.gamex.consts.SoundsConsts;

	public class ChannelGroup{
		private var _muted:Boolean = false;
		private var _volume:Number = 1.0;
		private var _channels:Dictionary = new Dictionary();
		private var _sounds:Dictionary = new Dictionary();
		private var _groupId:String;

		public function add(channel:SoundChannel, sound:Sound, autoRemove:Boolean, groupId:String):void {

			_channels[channel] = sound;
			_sounds[sound] = channel;
			_groupId = groupId;

			if (autoRemove && channel) {
				//sound.addEventListener(ProgressEvent.PROGRESS, onProgress);
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
			if(_groupId == SoundsConsts.MUSIC)
			{
				log("FadeOutMusic");
			}else{
				remove(channel);
			}
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
