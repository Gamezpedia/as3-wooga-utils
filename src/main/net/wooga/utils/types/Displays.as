package net.wooga.utils.types {
	import flash.display.*;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import net.wooga.utils.display.FrameDataVO;

	/**
	 * helper class to make handling display objects easier
	 *
	 * @author sascha
	 */
	public class Displays {
		private static const TRANS_BLACK:uint = 0xFF000000;
		private static const SOLID_BLACK:uint = 0x00000000;
		private static const DEFAULT_POINT:Point = new Point(0, 0);

		public static function getChild(container:DisplayObjectContainer, path:String, separator:String = "/"):DisplayObject {
			if (!path) {
				return container;
			}

			var list:Array = path.split(separator);
			var name:String = list.shift();
			var child:DisplayObject = container.getChildByName(name);

			if (list.length && child is DisplayObjectContainer) {
				container = child as DisplayObjectContainer;
				path = list.join(separator);
				child = getChild(container, path, separator);
			}

			return child;
		}

		/**
		 * find the first occurrence of a child object with the given name
		 *
		 * @param cont container to search through
		 * @param name name to look for
		 * @return first occurrence of child or null
		 */
		public static function findChild(cont:DisplayObjectContainer, name:String):DisplayObject {
			var child:DisplayObject;

			for (var i:int = 0; i < cont.numChildren; i++) {
				child = cont.getChildAt(i);

				if (!child) {
					break;
				} else if (child.name == name) {
					return child;
				} else if (child is DisplayObjectContainer) {
					child = findChild(DisplayObjectContainer(child), name);

					if (child) {
						return child;
					}
				}
			}

			return null;
		}

		/**
		 * display the path of all childs as a tree
		 *
		 * @param cont container to display
		 * @param name current path
		 */
		public static function showChilds(cont:DisplayObjectContainer, name:String = "", separator:String = "/"):void {
			var child:DisplayObject;

			for (var i:int = 0; i < cont.numChildren; i++) {
				child = cont.getChildAt(i);

				if (child is DisplayObjectContainer) {
					showChilds(DisplayObjectContainer(child), name + separator + child.name, separator);
				}
			}
		}

		/**
		 * remove all children of this container
		 *
		 * @param cont cntainer to empty
		 */
		public static function removeAllFrom(cont:DisplayObjectContainer):void {
			if (cont) {
				while (cont.numChildren) {
					cont.removeChildAt(0);
				}
			}
		}

		public static function removeAll(list:Array):void {
			for each (var child:DisplayObject in list) {
				removeChild(child);
			}
		}

		/**
		 * remove an object from display list securely
		 *
		 * @param object object to remove from display list
		 */
		public static function removeChild(object:DisplayObject):void {
			if (object && object.parent) {
				object.parent.removeChild(object);
			}
		}

		/**
		 * retrieve a list of all children of a container
		 *
		 * @param container container to retrieve children from
		 * @return list of retrieved children
		 */
		public static function getChildren(container:DisplayObjectContainer):Array {
			var list:Array = [];
			var count:int = container.numChildren;

			for (var i:int = 0; i < count; i++) {
				list.push(container.getChildAt(i));
			}

			return list;
		}

		/**
		 * set the depth of display objects according to their index in a list
		 *
		 * @param list list of display objects to sort by
		 */
		public static function setIndices(list:Array):void {
			var count:int = list.length;

			for (var i:int = 0; i < count; ++i) {
				setIndex(list[i], i);
			}
		}

		/**
		 * set the depth of a display object
		 *
		 * @param child display object to set index of
		 * @param index index to set
		 */
		public static function setIndex(child:DisplayObject, index:int = -1):void {
			var parent:DisplayObjectContainer = child.parent;

			if (parent) {
				if (index == -1) {
					index = parent.numChildren - 1;
				}

				if (index != parent.getChildIndex(child)) {
					parent.setChildIndex(child, index);
				}
			}
		}

		public static function getIndex(child:DisplayObject):int {
			var index:int = -1;

			if (child && child.parent) {
				index = child.parent.getChildIndex(child);
			}

			return index;
		}

		/**
		 * remove a child identified by its name from the container
		 *
		 * @param container container to remove a child from
		 * @param name name of child to remove
		 * @return the removed child
		 */
		public static function removeChildByName(container:DisplayObjectContainer, name:String):DisplayObject {
			var object:DisplayObject = container.getChildByName(name);

			if (object) {
				container.removeChild(object);
			}

			return object;
		}

		public static function replaceChild(oldChild:DisplayObject, newChild:DisplayObject):void {
			var parent:DisplayObjectContainer = oldChild.parent;

			if (parent) {
				var index:int = parent.getChildIndex(oldChild);
				removeChild(oldChild);
				parent.addChildAt(newChild, index);
			}
		}

		public static function correctRegPointAndScaling(container:DisplayObjectContainer, clip:DisplayObject, width:Number, height:Number, xDir:int = 0, yDir:int = 0):void {
			correctRegPoint(clip, xDir, yDir);
			correctScaling(container, clip, width, height);
		}

		public static function correctScaling(container:DisplayObjectContainer, clip:DisplayObject, width:Number, height:Number):void {
			container.scaleX = container.scaleY = Numbers.scaleWithinRect(clip.width, clip.height, width, height);
		}

		/**
		 * calculates the offset off different registration points
		 * xDir -1 is left, 1 is right
		 * yDir -1 is top, 1 is bottom
		 * 0 is center and middle
		 **/
		private static function getRegPoint(display:DisplayObject, xDir:int = 0, yDir:int = 0):Point {
			var rect:Rectangle = display.getRect(display);
			var halfWidth:Number = rect.width * 0.5;
			var halfHeight:Number = rect.height * 0.5;
			var centerX:Number = rect.x + halfWidth;
			var centerY:Number = rect.y + halfHeight;
			var result:Point = new Point(-centerX + halfWidth * -xDir, -centerY + halfHeight * -yDir);

			return result;
		}

		private static function correctRegPoint(display:DisplayObject, xDir:int = 0, yDir:int = 0):void {
			var reg:Point = getRegPoint(display, xDir, yDir);
			display.x = reg.x;
			display.y = reg.y;
		}

		public static function parseTimeline(clip:MovieClip, scale:Number = 1.0, frames:Vector.<FrameDataVO> = null):Vector.<FrameDataVO> {
			frames ||= new Vector.<FrameDataVO>();

			var totalFrames:int = clip.totalFrames;
			var clipRect:Rectangle = getClipRectangle(clip, totalFrames);

			for (var frame:int = 1; frame <= totalFrames; ++frame) {
				var frameData:FrameDataVO = getFrameData(frame, frames);
				clip.gotoAndStop(frame);
				parseFrameData(clip, clipRect, scale, frameData);
			}

			return frames;
		}

		private static function getClipRectangle(clip:MovieClip, totalFrames:int):Rectangle {
			var top:Number = Number.MAX_VALUE;
			var left:Number = Number.MAX_VALUE;
			var bottom:Number = Number.MIN_VALUE;
			var right:Number = Number.MIN_VALUE;

			for (var i:int = 1; i <= totalFrames; ++i) {
				clip.gotoAndStop(i);
				var rect:Rectangle = clip.getRect(clip);

				if (top > rect.top) {
					top = rect.top;
				}

				if (bottom < rect.bottom) {
					bottom = rect.bottom;
				}

				if (left > rect.left) {
					left = rect.left;
				}

				if (right < rect.right) {
					right = rect.right;
				}
			}

			var width:Number = Math.abs(left - right);
			var height:Number = Math.abs(top - bottom);

			var resultRect:Rectangle = new Rectangle(left, top, width, height);

			return resultRect;
		}

		public static function parseFrameData(clip:DisplayObject, rect:Rectangle, scale:Number = 1.0, frameData:FrameDataVO = null):FrameDataVO {
			var bitmapData:BitmapData = drawBitmap(rect, scale, clip);
			var visRect:Rectangle = bitmapData.getColorBoundsRect(TRANS_BLACK, SOLID_BLACK, false);
			var visBitmapData:BitmapData = new BitmapData(visRect.width || 1, visRect.height || 1, true, SOLID_BLACK);
			visBitmapData.copyPixels(bitmapData, visRect, DEFAULT_POINT);


			frameData ||= new FrameDataVO();
			frameData.bitmapData = bitmapData;
			frameData.offsetX = rect.x + visRect.x;
			frameData.offsetY = rect.y + visRect.y;
			frameData.scale = scale;

			return frameData;


			/*helperBitmapData.draw( movieClip, matrix );
			    graphicRectangle = helperBitmapData.getColorBoundsRect( 0xFF000000, 0x00000000, false );
			    
			    graphicWidth = graphicRectangle.width == 0 ? 1 : graphicRectangle.width;
			    graphicHeight = graphicRectangle.height == 0 ? 1 : graphicRectangle.height;
			    
			    bitmapData = new PositionedBitmapData( graphicWidth, graphicHeight, true, 0x00000000 );
			    bitmapData.copyPixels( helperBitmapData, graphicRectangle, defaultPoint );*/
		}

		public static function parseBitmapContainer(clip:DisplayObjectContainer, scale:Number = 1.0, frameData:FrameDataVO = null):FrameDataVO {
			var bitmap:Bitmap = clip.getChildAt(0) as Bitmap;

			frameData ||= new FrameDataVO();
			frameData.bitmapData = bitmap.bitmapData;
			frameData.offsetX = bitmap.x;
			frameData.offsetY = bitmap.y;
			frameData.scale = scale;

			return frameData;
		}

		private static function getFrameData(frame:int, frames:Vector.<FrameDataVO>):FrameDataVO {
			var frameData:FrameDataVO;

			if (frame < frames.length) {
				frameData = frames[frame - 1] as FrameDataVO;
			} else {
				frameData = new FrameDataVO();
				frames.push(frameData);
			}

			return frameData;
		}

		private static function drawBitmap(rect:Rectangle, scale:Number, clip:DisplayObject):BitmapData {
			var width:int = rect.width * scale;
			var height:int = rect.height * scale;
			var bitmapData:BitmapData;

			if (width && height) {
				var matrix:Matrix = new Matrix();
				matrix.tx = -rect.x;
				matrix.ty = -rect.y;
				matrix.scale(scale, scale);

				bitmapData = new BitmapData(width, height, true, TRANS_BLACK);
				bitmapData.draw(clip, matrix);
			}

			return bitmapData;
		}
	}
}
