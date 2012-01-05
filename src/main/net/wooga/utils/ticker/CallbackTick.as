package net.wooga.utils.ticker {
	public class CallbackTick extends AbstractTick {
		private var _callback:Function;

		public function CallbackTick(callback:Function, interval:int, repeats:int, executeAtOnce:Boolean = false, delay:int = 0) {
			super(interval, repeats, executeAtOnce, delay);

			_callback = callback;
		}

		override protected function executeTick(factor:Number):void {
			_callback(factor);
		}
	}
}
