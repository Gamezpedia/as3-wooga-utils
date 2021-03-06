﻿package net.wooga.utils.display {
	import flash.display.BitmapData;

	public class FrameDataVO {
		private var _name:String;
		private var _bitmapData:BitmapData;
		private var _regX:Number;
		private var _regY:Number;
		private var _offsetX:Number = 0;
		private var _offsetY:Number = 0;
		private var _scaleX:Number;
		private var _scaleY:Number;
		private var _usePreviousFrame:Boolean;
		private var _isVisible:Boolean = true;
		private var _isHitarea:Boolean;

		public function FrameDataVO(name:String = null, bmd:BitmapData = null, regX:Number = 0, regY:Number = 0, scaleX:Number = 1.0, scaleY:Number = 1.0) {
			_name = name;
			_bitmapData = bmd;
			_regX = regX;
			_regY = regY;
			_scaleX = scaleX;
			_scaleY = scaleY;
		}

		public function get name():String {
			return _name;
		}

		public function set name(value:String):void {
			_name = value;
		}

		public function set bitmapData(value:BitmapData):void {
			_bitmapData = value;
		}

		public function get bitmapData():BitmapData {
			return _bitmapData;
		}

		public function set regX(value:Number):void {
			_regX = value;
		}

		public function get regX():Number {
			return _regX;
		}

		public function getScaledRegX(factor:Number = 1):Number {
			var x:Number = _regX;
			var scale:Number = _scaleX * factor;

			if (scale < 0) {
				x = -x - _bitmapData.width;
			}

			x *= Math.abs(scale);

			return x;
		}

		public function set regY(value:Number):void {
			_regY = value;
		}

		public function get regY():Number {
			return _regY;
		}

		public function getScaledRegY(factor:Number = 1):Number {
			var y:Number = _regY;
			var scale:Number = _scaleY * factor;

			if (scale < 0) {
				y = -y - _bitmapData.height;
			}

			y *= Math.abs(scale);

			return y;
		}

		public function get scaleX():Number {
			return _scaleX;
		}

		public function set scaleX(value:Number):void {
			_scaleX = value;
		}

		public function get scaleY():Number {
			return _scaleY;
		}

		public function set scaleY(value:Number):void {
			_scaleY = value;
		}

		public function get usePreviousFrame():Boolean {
			return _usePreviousFrame;
		}

		public function set usePreviousFrame(value:Boolean):void {
			_usePreviousFrame = value;
		}

		public function get offsetX():Number {
			return _offsetX;
		}

		public function set offsetX(value:Number):void {
			_offsetX = value;
		}

		public function get offsetY():Number {
			return _offsetY;
		}

		public function set offsetY(value:Number):void {
			_offsetY = value;
		}

		public function isScaled(x:Number = 1, y:Number = 1):Boolean {
			return _scaleX * x != 1 || _scaleY * y != 1;
		}

		public function clone():FrameDataVO {
			var data:FrameDataVO = new FrameDataVO(_name, _bitmapData, _regX, _regY, _scaleX, _scaleY);
			data.offsetX = _offsetX;
			data.offsetY = _offsetY;
			data.isVisible = _isVisible;
			data.isHitarea = _isHitarea;
			data.usePreviousFrame = _usePreviousFrame;

			return data;
		}

		public function get isVisible():Boolean {
			return _isVisible;
		}

		public function set isVisible(value:Boolean):void {
			_isVisible = value;
		}

		public function get isHitarea():Boolean {
			return _isHitarea;
		}

		public function set isHitarea(value:Boolean):void {
			_isHitarea = value;
		}
	}
}
