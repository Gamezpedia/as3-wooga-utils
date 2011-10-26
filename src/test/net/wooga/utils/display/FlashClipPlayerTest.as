package net.wooga.utils.display {
	import flash.display.MovieClip;

	import org.flexunit.rules.IMethodRule;
	import org.mockito.integrations.flexunit4.MockitoRule;
	import org.mockito.integrations.given;
	import org.mockito.integrations.verify;

	public class FlashClipPlayerTest {
		[Rule]
		public var mockitoRule:IMethodRule = new MockitoRule();

		[Mock]
		public var clip:MovieClip;

		private var player:FlashClipPlayer;

		[Before]
		public function init():void {
			given(clip.totalFrames).willReturn(10);
			given(clip.currentFrame).willReturn(1);

			player = new FlashClipPlayer(clip);
		}

		[Test]
		public function should_play_clip():void {
			var step:Number = 2.5;

			playStep(step, 3);
			playStep(step, 6);
			playStep(step, 8);
			playStep(step, 10);
		}

		private function playStep(step:Number, target:int):void {
			player.play(step);
			verify().that(clip.gotoAndStop(target));
		}
	}
}
