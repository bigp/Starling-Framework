package tests {
	import com.bigp.preloaders.Preloader_Base;
	import flash.display.Stage;
	import flash.events.Event;
	import starling.display.Sprite;
	

	/**
	 * ...
	 * @author Pierre Chamberlain
	 */
	public class Test_Base extends Sprite {
			
		public var nativeStage:Stage;
		
		public function Test_Base() {
			super();
			
			nativeStage = Preloader_Base.STAGE;
			nativeStage.addEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		private function onUpdate(e:Event=null):void {
			update();
		}
		
		public function update():void {
			//OVERRIDE
		}
		
		public function begin():void {
			trace("Beginning test " + Object(this).constructor + "..." );
		}
	}
}