package  {
	import com.bigp.preloaders.Preloader_Base;
	import flash.events.Event;
	import starling.core.Starling;
	import starling.display.Sprite;
	import tests.Test_Base;
	import tests.TestBitmapTexture;
	import tests.TestScrollImage;
	import tests.TestTexture;

	/**
	 * ...
	 * @author Pierre Chamberlain
	 */
	public class Main extends Sprite {
		
		public function Main() {
			super();
			
			Preloader_Base.STAGE.addEventListener(Event.ENTER_FRAME, init);
		}
		
		private function init(e:Event = null):void {
			if (!stage || !("current" in Starling)) {
				return;
			}
			
			e && Preloader_Base.STAGE.removeEventListener(Event.ENTER_FRAME, init);
			
			//var test:Test_Base =	new TestTexture();
			//var test:Test_Base =	new TestBitmapTexture();
			var test:Test_Base =	new TestScrollImage();
			addChild( test );
			test.begin();
		}
	}
}