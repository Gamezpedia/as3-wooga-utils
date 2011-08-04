/*
 * Copyright (c) 2011 Mattes Groeger
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package net.wooga.utils.game
{
	import flash.errors.IllegalOperationError;

	public class Zoom
	{
		private var allZoomFactors:Vector.<Number>;
		private var currentZoomFactors:Vector.<Number>;
		private var currentLevel:int;

		public function Zoom(zoomFactors:Array)
		{
			this.allZoomFactors = Vector.<Number>(zoomFactors).sort(sortValues);
			this.currentZoomFactors = allZoomFactors.concat();
			this.currentLevel = 0;
		}

		private function sortValues(value1:Number, value2:Number):int
		{
			if (value1 < value2)
				return 1;
			else if (value1 > value2)
				return -1;
			else
				return 0;
		}

		public function getCurrentFactor():Number
		{
			return currentZoomFactors[currentLevel];
		}

		public function getCurrentLevel():uint
		{
			return currentLevel;
		}

		public function hasPrevious():Boolean
		{
			return (currentLevel - 1 >= 0);
		}

		public function hasNext():Boolean
		{
			return (currentLevel + 1 < currentZoomFactors.length);
		}

		public function selectNext():Number
		{
			if (!hasNext())
				throw new IllegalOperationError("No next zoom level available!");

			currentLevel++;

			return getCurrentFactor();
		}

		public function selectPrevious():Number
		{
			if (!hasPrevious())
				throw new IllegalOperationError("No previous zoom level available!");

			currentLevel--;

			return getCurrentFactor();
		}

		public function chooseClosest(zoomFactor:Number):Number
		{
			var closestLevel:uint = 0;

			if (zoomFactor > currentZoomFactors[0])
			{
				closestLevel = 0;
			}
			else if (zoomFactor < currentZoomFactors[currentZoomFactors.length - 1])
			{
				closestLevel = currentZoomFactors.length - 1;
			}
			else
			{
				for (var i:int = 0; i < currentZoomFactors.length - 1; i++)
				{
					if (zoomFactor < currentZoomFactors[i + 1])
						continue;

					if (currentZoomFactors[i] - zoomFactor <= zoomFactor - currentZoomFactors[i + 1])
						closestLevel = i;
					else
						closestLevel = i + 1;

					break;
				}
			}

			return selectLevel(closestLevel);
		}

		public function get levels():uint
		{
			return currentZoomFactors.length;
		}

		public function selectLevel(level:uint):Number
		{
			if (level > currentZoomFactors.length - 1)
				level = currentZoomFactors.length - 1;

			currentLevel = level;

			return getCurrentFactor();
		}

		public function setMinThreshold(zoomFactor:Number):void
		{
			currentZoomFactors = new Vector.<Number>();

			for (var i:int = 0; i < allZoomFactors.length; i++)
			{
				if (allZoomFactors[i] >= zoomFactor)
					currentZoomFactors.push(allZoomFactors[i]);
			}

			if (currentZoomFactors.length == 0)
				currentZoomFactors.push(zoomFactor);
		}
	}
}