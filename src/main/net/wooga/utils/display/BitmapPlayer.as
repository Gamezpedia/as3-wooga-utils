﻿package  net.wooga.utils.display {	import flash.display.Bitmap;	public class BitmapPlayer extends BitmapImage {		private var _frames:Vector.<FrameDataVO> = new Vector.<FrameDataVO>();		private var _totalFrames:int = 0;		private var _currentFrame:int = 0;		public function init(value:Vector.<FrameDataVO>):void {			_frames = value;			_totalFrames = _frames.length;			setFrame(0);		}		public function setFrame(frame:Number):void {			_currentFrame = frame % _totalFrames;			setBitmap(_frames[_currentFrame]);		}		public function get totalFrames():int {			return _totalFrames;		}		public function get currentFrame():int {			return _currentFrame;		}	}}