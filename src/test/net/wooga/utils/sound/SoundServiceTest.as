package net.wooga.utils.sound {
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	import org.flexunit.asserts.assertEquals;

	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertStrictlyEquals;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.rules.IMethodRule;
	import org.mockito.integrations.any;
	import org.mockito.integrations.flexunit4.MockitoRule;
	import org.mockito.integrations.given;
	import org.mockito.integrations.verify;

	public class SoundServiceTest {
		[Rule]
		public var mockitoRule:IMethodRule = new MockitoRule();

		[Mock]
		public var sound:Sound;

		public var soundChannel:SoundChannel = new SoundChannel();

		private var _sounds:SoundService;
		private var _anyId:String = "anyId";

		[Before]
		public function init():void {
			_sounds = new SoundService();
		}

		[Test]
		public function should_return_channel():void {
			var channel:SoundChannel = createChannel();
			assertStrictlyEquals(_sounds.getSound(_anyId), sound);
			assertNotNull(channel);
		}

		[Test]
		public function should_not_return_channel():void {
			var channel:SoundChannel = _sounds.playSound("anyId");
			assertNull(channel);
		}

		[Test]
		public function should_remove_channel():void {
			var channel:SoundChannel = createChannel();
			_sounds.removeChannel(channel);

			verify().that(channel.stop());
			verify().that(channel.removeEventListener(Event.SOUND_COMPLETE, function():void{}));
		}

		[Test]
		public function should_get_total_time():void {
			var totalTime:Number = 1000;
			given(sound.length).willReturn(totalTime);

			var channel:SoundChannel = createChannel();
			var soundTotalTime:Number = _sounds.getTotalTime(channel);

			assertEquals(soundTotalTime, totalTime);
		}

		[Test]
		public function should_update_volume():void {
			var channel:SoundChannel = createChannel();
			assertEquals(channel.soundTransform.volume, 1);

			var volume:Number = 0.5;
			_sounds.volume = volume;
			assertEquals(_sounds.volume, volume);
			assertEquals(channel.soundTransform.volume, volume);
		}

		[Test]
		public function should_mute_volume():void {
			var channel:SoundChannel = createChannel();
			assertEquals(channel.soundTransform.volume, 1);
			_sounds.muted = true;
			assertTrue(_sounds.muted);
			assertEquals(channel.soundTransform.volume, 0);
		}

		private function createChannel():SoundChannel {
			given(sound.play(any(), any(), any())).willReturn(soundChannel);

			_sounds.storeSound(_anyId, sound);
			var channel:SoundChannel = _sounds.playSound(_anyId);
			return channel;
		}
	}
}
