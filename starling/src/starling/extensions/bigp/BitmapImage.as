package starling.extensions.bigp {
	import flash.display.BitmapData;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;
	import flash.display3D.textures.Texture;
	import starling.textures.TextureSmoothing;
	

	/**
	 * ...
	 * @author Pierre Chamberlain
	 */
	public class BitmapImage extends Image {
		private var _isDirty:Boolean = false;
		
		public var bitmap:BitmapData;
		
		public function BitmapImage( pWidth:int, pHeight:int, pTransparent:Boolean = true, pColor:uint = 0x00000000, pBitmapClassOrInst:* = null ) {
			if(pBitmapClassOrInst is Class) {
				var bmpClass:Class =	pBitmapClassOrInst || BitmapData;
				bitmap = new bmpClass( pWidth, pHeight, pTransparent, pColor);
			} else if (pBitmapClassOrInst is BitmapData) {
				bitmap = pBitmapClassOrInst;
			} else {
				bitmap = new BitmapData(pWidth, pHeight, pTransparent, pColor);
			}
			
			bitmap.lock();
			
			super(starling.textures.Texture.fromBitmapData( bitmap, false ));
			
			smoothing = TextureSmoothing.NONE;
			
			invalidate();
		}
		
		public override function dispose():void {
			super.dispose();
			
			bitmap.dispose();
			texture.dispose();
			
			bitmap = null;
			//texture = null; //Causes error?
		}
		
		public function setPixel32( pX:int, pY:int, pColor:uint = 0xff000000 ):void {
			bitmap.setPixel32( pX, pY, pColor );
			invalidate();
		}
		
		public function invalidate():void {
			if (_isDirty) return;
			_isDirty = true;
			
			Starling.whenDrawCallStart.addOnce( commitChanges );
		}
		
		private function commitChanges():void {
			if (!_isDirty || !bitmap || !texture) return;
			_isDirty = false;
			var nativeTexture:flash.display3D.textures.Texture = texture.base as flash.display3D.textures.Texture;
			nativeTexture.uploadFromBitmapData( bitmap, 0 );
		}
		
		public function clear(pAndInvalidate:Boolean=true):void {
			bitmap.fillRect(bitmap.rect, 0x00000000);
			pAndInvalidate && invalidate();
		}
	}
}