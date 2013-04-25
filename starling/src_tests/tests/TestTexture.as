package tests {
	import assets.Assets;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.extensions.bigp.Sprite9Sliced;
	import starling.extensions.bigp.tilemap.TileMapUtils;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;

	/**
	 * ...
	 * @author Pierre Chamberlain
	 */
	public class TestTexture extends Test_Base {
		private var slice:Sprite9Sliced;
		public var atlas:TextureAtlas;
		
		public override function begin():void {
			super.begin();
			
			TextureSmoothing.DEFAULT = TextureSmoothing.NONE;
			
			var rect:Rectangle =	new Rectangle(0, 0, 16, 16);
			atlas = TileMapUtils.generateAtlas( Assets.TILES_TEXTURE, 17, 17, rect );
			
			makeTileAt("tile_1", 10, 10);
			makeTileAt("tile_2", 30, 20);
			makeTileAt("tile_3", 50, 120);
			makeTileAt("tile_4", 160, 240);
			makeTileAt("tile_5", 300, 40);
			
			slice = Sprite9Sliced.makeFromAtlasAndNames(atlas, "tile_8,tile_9,tile_10,tile_25,tile_26,tile_27,tile_42,tile_43,tile_44".split(",") );
			slice.overlapAmount = 0;
			addChild(slice);
		}
		
		public override function update():void {
			super.update();
			
			var sizeW:int =	Math.abs(nativeStage.mouseX - nativeStage.stageWidth * .5) * 2;
			var sizeH:int =	Math.abs(nativeStage.mouseY - nativeStage.stageHeight * .5) * 2;
			slice.setSize( sizeW, sizeH );
			
			slice.x = (stage.stageWidth - slice.width) * .5 / this.scaleX;
			slice.y = (stage.stageHeight - slice.height) * .5 / this.scaleY;
		}
		
		public function makeTileAt( pName:String, pX:int, pY:int ):void {
			var img:Image =  new Image(atlas.getTexture(pName) );
			img.x = pX;
			img.y = pY;
			
			addChild(img);
		}
	}
}