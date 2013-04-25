package starling.extensions.bigp {
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Pierre Chamberlain
	 */
	public class ScrollImage extends Image {
		
		private var _scrollX:Number = 0;
		private var _scrollY:Number = 0;
		
		private var _uvScaleX:Number = 1;
		private var _uvScaleY:Number = 1;
		
		private var _clipMask:Rectangle;
		private var _isDirty:Boolean = false;
		
		public var isScrollModuloed:Boolean = true;
		
		public function ScrollImage(texture:Texture, pRepeats:Boolean=false) {
			//No matter what, the texture MUST repeat for this to work correctly
			texture.repeat =	pRepeats;
			super(texture);
			_clipMask =		new Rectangle(0, 0, texture.width, texture.height);
			
			
			invalidate();
		}
		
		public override function dispose():void {
			super.dispose();
			
			if (!_clipMask) {
				return;
			}
			
			_clipMask =		null;
		}
		
		private function updateUVs():void {
			if (!_isDirty) return;
			_isDirty = false;
			
			var ratioX:Number =	1 / texture.width / _uvScaleX;
			var ratioY:Number =	1 / texture.height / _uvScaleY;
			
			mVertexData.setPosition(0, _clipMask.left, _clipMask.top);
			mVertexData.setPosition(1, _clipMask.right, _clipMask.top);
			mVertexData.setPosition(2, _clipMask.left, _clipMask.bottom);
			mVertexData.setPosition(3, _clipMask.right, _clipMask.bottom);
			
			var scrollLeft:Number =		(_scrollX + _clipMask.left) * ratioX;
			var scrollTop:Number =		(_scrollY + _clipMask.top) * ratioY;
			var scrollRight:Number =	(_scrollX + _clipMask.right) * ratioX;
			var scrollBottom:Number =	(_scrollY + _clipMask.bottom) * ratioY;
			
			mVertexData.setTexCoords(0, scrollLeft, scrollTop);
			mVertexData.setTexCoords(1, scrollRight, scrollTop);
			mVertexData.setTexCoords(2, scrollLeft, scrollBottom);
			mVertexData.setTexCoords(3, scrollRight, scrollBottom);
			
			onVertexDataChanged();
		}
		
		private function invalidate():void {
			if (_isDirty) return;
			_isDirty = true;
			Starling.whenDrawCallStart.addOnce( updateUVs );
		}
		
		public function get scrollX():Number { return _scrollX; }
		public function set scrollX(value:Number):void {
			_scrollX = isScrollModuloed ? value % texture.width : value; invalidate();
		}
		
		public function get scrollY():Number { return _scrollY; }
		public function set scrollY(value:Number):void {
			_scrollY = isScrollModuloed ? value % texture.height : value; invalidate();
		}
		
		public function get clipMaskLeft():Number { return _clipMask.left; }
		public function set clipMaskLeft(n:Number):void {
			_clipMask.left = n; invalidate();
		}
		
		public function get clipMaskTop():Number { return _clipMask.top; }
		public function set clipMaskTop(n:Number):void {
			_clipMask.top = n; invalidate();
		}
		
		public function get clipMaskRight():Number { return _clipMask.right; }
		public function set clipMaskRight(n:Number):void {
			_clipMask.right = n; invalidate();
		}
		
		public function get clipMaskBottom():Number { return _clipMask.bottom; }
		public function set clipMaskBottom(n:Number):void {
			_clipMask.bottom = n; invalidate();
		}
		
		public function get uvScaleX():Number { return _uvScaleX; }
		public function set uvScaleX(value:Number):void {
			_uvScaleX = value; invalidate();
		}
		
		public function get uvScaleY():Number { return _uvScaleY; }
		public function set uvScaleY(value:Number):void {
			_uvScaleY = value; invalidate();
		}
		
		public override function get width():Number { return _clipMask.width; }
		public override function set width(n:Number):void { super.width = _clipMask.width = n; }
		public override function get height():Number { return _clipMask.height; }
		public override function set height(n:Number):void { super.height = _clipMask.height = n; }
		
	}
}