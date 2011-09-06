package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getTimer;

	import net.wooga.utils.display.TimelineController;
	import net.wooga.utils.ticker.FrameTicker;
	import net.wooga.utils.ticker.ITicking;
	import net.wooga.utils.ticker.TimeService;
	import net.wooga.utils.ticker.TimeTicker;

	[SWF(backgroundColor="#FFFFFF", width="760", height="600", frameRate="7")]
	public class Main extends Sprite {
		private var _time:TimeService;
		private var _ticker:ITicking;
		private var _timelineController:TimelineController;
		private var _dir:Number = 5;
		private var _tf:TextField;

		private var _lastTime:Number;

		public function Main() {
			initTime();
			initTimeTicker();
			//initFrameTicker();
			initAsset();

			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}

		private function onKeyDown(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case 191:
					updateTimeConstant(-0.2);
					break;
				case 221:
					updateTimeConstant(0.2);
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

		private function initTimeTicker():void {
			_ticker = new TimeTicker();
			_ticker.addCallback(1000, onTick, int.MAX_VALUE, _time.currentTime);
		}

		private function initFrameTicker():void {
			_ticker = new FrameTicker();
			_ticker.addCallback(2, onTick, int.MAX_VALUE);
		}

		private function initAsset():void {
			var clip:MovieClip = new TestAni();
			clip.stop();
			clip.y = 100;

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

			_tf.htmlText = date.toString() + " " + _time.timeConstant;

			var now:Number = getTimer();
			trace(_lastTime, now);
			_lastTime = now;

			//moveAsset(factor);
		}

		private function moveAsset(factor:Number):void {
			var xPos:Number = _timelineController.clip.x;

			if (xPos <= 0) {
				_dir = Math.abs(_dir);
				trace(getTimer());
			} else if (xPos > stage.stageWidth - _timelineController.clip.width) {
				_dir = -Math.abs(_dir);
				//_ticker.removeCallback(33, onTick);
				trace(getTimer());
			}

			var step:Number = _dir * _time.frameRateFactor;
			_timelineController.clip.x += step;
			_timelineController.play(factor * _time.frameRateFactor);
		}
	}
}
