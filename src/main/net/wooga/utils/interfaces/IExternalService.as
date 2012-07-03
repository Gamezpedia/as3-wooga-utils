package net.wooga.utils.interfaces {
	public interface IExternalService {
		function call(id:String, args:Array = null):*;
	}
}
