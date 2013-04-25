package starling.extensions.bigp {
	import flash.display3D.textures.TextureBase;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.SubTexture;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author Pierre Chamberlain
	 */
	public class Sprite9Sliced extends Sprite {
		
		private static const TOP_L:int =	0;
		private static const TOP_C:int =	1;
		private static const TOP_R:int =	2;
		
		private static const MID_L:int =	3;
		private static const MID_C:int =	4;
		private static const MID_R:int =	5;
		
		private static const BOTTOM_L:int =	6;
		private static const BOTTOM_C:int =	7;
		private static const BOTTOM_R:int =	8;
		
		private var _sliceRegions:Vector.<Rectangle>;
		private var _slices:Vector.<Image>;
		private var _texture:Texture;
		
		private var _width:Number = 100;
		private var _widthMin:Number = 0;
		private var _height:Number = 100;
		private var _heightMin:Number = 0;
		
		private var _overlapAmount:int = 0;
		
		public function Sprite9Sliced(pTexture:Texture, pSliceData:Vector.<Rectangle>) {
			super();
			
			_texture =		pTexture;
			_sliceRegions =	pSliceData;
			
			initImages();
		}
		
		/**
		 * Creates a 9-slice Sprite box with the supplied texture, and the 9 rectangle raw coordinates (x,y,width,height)
		 * The values of X and Y can be negative (to 'loop' from the opposite side of the texture width / height)
		 * @param	pTexture
		 * @param	... args
		 * @return
		 */
		public static function makeFromRects( pTexture:Texture, ... args ):Sprite9Sliced {
			var theSliceData:Vector.<Rectangle> =	new Vector.<Rectangle>(9);
			
			for (var d:int = 0, dLen:int = theSliceData.length; d < dLen; d++) {
				var theID:int =		d * 4;
				var theX:int =		loopValue( args[theID], pTexture.width );
				var theY:int =		loopValue( args[theID+1], pTexture.height );
				var theW:int =		args[theID+2];
				var theH:int =		args[theID+3];
				
				theSliceData[d] =	new Rectangle(theX, theY, theW, theH);
			}
			
			return new Sprite9Sliced(pTexture, theSliceData);
		}
		
		public static function makeFromWidthsAndHeights( pTexture:Texture, pW0:int, pW1:int, pW2:int, pH0:int, pH1:int, pH2:int, pXOffset:int=0, pYOffset:int=0 ):Sprite9Sliced {
			var theSliceData:Vector.<Rectangle> = new Vector.<Rectangle>(9);
			
			var theX:int, theY:int;
			
			theX = pXOffset;
			theY = pYOffset;
			theSliceData[TOP_L] = new Rectangle(theX, theY, pW0, pH0); theX += pW0;
			theSliceData[TOP_C] = new Rectangle(theX, theY, pW1, pH0); theX += pW1;
			theSliceData[TOP_R] = new Rectangle(theX, theY, pW2, pH0);
			theX = pXOffset;
			theY += pH0;
			
			theSliceData[MID_L] = new Rectangle(theX, theY, pW0, pH1); theX += pW0;
			theSliceData[MID_C] = new Rectangle(theX, theY, pW1, pH1); theX += pW1;
			theSliceData[MID_R] = new Rectangle(theX, theY, pW2, pH1);
			theX = pXOffset;
			theY += pH1;
			
			theSliceData[BOTTOM_L] = new Rectangle(theX, theY, pW0, pH2); theX += pW0;
			theSliceData[BOTTOM_C] = new Rectangle(theX, theY, pW1, pH2); theX += pW1;
			theSliceData[BOTTOM_R] = new Rectangle(theX, theY, pW2, pH2);
			
			return new Sprite9Sliced( pTexture, theSliceData );
		}
		
		public static function makeFromTextures( pTextures:Vector.<Texture>, pParentTexture:Texture=null ):Sprite9Sliced {
			if (pTextures.length != 9) {
				throw new Error("Their must be exactly 9 slices in the supplied vector!");
			}
			
			if (!pParentTexture) {
				pParentTexture = SubTexture(pTextures[0]).parent;
			}
			
			var theSliceData:Vector.<Rectangle> = new Vector.<Rectangle>(9);
			
			var theTexture:TextureBase;
			var currentTex:SubTexture;
			var region:Rectangle;
			
			for (var i:int = 0; i < theSliceData.length; i++) {
				currentTex =	pTextures[i] as SubTexture;
				region = currentTex.frame.clone();
				region.offset( currentTex.clipping.x * pParentTexture.width, currentTex.clipping.y * pParentTexture.height );
				theSliceData[i] = region
				if (!theTexture) theTexture = currentTex.base;
				else if (theTexture != currentTex.base) {
					throw new Error("Each textures in the 9-slice should coexist in the same base Texture resource!");
				}
			}
			
			return new Sprite9Sliced( pParentTexture, theSliceData );
		}
		
		public static function makeFromAtlasAndNames( pAtlas:TextureAtlas, pNames:Array ):Sprite9Sliced {
			if (!pNames || pNames.length != 9) {
				throw new Error("There must be exactly 9 names in the supplied array!");
			}
			
			var textures:Vector.<Texture> = new Vector.<Texture>(9);
			for (var t:int = 0, tLen:int = textures.length; t < tLen; t++) {
				textures[t] = pAtlas.getTexture( pNames[t] );
			}
			
			return makeFromTextures( textures, pAtlas.texture );
		}
		
		private static function loopValue( pValue:int, pTextureSize:int ):int {
			return pValue < 0 ? pTextureSize + pValue : pValue;
		}
		
		private function initImages():void {
			_slices =	new Vector.<Image>(_sliceRegions.length);
			
			for (var r:int = 0, rLen:int = _sliceRegions.length; r < rLen; r++) {
				var sliceTex:Texture = Texture.fromTexture( _texture, _sliceRegions[r] );
				
				var sliceImage:Image =	new Image(sliceTex);
				sliceImage.alpha = 0.8;
				//Logger.log("Creating slice $0 = $1", [r, sliceImage]);
				
				_slices[r] =	sliceImage;
			}
			
			
			addChild( _slices[MID_C] );
			addChild( _slices[MID_L] );
			addChild( _slices[MID_R] );
			addChild( _slices[TOP_C] );
			addChild( _slices[BOTTOM_C] );
			addChild( _slices[TOP_L] );
			addChild( _slices[TOP_R] );
			addChild( _slices[BOTTOM_L] );
			addChild( _slices[BOTTOM_R] );
			
			//INIT POSITIONS:
			var offsetX:Number =	_slices[TOP_L].width;
			var offsetY:Number =	_slices[TOP_L].height;
			
			_slices[TOP_C].x =	offsetX;
			
			_slices[MID_L].y =	offsetY;
			
			_slices[MID_C].x =	offsetX;
			_slices[MID_C].y =	offsetY;
			
			_slices[MID_R].y =	offsetY;
			
			_slices[BOTTOM_C].x =	offsetX;
			
			_widthMin = _sliceRegions[TOP_L].width + _sliceRegions[TOP_R].width;
			_heightMin = _sliceRegions[TOP_L].height + _sliceRegions[BOTTOM_L].height;
			
			setSize();
		}
		
		public function replaceBackground( pNewSlice:Image ):Sprite9Sliced {
			var oldSlice:Image =	_slices[MID_C];
			
			pNewSlice.x =		oldSlice.x;
			pNewSlice.y =		oldSlice.y;
			pNewSlice.width =	oldSlice.width;
			pNewSlice.height =	oldSlice.height;
			
			oldSlice.removeFromParent(true);
			_slices[MID_C] =	pNewSlice;
			
			addChild( pNewSlice );
			
			return this;
		}
		
		public function setSize(pWidth:Number=-1, pHeight:Number=-1):void {
			_width =	pWidth > _widthMin ? pWidth : _widthMin;
			_height =	pHeight > _heightMin ? pHeight : _heightMin;
			
			var cornerWidthLeft:Number =		_slices[TOP_L].width;
			var cornerWidthRight:Number =		_slices[TOP_R].width;
			var cornerHeightTop:Number =		_slices[TOP_L].height;
			var cornerHeightBottom:Number =		_slices[BOTTOM_L].height;
			
			var slice:Image;
			
			///////////////////////////////////////////////
			
			//Top Left:
			//DO NOTHING -> slice =	_sliceImages[0];
			
			slice =			_slices[TOP_C];
			slice.x =		cornerWidthLeft - _overlapAmount;
			slice.width =	_width - cornerWidthRight - cornerWidthLeft + 2 * _overlapAmount;
			
			slice =			_slices[TOP_R];
			slice.x =		_width - cornerWidthRight;
			
			slice =			_slices[MID_L];
			slice.y =		cornerHeightTop - _overlapAmount;
			slice.height =	_height - cornerHeightBottom - cornerHeightTop + 2 * _overlapAmount;
			
			slice =			_slices[BOTTOM_L];
			slice.y =		_height - cornerHeightBottom;
			
			//REMAINING:
			slice =			_slices[MID_C];
			slice.x =		_slices[TOP_C].x;
			slice.width =	_slices[TOP_C].width;
			slice.y =		_slices[MID_L].y;
			slice.height =	_slices[MID_L].height;
			
			slice =			_slices[MID_R];
			slice.x =		_slices[TOP_R].x;
			slice.width =	_slices[TOP_R].width;
			slice.y =		_slices[MID_L].y;
			slice.height =	_slices[MID_L].height;
			
			slice =			_slices[BOTTOM_C];
			slice.x =		_slices[TOP_C].x;
			slice.width =	_slices[TOP_C].width;
			slice.y =		_slices[BOTTOM_L].y;
			slice.height =	_slices[BOTTOM_L].height;
			
			slice =			_slices[BOTTOM_R];
			slice.x =		_slices[TOP_R].x;
			slice.width =	_slices[TOP_R].width;
			slice.y =		_slices[BOTTOM_L].y;
			slice.height =	_slices[BOTTOM_L].height;
			/*
			//Top Center:
			slice =			_slices[TOP_C];
			slice.x =		_slices[TOP_L].width - _overlapAmount;
			slice.width =	_width - cornerWidthDouble;
			
			//Top Right:
			slice =			_slices[TOP_R];
			slice.x =		_slices[TOP_C].x + _slices[TOP_C].width;
			
			///////////////////////////////////////////////
			
			//Mid Left:
			slice =			_slices[MID_L];
			slice.height =	_height - cornerHeightDouble;
			
			//Mid Center:
			slice =			_slices[MID_C];
			slice.x =		_slices[TOP_L].width - _overlapAmount;
			slice.y =		_slices[TOP_L].height - _overlapAmount;
			slice.width =	_width - cornerWidthDouble + _overlapAmount * 2;
			slice.height =	_slices[MID_L].height + _overlapAmount * 2;
			
			//Mid Right:
			slice =			_slices[MID_R];
			slice.x =		_slices[TOP_R].x;
			slice.height =	_slices[MID_L].height;
			
			///////////////////////////////////////////////
			
			//Bottom Left:
			slice =			_slices[BOTTOM_L];
			slice.y =		_slices[MID_L].y + _slices[MID_L].height;
			
			//Bottom Center:
			slice =			_slices[BOTTOM_C];
			slice.x =		_slices[TOP_C].x;
			slice.y =		_slices[BOTTOM_L].y;
			slice.width =	_slices[TOP_C].width;
			
			//Bottom Right:
			slice =			_slices[BOTTOM_R];
			slice.x =		_slices[TOP_R].x;
			slice.y =		_slices[BOTTOM_L].y;
			
			///////////////////////////////////////////////
			*/
		}
		
		override public function get width():Number { return _width; }
		public override function set width(value:Number):void {
			_width = value;
			
			setSize( _width, _height );
		}
		
		override public function get height():Number { return _height; }
		public override function set height(value:Number):void {
			_height = value;
			
			setSize( _width, _height );
		}
		
		public function get overlapAmount():int { return _overlapAmount; }
		public function set overlapAmount(value:int):void {
			_overlapAmount = value;
			
			setSize(_width, _height);
		}
		
	}

}