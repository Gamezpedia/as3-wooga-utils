package net.wooga.utils.ticker {
	public interface ITicking {
		function addCallback(tick:int, callback:Function, repeats:int, time:Number = 0, executeAtOnce:Boolean = false):void;
		function removeCallback(tick:int, callback:Function):void;

		function tick(time:Number):void;
	}
}
