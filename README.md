Starling Framework (BigP Edits)
===============================

This is a revised version of the Starling framework with a few additional features you may like!

* [MovieClip](https://github.com/bigp/Starling-Framework/blob/master/starling/src/starling/display/MovieClip.as) callback method on frames.
* [Sprite9Slice](https://github.com/bigp/Starling-Framework/blob/master/starling/src/starling/extensions/bigp/Sprite9Sliced.as) for all your 9-slicing needs!
* [Image](https://github.com/bigp/Starling-Framework/blob/master/starling/src/starling/display/Image.as) default smoothing can be assigned on [TextureSmoothing.DEFAULT](https://github.com/bigp/Starling-Framework/blob/master/starling/src/starling/textures/TextureSmoothing.as) static property.
* [BitmapImage](https://github.com/bigp/Starling-Framework/blob/master/starling/src/starling/extensions/bigp/BitmapImage.as) for dynamically updating a BitmapData to the GPU (requires call to invalidate()).
* [ScrollImage](https://github.com/bigp/Starling-Framework/blob/master/starling/src/starling/extensions/bigp/ScrollImage.as) for UV scrolling, scaling and clipping support.
* [PreloaderStarling](https://github.com/bigp/Starling-Framework/blob/master/starling/src/com/bigp/preloaders/PreloaderStarling.as) class to setup your App/Game with a built-in Preloader (2 frames flash.display.MovieClip, basically).
* [BlendMode](https://github.com/bigp/Starling-Framework/blob/master/starling/src/starling/display/BlendMode.as) lookup table (useful for Tweening between Blendmodes, sorta).
* [DisplayObject](https://github.com/bigp/Starling-Framework/blob/master/starling/src/starling/display/DisplayObject.as) has childIndex, getChildPrev(), getChildNext().
* [Starling](https://github.com/bigp/Starling-Framework/blob/master/starling/src/starling/core/Starling.as) class now has static Signals to dispatch callbacks during rendering phases (good for detecting draw-counts, Pre/Post rendering)

 * Starling.whenDrawCallStart;
 * Starling.whenDrawCallCount;
 * Starling.whenDrawCallEnd;
 * Starling.whenStateChanges;

Also includes other extensions that are typically used:

* ParticleDesigner classes for Particle system support.
* AS3 Signals (from org.osflash.signals).


Just care about the SWC?
------------------------

Grab it here: [Starling_BigP_SWC.swc](https://github.com/bigp/Starling-Framework/raw/master/starling/bin/Starling_BigP_SWC.swc)

Where do I find more information about Starling?
------------------------------------------------

Here are a few starting points:

* [Official Homepage](http://www.starling-framework.org)
* [API Reference](http://doc.starling-framework.org)
* [Support Forum](http://forum.starling-framework.org)
* [Starling Wiki](http://wiki.starling-framework.org)
  * [Showcase](http://wiki.starling-framework.org/games/start)
  * [Books, Courses, Tutorials](http://wiki.starling-framework.org/tutorials/start)
  * [Extensions](http://wiki.starling-framework.org/extensions/start)

[1]: http://www.sparrow-framework.org
