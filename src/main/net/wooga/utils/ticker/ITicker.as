package net.wooga.utils.ticker {
	public interface ITicker {
		function get nextTickAt():Number;
		function set nextTickAt(value:Number):void;

		function get repeats():Number;

		function execute(tickCount:Number):void;
		function resetNextTick():void;
		function contains(tick:int,  callback:Function):Boolean;
	}
}
