﻿package net.wooga.utils.display {	import flash.display.BitmapData;	public class FrameDataVO {		private var _bitmapData:BitmapData;		private var _offsetX:Number;		private var _offsetY:Number;		private var _scale:Number;		public function FrameDataVO(bmd:BitmapData = null, offsetX:Number = 0, offsetY:Number = 0, scale:Number = 1.0) {			_bitmapData = bmd;			_offsetX = offsetX;			_offsetY = offsetY;			_scale = scale;		}		public function get bitmapData():BitmapData {			return _bitmapData;		}		public function get offsetX():Number {			return _offsetX;		}		public function get offsetY():Number {			return _offsetY;		}		public function set bitmapData(value:BitmapData):void {			_bitmapData = value;		}		public function set offsetX(value:Number):void {			_offsetX = value;		}		public function set offsetY(value:Number):void {			_offsetY = value;		}		public function get scale():Number {			return _scale;		}		public function set scale(value:Number):void {			_scale = value;		}	}}