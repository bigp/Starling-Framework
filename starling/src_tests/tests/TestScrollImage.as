package tests {
	import assets.Assets;
	import flash.geom.Rectangle;
	import starling.extensions.bigp.ScrollImage;
	import starling.extensions.bigp.tilemap.TileMapUtils;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;

	/**
	 * ...
	 * @author Pierre Chamberlain
	 */
	public class TestScrollImage extends Test_Base {
		private var scroll:ScrollImage;
		public var atlas:TextureAtlas;
		public var counter:int = 0;
		
		public override function begin():void {
			super.begin();
			
			TextureSmoothing.DEFAULT = TextureSmoothing.NONE;
			
			var rect:Rectangle =	new Rectangle(0, 0, 16, 16);
			atlas = TileMapUtils.generateAtlas( Assets.TILES_TEXTURE, 17, 17, rect );
			
			
			scroll = new ScrollImage( atlas.texture, true );
			scroll.pivotX = scroll.width * .5;
			scroll.pivotY = scroll.height * .5;
			scroll.x =	nativeStage.stageWidth * .5;
			scroll.y =	nativeStage.stageHeight * .5;
			
			addChild(scroll);
		}
		
		public override function update():void {
			super.update();
			
			counter++;
			
			scroll.uvScaleX = 1 + Math.cos(counter * 0.005) * 0.5;
			scroll.uvScaleY = 1 + Math.sin(counter * 0.005) * 0.5;
			scroll.scrollX += 0.1;
			scroll.scrollY += 0.1;
			scroll.rotation += 0.01;
		}
	}
}