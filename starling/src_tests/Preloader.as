package  {
	import com.bigp.preloaders.PreloaderStarling;
	

	/**
	 * ...
	 * @author Pierre Chamberlain
	 */
	public class Preloader extends PreloaderStarling {
		
		public function Preloader() {
			super();
			
			startLoading();
			
			__autoResizes = true;
			__autoAdaptResolution = true;
		}
		
		protected override function _prepare():void {
			super._prepare();
			
			starling.showStats = true;
		}
	}
}