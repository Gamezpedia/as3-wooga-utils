package net.wooga.utils.ticker {
	public interface ITicking {
		function addCallback(startTime:Number, interval:int, callback:Function, repeats:int, executeAtOnce:Boolean = false):void;
		function removeCallback(tick:int, callback:Function):void;

		function tick(time:Number = 0):void;
	}
}
