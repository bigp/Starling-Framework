package com.bigp.preloaders {
	import flash.display3D.Context3DProfile;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Pierre Chamberlain
	 */
	public class PreloaderStarling extends Preloader_Base {
		public static var starling:Starling;
		
		protected var __autoResizes:Boolean = false;
		protected var __autoAdaptResolution:Boolean = false;
		
		public function PreloaderStarling(pName:String=null) {
			super(pName);
			
			__autoAttach = false;
			__autoInstantiate = false;
			
		}
		
		protected override function _prepare():void {
			super._prepare();
			
			Starling.handleLostContext = true;
			starling = new Starling( __mainClass, stage, null, null, "auto", Context3DProfile.BASELINE );
			
			if (__autoResizes) {
				stage.addEventListener(Event.RESIZE, onResize);
			}
		}
		
		private function onResize(e:Event):void {
			starling.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			if(__autoAdaptResolution) {
				starling.stage.stageWidth = stage.stageWidth;
				starling.stage.stageHeight = stage.stageHeight;
			}
		}
	}
}