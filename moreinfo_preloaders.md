Using the PreloaderStarling Class
======================

To use this class, you should first subclass it with your very own Preloader class (this may not be a requirement in the future, though).

For example, let's create one called "Preloader":


	package  {
		import com.bigp.preloaders.PreloaderStarling;
	
		/**
		 * ...
		 * @author Pierre Chamberlain
		 */
		public class Preloader extends PreloaderStarling {
			
			public function Preloader() {
				super();
				
				__autoAdaptResolution = true;
				__autoResizes = true;
				
				startLoading();
			}
			
			protected override function _instantiate():void {
				super._instantiate();
			}
		}
	}

 * **__autoResizes**: Handles **Event.RESIZE** internally. *(Not tested with fullscreen support though...)*
 * **__autoAdaptResolution**: When resized, it ensures that the stage doesn't stretch. It extends the stage if you maximize the window (in an AIR app, for example).

**NOTE**: The syntax for the *overrideable* AND *customizable properties* are single and double-underscored "__" to make them more obvious *(mostly for alphabetical Auto-Completion reasons...)*

To actually START your application, you must call `startLoading()` manually. The reason for this is to initialize anything you need beforehand, to avoid any race-conditions or weird Flash unexpected behaviors.

By default, the Preloader will attempt to load a class called "Main" (at the top-level default package).

If you wish to change this to something else, just provide the fully-qualified class name in the super constructor, like so:

	public function Preloader() {
		super("your.fully.qualified.ClassName");
		
		startLoading();
	}

**IMPORTANT**: Additionally, you will need to add some **Additional Compiler Arguments** to make sure your Main classes is embedded in your SWF and your Preloader knows where to find it. To do this simply add the following in your compiler arguments:

 * For top-level classes, simply add: **-frame=Label,YourMain**
 * For deeper package classes, add: **-frame=Label,full.qualified.path.of.your.class.YourMain**
 
 
 Your Main.as Class
===========
 
Typically, you normally have to use a standard `flash.display.Sprite` or `MovieClip` for your Main class to correctly hook into the Flash display list. Only after initializing Starling - then you could instantiate your actual MainStarling class. But that's too much work!

It gets easier!

Using this `PreloaderStarling` class, you can immediatly extend your Main class to a `starling.display.Sprite` class (or other subclasses of `DisplayObject`)! You can then optionally put an event listener to know when the Main instances has been added to the Starling display-list, like so:

		addEventListener(Event.ADDED_TO_STAGE, onAdded);
	
 That pretty much summarizes the usage of the PreloaderStarling class. Hope it's easy for you to use!
 
 Got any questions? You can send me a tweet at **@_bigp** or email at [bigp@pierrechamberlain.ca](mailto:bigp@pierrechamberlain.ca)
 
 Happy *Starling-ing*!
 
