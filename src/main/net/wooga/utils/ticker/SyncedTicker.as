package net.wooga.utils.ticker {
	public class SyncedTicker {
		/*protected var _buckets:Dictionary = new Dictionary();

		 override public function tick(time:Number, delta:Number = 0):void {
		 var last:Number = time - delta;
		 var tick:int;
		 var lastStep:int;
		 var nextStep:int;

		 for (var key:* in _buckets) {
		 tick = int(key);

		 lastStep = int(last / tick);
		 nextStep = int(time / tick);

		 if (lastStep < nextStep) {
		 var steps:int = nextStep - lastStep;
		 var stepDelta:Number = delta / steps;
		 executeBucket(_buckets[key], steps, stepDelta);
		 }
		 }
		 }

		 private function executeBucket(bucket:Array, steps:int, stepDelta:Number):void {
		 for each (var ticker:ITicker in bucket) {
		 executeTicker(ticker);
		 }
		 }

		 override protected function addTicker(ticker:ITicker):void {
		 _buckets[ticker.tick] ||= [];
		 _buckets[ticker.tick].push(ticker);
		 }

		 override protected function removeTicker(ticker:ITicker):void {
		 var bucket:Array = _buckets[ticker.tick] as Array;
		 var index:int = bucket.indexOf(ticker);

		 if (index >= 0) {
		 bucket.splice(index, 1);
		 }
		 }*/
	}
}
