package net.wooga.utils.types {
	import flash.display.Sprite;

	import mx.filters.IBitmapFilter;

	import org.hamcrest.assertThat;
	import org.hamcrest.core.anything;
	import org.hamcrest.core.not;
	import org.hamcrest.core.throws;
	import org.hamcrest.object.equalTo;

	public class ClassesTest {
		
		
		
		[Test]
		public function should_check_if_class_has_a_superclass_without_instantiating_it():void {
		
			var result:Boolean;

			assertThat(function():void{
				result = Classes.isClassOfType(ThrowsErrorWhenInstantiated, SuperClass);
			}, not(throws(anything())))

			assertThat(result, equalTo(true));
		}



		[Test]
		public function should_check_if_class_has_an_interface_without_instantiating_it():void {

			var result:Boolean;

			assertThat(function():void{
				result = Classes.isClassOfType(ThrowsErrorWhenInstantiated, IInterface);
			}, not(throws(anything())))

			assertThat(result, equalTo(true));
		}



		[Test]
		public function should_check_if_class_not_has_a_superclass_without_instantiating_it():void {

			var result:Boolean;

			assertThat(function():void{
				result = Classes.isClassOfType(ThrowsErrorWhenInstantiated, Sprite);
			}, not(throws(anything())))

			assertThat(result, equalTo(false));
		}



		[Test]
		public function should_check_if_class_not_has_an_interface_without_instantiating_it():void {

			var result:Boolean;

			assertThat(function():void{
				result = Classes.isClassOfType(ThrowsErrorWhenInstantiated, IBitmapFilter);
			}, not(throws(anything())))

			assertThat(result, equalTo(false));
		}
	}
}


class InstantiationError extends Error {

}


class SuperClass {

}


interface IInterface {

}

class ThrowsErrorWhenInstantiated extends SuperClass implements IInterface {

	public function ThrowsErrorWhenInstantiated() {
		throw new InstantiationError();
	}
}
