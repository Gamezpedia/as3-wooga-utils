package net.wooga.utils.sound {
	import flash.media.Sound;
	import flash.media.SoundChannel;

	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.rules.IMethodRule;
	import org.mockito.integrations.flexunit4.MockitoRule;
	import org.mockito.integrations.given;

	public class SoundServiceTest {
		[Rule]
		public var mockitoRule:IMethodRule = new MockitoRule();

		[Mock]
		public var sound:Sound;

		private var _sounds:SoundService;

		[Before]
		public function init():void {
			_sounds = new SoundService();
		}

		[Test]
		public function should_return_channel():void {
			var id:String = "anyId";
			_sounds.storeSound(id, sound);

			given(sound.play()).willReturn(new SoundChannel());

			var channel:SoundChannel = _sounds.playSound(id);
			assertNotNull(channel);
		}
	}
}
