package net.wooga.utils.ticker {
	public interface ITick {
		function get id():String;

		function get nextTickAt():Number;

		function set nextTickAt(value:Number):void;

		function get repeats():Number;

		function get executeAtOnce():Boolean

		function execute(tickCount:Number):void;

		function resetNextTick():void;
	}
}
