package tests {
	import com.foxaweb.utils.Raster;
	import flash.events.MouseEvent;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.extensions.bigp.BitmapImage;;

	/**
	 * ...
	 * @author Pierre Chamberlain
	 */
	public class TestBitmapTexture extends Test_Base {
		private var bit:BitmapImage;
		private var raster:Raster;
		private var mouseIsDown:Boolean = false;
		private var counter:int = 0;
		
		private var _oldX:int = 0;
		private var _oldY:int = 0;
		
		public override function begin():void {
			super.begin();
			
			bit =	new BitmapImage(1024, 1024, true, 0xff00ff00, Raster );
			bit.scaleX = bit.scaleY = 1;
			raster = bit.bitmap as Raster;
			
			nativeStage.addEventListener(MouseEvent.MOUSE_DOWN, onMouse);
			nativeStage.addEventListener(MouseEvent.MOUSE_UP, onMouse);
			
			Starling.whenDrawCallStart.add( draw );
			
			addChild( bit );
		}
		
		private function draw():void {
			if (!mouseIsDown) return;
			
			//Draw a cross:
			var mouseX:int = nativeStage.mouseX / bit.scaleX;
			var mouseY:int = nativeStage.mouseY / bit.scaleY;
			
			var color:uint = 0xffffff00 | (counter % 0xff);
			raster.line( _oldX, _oldY, mouseX, mouseY, color);
			
			_oldX = mouseX;
			_oldY = mouseY;
			counter++;
			
			bit.invalidate();
		}
		
		private function onMouse(e:MouseEvent):void {
			mouseIsDown = e.type == MouseEvent.MOUSE_DOWN;
			
			if (mouseIsDown) {
				_oldX = nativeStage.mouseX / bit.scaleX;
				_oldY = nativeStage.mouseY / bit.scaleY;
			}
		}
	}
}