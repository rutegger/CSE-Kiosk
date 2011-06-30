/**
 * Try to make this dynamic using Loader rather than Embed 
 */
package com.mangum.display{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.events.*;
	import flash.net.URLRequest;

	
	public class Background extends Sprite{
		
		private var _screens:Array; // make dynamic
	
		
		[Embed (source="/../assets/bg0.jpg")]
		private var Bg0:Class; 
		private var bg0:Bitmap;
		
		[Embed (source="/../assets/bg1.jpg")]
		private var Bg1:Class; 
		private var bg1:Bitmap;
		
		[Embed (source="/../assets/bg2.jpg")]
		private var Bg2:Class; 
		private var bg2:Bitmap;
		
		[Embed (source="/../assets/bg3.jpg")]
		private var Bg3:Class; 
		private var bg3:Bitmap;
		
		private const TRANSITION_SPEED:Number = 3;
		
		
		public function Background(screens:Array){
			
			_screens = screens;
			
			bg0 = new Bg0();
			addChild(bg0);
			
			bg1 = new Bg1();
			addChild(bg1);
			
			bg2 = new Bg2();
			addChild(bg2);
			
			bg3 = new Bg3();
			addChild(bg3);
			
			bg1.alpha = 0;
			bg2.alpha = 0;
			bg3.alpha = 0;
		}
		
		public function setImage(val:String):void{
			switch(val){
				case _screens[0].id:	
					TweenLite.to(bg0, TRANSITION_SPEED, {alpha:1, ease:Circ.easeOut}); // show
					TweenLite.to(bg1, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
					TweenLite.to(bg2, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
					TweenLite.to(bg3, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide	
					break;
				case _screens[1].id:	
					TweenLite.to(bg0, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
					TweenLite.to(bg1, TRANSITION_SPEED, {alpha:1, ease:Circ.easeOut}); // show
					TweenLite.to(bg2, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
					TweenLite.to(bg3, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide	
					break;
				case _screens[2].id:		
					TweenLite.to(bg0, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
					TweenLite.to(bg1, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
					TweenLite.to(bg3, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
					TweenLite.to(bg2, TRANSITION_SPEED, {alpha:1, ease:Circ.easeOut}); // show
					break;
				case _screens[3].id:
					TweenLite.to(bg0, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
					TweenLite.to(bg1, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
					TweenLite.to(bg2, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
					TweenLite.to(bg3, TRANSITION_SPEED, {alpha:1, ease:Circ.easeOut}); // show
					break;		
				case _screens[4].id:
//					TweenLite.to(bg0, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
//					TweenLite.to(bg1, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
//					TweenLite.to(bg2, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
//					TweenLite.to(bg3, TRANSITION_SPEED, {alpha:1, ease:Circ.easeOut}); // show
					break;		
			}
			
		}
	}
	
}