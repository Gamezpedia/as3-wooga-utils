package net.wooga.utils.types {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	/**
	 * helper class to make handling display objects easier
	 *
	 * @author sascha
	 */
	public class Displays {
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

		public static function colorizeClip(clip:MovieClip, colors:Dictionary):void {
			var numChildren:int = clip.numChildren;

			for (var i:int = 0; i < numChildren; ++i) {
				var child:Sprite = clip.getChildAt(i) as Sprite;

				if (child && colors[child.name] != null) {
					colorize(child, colors[child.name]);
				}
			}
		}

		public static function colorize(child:DisplayObject, color:uint):void {
			var bitmask:uint = 0xFF;
			var offset:uint = 0;
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.redOffset = (color >> 16) - offset;
			colorTransform.greenOffset = (color >> 8 & bitmask) - offset;
			colorTransform.blueOffset = (color & bitmask & bitmask) - offset;
			child.transform.colorTransform = colorTransform;
		}
	}
}
