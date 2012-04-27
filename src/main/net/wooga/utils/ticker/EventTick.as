package net.wooga.utils.ticker {
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	public class EventTick extends AbstractTick {
		private var _event:Event;
		private var _dispatcher:IEventDispatcher;

		public function EventTick(event:Event, dispatcher:IEventDispatcher, interval:int, repeats:int, executeAtOnce:Boolean = false, delay:Number = 0) {
			super(interval, repeats, executeAtOnce, delay);

			_event = event;
			_dispatcher = dispatcher;
		}

		override protected function executeTick(factor:Number):void {
			if (_dispatcher.hasEventListener(_event.type)) {
				_dispatcher.dispatchEvent(_event);
			}
		}

		/*public function contains(interval:int, event:Event):Boolean {
		 return _interval == interval && _event == event;
		 }*/
	}
}
