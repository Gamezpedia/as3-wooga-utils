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
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	import flash.errors.IllegalOperationError;

	public class ZoomTest
	{
		private var zoomLevel:Zoom;

		[Before]
		public function before():void
		{
			zoomLevel = new Zoom([1, 0.5, 0.2]);
		}

		[Test]
		public function should_be_correct_initialized():void
		{
			assertThat(zoomLevel.getCurrentFactor(), equalTo(1));
			assertThat(zoomLevel.getCurrentLevel(), equalTo(0));
			assertThat(zoomLevel.levels, equalTo(3));
			assertFalse(zoomLevel.hasPrevious());
			assertTrue(zoomLevel.hasNext());
		}

		[Test]
		public function should_set_level():void
		{
			var result:Number = zoomLevel.selectLevel(1);
			
			assertThat(result, equalTo(0.5));
			assertThat(zoomLevel.getCurrentFactor(), equalTo(0.5));
			assertThat(zoomLevel.getCurrentLevel(), equalTo(1));
		}

		[Test]
		public function should_crop_zoom_level():void
		{
			var result:Number = zoomLevel.selectLevel(3);
			
			assertThat(result, equalTo(0.2));
			assertThat(zoomLevel.getCurrentFactor(), equalTo(0.2));
			assertThat(zoomLevel.getCurrentLevel(), equalTo(2));
		}

		[Test]
		public function should_have_next_and_previous():void
		{
			var result:Number = zoomLevel.selectNext();
			
			assertThat(result, equalTo(0.5));
			assertThat(zoomLevel.getCurrentFactor(), equalTo(0.5));
			assertThat(zoomLevel.getCurrentLevel(), equalTo(1));
			assertTrue(zoomLevel.hasPrevious());
			assertTrue(zoomLevel.hasNext());
		}

		[Test]
		public function should_have_next_and_previous_according_to_min_level():void
		{
			var result:Number = zoomLevel.selectNext();
			
			zoomLevel.setMinThreshold(0.5);
			
			assertThat(result, equalTo(0.5));
			assertThat(zoomLevel.getCurrentFactor(), equalTo(0.5));
			assertThat(zoomLevel.getCurrentLevel(), equalTo(1));
			assertTrue(zoomLevel.hasPrevious());
			assertFalse(zoomLevel.hasNext());
		}

		[Test]
		public function should_have_no_next_and_previous_according_to_min_level():void
		{
			zoomLevel = new Zoom([1, 0.5, 0.2]);
			
			zoomLevel.setMinThreshold(1.1);
			
			assertThat(zoomLevel.getCurrentFactor(), equalTo(1.1));
			assertThat(zoomLevel.getCurrentLevel(), equalTo(0));
			assertFalse(zoomLevel.hasPrevious());
			assertFalse(zoomLevel.hasNext());
		}

		[Test]
		public function should_have_next_and_previous_according_to_reseted_min_level():void
		{
			var result:Number = zoomLevel.selectNext();
			zoomLevel.setMinThreshold(0.5);
			
			zoomLevel.setMinThreshold(0.2);
			
			assertThat(result, equalTo(0.5));
			assertThat(zoomLevel.getCurrentFactor(), equalTo(0.5));
			assertThat(zoomLevel.getCurrentLevel(), equalTo(1));
			assertTrue(zoomLevel.hasPrevious());
			assertTrue(zoomLevel.hasNext());
		}

		[Test]
		public function should_have_no_next():void
		{
			zoomLevel.selectNext();
			zoomLevel.selectNext();
			
			assertTrue(zoomLevel.hasPrevious());
			assertFalse(zoomLevel.hasNext());
		}

		[Test]
		public function should_have_no_previous():void
		{
			zoomLevel.selectNext();
			zoomLevel.selectPrevious();
			
			assertFalse(zoomLevel.hasPrevious());
			assertTrue(zoomLevel.hasNext());
		}

		[Test]
		public function should_throw_error_on_previous():void
		{
			try
			{
				zoomLevel.selectPrevious();
				fail("error expected");
			}
			catch (e:IllegalOperationError) { }
		}

		[Test]
		public function should_throw_error_on_next():void
		{
			zoomLevel.selectNext();
			zoomLevel.selectNext();
			
			try
			{
				zoomLevel.selectNext();
				fail("error expected");
			}
			catch (e:IllegalOperationError) { }
		}
		
		[Test]
		public function should_set_appropriate_level():void
		{
			assertClosest(1.1, 1);
			assertClosest(1, 1);
			assertClosest(0.8, 1);
			assertClosest(0.75, 1);
			assertClosest(0.74, 0.5);
			assertClosest(0.5, 0.5);
			assertClosest(0.36, 0.5);
			assertClosest(0.34, 0.2);
			assertClosest(0.3, 0.2);
			assertClosest(0, 0.2);
			assertClosest(-1, 0.2);
		}
		
		[Test]
		public function should_set_appropriate_level_with_restriction():void
		{
			zoomLevel.setMinThreshold(0.5);
			
			assertClosest(1.1, 1);
			assertClosest(1, 1);
			assertClosest(0.8, 1);
			assertClosest(0.75, 1);
			assertClosest(0.74, 0.5);
			assertClosest(0.5, 0.5);
			assertClosest(0.36, 0.5);
			assertClosest(0.34, 0.5);
			assertClosest(0.3, 0.5);
			assertClosest(0, 0.5);
			assertClosest(-1, 0.5);
		}
		
		[Test]
		public function should_set_appropriate_level_with_restriction_outside_of_zoom_levels():void
		{
			zoomLevel = new Zoom([1, 0.5, 0.2]);
			
			zoomLevel.setMinThreshold(1.1);
			
			assertClosest(1.2, 1.1);
			assertClosest(1.1, 1.1);
			assertClosest(1, 1.1);
			assertClosest(0, 1.1);
			assertClosest(-1, 1.1);
		}

		private function assertClosest(zoom:Number, expected:Number):void
		{
			var current:Number = zoomLevel.chooseClosest(zoom);

			assertThat(current, equalTo(expected));
			assertThat(zoomLevel.getCurrentFactor(), equalTo(expected));
		}
	}
}
