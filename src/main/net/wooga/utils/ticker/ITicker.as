package net.wooga.utils.ticker {
	public interface ITicker {
		function get nextTickAt():Number;

		function get repeats():Number;

		function execute(tickCount:Number):void;
		function updateNextTick():void;
		function contains(tick:int,  callback:Function):Boolean;
	}
}
