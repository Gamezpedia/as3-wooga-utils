package {
	import net.wooga.utils.display.FlashClipPlayerTest;
	import net.wooga.utils.display.TimelineControllerTest;
	import net.wooga.utils.game.ZoomTest;
	import net.wooga.utils.interfaces.Array2DIteratorTest;
	import net.wooga.utils.sound.SoundServiceTest;
	import net.wooga.utils.ticker.TimeTest;
	import net.wooga.utils.ticker.TimeTickerTest;
	import net.wooga.utils.types.Array2DTest;
	import net.wooga.utils.types.NumbersTest;
	import net.wooga.utils.types.ObjectsTest;
	import net.wooga.utils.types.StringsTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class WoogaUtilsTestSuite {
		public var array2DTest:Array2DTest;
		public var array2DIteratorTest:Array2DIteratorTest;
		public var flashClipPlayerTest:FlashClipPlayerTest;
		public var numbersTest:NumbersTest;
		public var objectsTest:ObjectsTest;
		public var stringsTest:StringsTest;
		public var soundServiceTest:SoundServiceTest;
		public var timelineControllerTest:TimelineControllerTest;
		public var timeServiceTest:TimeTest;
		public var timeTickerTest:TimeTickerTest;
		public var zoomTest:ZoomTest;
	}
}
