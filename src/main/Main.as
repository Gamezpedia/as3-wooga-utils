package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	import net.wooga.utils.display.TimelineController;

	import net.wooga.utils.ticker.TimeService;
	import net.wooga.utils.ticker.TimeTicker;

	[SWF(backgroundColor="#FFFFFF", width="760", height="600", frameRate="30")]
	public class Main extends Sprite {
		private var _time:TimeService;
		private var _ticker:TimeTicker;
		private var _timelineController:TimelineController;
		private var _dir:Number = 1;
		private var _tf:TextField;

		public function Main() {
			initTime();
			initTicker();
			initAsset();

			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}

		private function onKeyDown(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case 191:
					updateTimeConstant(-0.1);
					break;
				case 221:
					updateTimeConstant(0.1);
					break;
			}
		}

		private function updateTimeConstant(delta:Number):void {
			_time.timeConstant += delta;
		}

		private function initTime():void {
			_time = new TimeService();
			_time.init(0, 40);
		}

		private function initTicker():void {
			_ticker = new TimeTicker();
			_ticker.addCallback(25, onTick, int.MAX_VALUE, _time.currentTime);
		}

		private function initAsset():void {
			var clip:MovieClip = new TestAni();
			clip.stop();

			_timelineController = new TimelineController();
			_timelineController.clip = clip;

			addChild(clip);

			_tf = new TextField();
			_tf.autoSize = TextFieldAutoSize.LEFT;
			addChild(_tf);
		}

		private function onEnterFrame(event:Event):void {
			_time.update();
			_ticker.tick(_time.currentTime);
		}

		private function onTick(factor:Number):void {
			var date:Date = new Date(_time.currentTime);
			_tf.htmlText = date.toString();
			
			moveAsset();
		}

		private function moveAsset():void {
			var xPos:Number = _timelineController.clip.x;

			if (xPos <= 0) {
				_dir = Math.abs(_dir);
			} else if (xPos > 400) {
				_dir = -Math.abs(_dir);
			}

			var step:Number = _dir * _time.frameRateFactor;
			_timelineController.clip.x += step;

			_timelineController.play(_time.frameRateFactor);
		}
	}
}
