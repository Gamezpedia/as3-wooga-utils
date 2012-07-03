package net.wooga.utils.interfaces {
	public interface IExternalCalls {
		function callJS(id:String, args:Array = null):*;

		function handleCall(id:String, args:Array):void;
	}
}
