package net.wooga.utils.interfaces {
	public interface IAnimation {
		function play(steps:Number = 1.0):void;

		function set onFinished(value:Function):void;

		function set finishedHandler(value:Function):void;

		function get finishedHandler():Function;
	}
}
