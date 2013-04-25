package com.bigp.preloaders {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;

	/**
	 * ...
	 * @author Pierre Chamberlain
	 */
	public class PreloaderDraw  {
		
		private var _target:Sprite;
		private var _g:Graphics;
		
		private var _box:Shape;
		private var _bar:Shape;
		
		public var width:uint;
		public var height:uint;
		public var color:uint;
		
		public function PreloaderDraw( pTarget:Sprite, pWidth:uint, pHeight:uint, pColor:uint=0xff0000 ) {
			_target =	pTarget;
			
			width =	pWidth;
			height =	pHeight;
			color =	pColor;
			
			drawComponents();
		}
		
		private function drawComponents():void {
			_box =	new Shape();
			_bar =	new Shape();
			
			_g =	_box.graphics;
			_g.lineStyle(1, 0x888888, 1);
			_g.drawRect(0, 0, width, height);
			
			_g =	_bar.graphics;
			_g.beginFill(color, 1);
			_g.drawRect(0, 0, width - 3, height - 3);
			_g.endFill();
			
			_bar.x = _bar.y = 2;
			
			_target.addChild( _box );
			_target.addChild( _bar );
		}
		
		/* INTERFACE com.bigp.utils.interfaces.IDestroyable */
		
		public function destroy():void {
			if (!_target) {
				return;
			}
			
			_target.removeChild( _box );
			_target.removeChild( _bar );
			
			if(_target.parent) {
				_target.parent.removeChild( _target );
			}
			
			_target =	null;
			_g =		null;
		}
		
		public function drawPercent( pValue:Number ):void {
			_bar.scaleX = pValue;
		}
		
		///////////////////////////////////////////// STATIC PUBLIC
		
		///////////////////////////////////////////// STATIC PRIVATE
		
		///////////////////////////////////////////// PUBLIC
		
		///////////////////////////////////////////// PRIVATE & PROTECTED
		
		///////////////////////////////////////////// EVENT-LISTENERS
		
		///////////////////////////////////////////// GETTERS-SETTERS
		
		public function get x():Number { return _target.x; }
		public function get y():Number { return _target.y; }
		
		public function set x(value:Number):void { _target.x = value; }
		public function set y(value:Number):void { _target.y = value; }
		
		public function get target():Sprite { return _target; }
		
		
		
	}
}