package net.wooga.utils.interfaces {
	public interface IExternalHandler {
		function callBridge(id:String, args:Array = null):*;
		function callService(method:String, wrappedArgs:Array):*;

		function handleCall(id:String, args:Array):void;
	}
}
