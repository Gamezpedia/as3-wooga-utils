package {
	import net.wooga.utils.game.ZoomTest;
	import net.wooga.utils.sound.SoundServiceTest;
	import net.wooga.utils.ticker.TimeServiceTest;
	import net.wooga.utils.ticker.TimeTickerTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class WoogaUtilsTestSuite {
		public var soundServiceTest:SoundServiceTest;
		//public var syncedTickerTest:SyncedTickerTest;
		public var timeServiceTest:TimeServiceTest;
		public var timeTickerTest:TimeTickerTest;
		public var zoomTest:ZoomTest;
	}
}
