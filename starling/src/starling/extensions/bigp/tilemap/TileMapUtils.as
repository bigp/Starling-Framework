package starling.extensions.bigp.tilemap {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	/**
	 * ...
	 * @author Pierre Chamberlain
	 */
	public class TileMapUtils {
		
		public static function generateAtlas( pAsset:*, pFrameWidth:int, pFrameHeight:int, pTileRect:Rectangle=null, pPrefix:String="tile_", pMipMapped:Boolean=false ):TextureAtlas {
			var bmp:BitmapData;
			if (pAsset is Class) {
				bmp = Bitmap(new pAsset).bitmapData;
			} else if (pAsset is Bitmap) {
				bmp = Bitmap(pAsset).bitmapData;
			} else if (pAsset is BitmapData) {
				bmp = pAsset as BitmapData;
			} else {
				throw new Error("Unsupported asset type: " + pAsset);
			}
			
			if (!pTileRect) {
				pTileRect = new Rectangle(0, 0, pFrameWidth, pFrameHeight);
			}
			
			var tex:Texture =			Texture.fromBitmapData( bmp, pMipMapped );
			var atlas:TextureAtlas =	new TextureAtlas( tex );
			
			var tileID:int =	0;
			for (var r:int = 0, rLen:int = tex.height / pFrameHeight; r < rLen; r++) {
				for (var c:int = 0, cLen:int = tex.width / pFrameWidth; c < cLen; c++) {
					var region:Rectangle =	new Rectangle(
						c * pFrameWidth + pTileRect.x,
						r * pFrameHeight + pTileRect.y,
						pTileRect.width,
						pTileRect.height
					);
					atlas.addRegion("tile_" + tileID, region);
					tileID++;
				}
			}
			
			return atlas;
		}
	}
}