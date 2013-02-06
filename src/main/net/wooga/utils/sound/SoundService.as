package net.wooga.utils.sound {
	import com.greensock.TweenMax;

	import flash.events.Event;

	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	import net.wooga.gamex.consts.SoundsConsts;

	public class SoundService {

		private var _sounds:Dictionary = new Dictionary();
		private var _channelGroups:Dictionary = new Dictionary();
		private var _soundChannels:Dictionary = new Dictionary();

		public function loadSound(id:String, url:String):void {
			var request:URLRequest = new URLRequest(url);
			var context:SoundLoaderContext = new SoundLoaderContext(8000, true);
			var sound:Sound = new Sound();
			sound.load(request, context);
			sound.addEventListener(IOErrorEvent.IO_ERROR, onError);
			storeSound(id, sound);
		}

		private function onError(event:IOErrorEvent):void {
			log("IO Error while loading sound " + event);
		}

		public function storeSound(id:String, sound:Sound):void {
			_sounds[id] ||= sound;
		}

		public function getSound(id:String):Sound {
			return _sounds[id] as Sound;
		}

		//TODO (asc 20/4/12) removed volume parameter, as volume is handled by group now. How do we override group volume settings now?
		public function playSound(id:String, groupId:String = "", loops:int = 1, startTime:Number = 0, autoRemove:Boolean = true):SoundChannel {
			var sound:Sound = getSound(id);
			var channel:SoundChannel;
			if (sound) {
				var group:ChannelGroup = getGroup(groupId);
				var volume:Number = defineVolume(group, groupId);
				channel = createChannel(sound, startTime, loops, volume);
				group.add(channel, sound, autoRemove, groupId);
			}

			return channel;
		}

		private function defineVolume(group:ChannelGroup, groupId:String):Number
		{
			var volume:Number = group.muted ? 0 : group.volume;

			if(groupId == SoundsConsts.MUSIC)
			{
				volume = 0;
			}
			return volume;
		}

		public function removeChannel(channel:SoundChannel, groupId:String = ""):void {
			getGroup(groupId).remove(channel);
		}

		public function setVolume(value:Number, groupId:String = ""):void {
			getGroup(groupId).volume = value;
		}

		public function getVolume(groupId:String = ""):Number {
			return getGroup(groupId).volume;
		}

		public function setMuted(value:Boolean, groupId:String = ""):void {
			getGroup(groupId).muted = value;
		}

		public function isMuted(groupId:String = ""):Boolean {
			return getGroup(groupId).muted;
		}

		public function getTotalTime(channel:SoundChannel, groupId:String = ""):Number {
			return getGroup(groupId).getTotalTime(channel);
		}

		private function createChannel(sound:Sound, startTime:Number, loops:int, volume:Number):SoundChannel {
			loops = (loops == SoundsConsts.INFINITE_LOOP) ? int.MAX_VALUE : loops;
			var transform:SoundTransform = new SoundTransform(volume);
			//sound.addEventListener(ProgressEvent.PROGRESS, onProgress);

			try{
				var channel:SoundChannel = sound.play(startTime, loops, transform);
			}

			TweenMax.to(transform, SoundsConsts.FADE_TIME, {volume:SoundsConsts.VOLUME, onUpdate:fadeIn, onUpdateParams:[channel, transform]});
			addChannel(channel, sound);
			return channel;
		}

		private function fadeIn(channel:SoundChannel, transformation:SoundTransform):void
		{
			log(transformation.volume);
			channel.soundTransform = transformation;
		}

//		private function onProgress(event:ProgressEvent):void
//		{
//			var sound:Sound = Sound(event.target);
//			var loadTime:Number = event.bytesLoaded / event.bytesTotal;
//			var loadedPercent:uint = Math.round(100 * loadTime);
//			log("Loaded" + loadedPercent);
//			if (loadedPercent == 100)
//			{
//				sound.removeEventListener(ProgressEvent.PROGRESS, onProgress);
//				var channel:SoundChannel = _sounds[sound];
//				addEventListener(Event.ENTER_FRAME, onSoundProgress);
//			}
//		}
//
//		private function onSoundProgress(event:ProgressEvent):void
//		{
//			var sound:Sound = Sound(event.target);
//			var channel:SoundChannel = _sounds[sound];
//			var soundTransform:SoundTransform = new SoundTransform(volume);
//			log(sound.length, channel.position + SoundsConsts.FADE_TIME)
//			if(sound.length <= channel.position + SoundsConsts.FADE_TIME){
//				channel.removeEventListener(ProgressEvent.PROGRESS, onSoundProgress);
//				TweenMax.to(soundTransform, SoundsConsts.FADE_TIME,{volume:0, onUpdate:fadeOut, onUpdateParams:[channel, soundTransform]});
//			}
//		}

		private function fadeOut(channel:SoundChannel, transformation:SoundTransform):void
		{
			log("fadeOut");
			channel.soundTransform = transformation;
		}

		public function addChannel(channel:SoundChannel, sound:Sound):void
		{
			_soundChannels[sound] = channel;
		}

		public function getChannel(sound:Sound):SoundChannel
		{
			return _soundChannels[sound];
		}

		public function getGroup(id:String):ChannelGroup
		{
			return _channelGroups[id] ||= new ChannelGroup();
		}
	}
}
