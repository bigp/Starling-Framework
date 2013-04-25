package com.bigp.preloaders {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	

	/**
	 * ...
	 * @author Pierre Chamberlain
	 */
	// Typically, you want to add something like this on your Main class --> [Frame(factoryClass = "Preloader")]
	public class Preloader_Base extends MovieClip {
		//public static var MAIN_CLASS:Class;
		
		public static var STAGE:Stage;
		private static var SAFE_DELAY:int =		2;
		
		protected var _draw:PreloaderDraw;
		private var _safeDelay:int =	0;
		
		public var __mainClassName:String;
		public var __mainClass:Class;
		public var __mainInst:Object;
		
		public var __percentage:Number = 0;
		
		public var useDefaultBar:Boolean =		true;
		public var tweenEnabled:Boolean =		true;
		public var tweenFadeSpeed:Number =		0.1;
		
		public var __autoInstantiate:Boolean =	true;
		public var __autoAttach:Boolean =		true;
		public var useSafeDelay:Boolean =		true;
		
		public function Preloader_Base( pMainClassName:String=null ) {
			super();
			stop();
			
			__mainClassName = pMainClassName==null ? "Main" : pMainClassName;
			
			if (!__mainClassName) {
				throw new Error("A Main-ClassName must be supplied to the preloader class.\n" +
								"Extend the type of preloader and pass it the main class as a string (fully qualified path).");
			}
		}
		
		public function startLoading():void {
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event=null):void {
			e && removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.align =		StageAlign.TOP_LEFT;
			stage.scaleMode =	StageScaleMode.NO_SCALE;
			
			__percentage =	0;
			
			if (useDefaultBar) {
				createBar();
			}
			
			addEventListener(Event.ENTER_FRAME, _onLoadingProgress);
		}
		
		private function createBar():void {
			_draw =		new PreloaderDraw( addChild(new Sprite) as Sprite, 100, 5 );
			_draw.x =	(stage.stageWidth - _draw.width) >> 1;
			_draw.y =	(stage.stageHeight- _draw.height) >> 1;
		}
		
		protected function _onLoadingProgress(e:Event):void {
			if (!checkLoaded()) {
				return;
			}
			
			removeEventListener( e.type, _onLoadingProgress );
			if (tweenEnabled) {
				addEventListener(Event.ENTER_FRAME, onTweenWhenFinished);
			} else {
				_prepare();
			}
		}
		
		private function onTweenWhenFinished(e:Event):void {
			_draw.target.alpha -= tweenFadeSpeed;
			
			if (_draw.target.alpha <= 0) {
				removeEventListener(e.type, onTweenWhenFinished);
				_prepare();
			}
		}
		
		public function checkLoaded():Boolean {
			var info:LoaderInfo =	this.loaderInfo;
			
			if (!info || !info.bytes || info.bytes.length == 0) {
				return false;
			}
			
			var bytesLoaded:uint =	info.bytesLoaded;
			var bytesTotal:uint =	info.bytesTotal;
			
			if (bytesLoaded < 1 || bytesTotal < 1) {
				_draw && _draw.drawPercent( 0 );
				return false;
			}
			
			__percentage = bytesLoaded / bytesTotal;
			
			_draw && _draw.drawPercent( __percentage );
			
			var areBytesCompleted:Boolean =	bytesLoaded == bytesTotal;
			if (useSafeDelay) {
				if (areBytesCompleted) {
					_safeDelay++;
					if (_safeDelay >= SAFE_DELAY) {
						return true;
					}
				}
				
				return false;
			}
			return areBytesCompleted;
		}
		
		protected function _prepare():void {
			nextFrame();
			
			if (_draw) {
				_draw.destroy();
				_draw = null;
			}
			
			STAGE = stage;
			
			__mainClass =	stage.loaderInfo.applicationDomain.getDefinition(__mainClassName) as Class;
			
			if (__autoInstantiate) {
				_instantiate();
			}
			
			// ... OVERRIDE (Let the subclass complete the rest of this method.
		}
		
		protected function _instantiate():void {
			if (__mainInst) {
				return;
			}
			
			__mainInst = new __mainClass();
			
			if (__autoAttach && __mainInst is DisplayObject) {
				stage.addChild( __mainInst as DisplayObject );
			}
		}
		
		
	}
}