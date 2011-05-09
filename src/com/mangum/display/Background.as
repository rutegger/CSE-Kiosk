package com.mangum.display{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class Background extends Sprite{
		
		[Embed (source="/../assets/bg1.jpg")]
		private var Bg1:Class; 
		private var bg1:Bitmap;
		
		[Embed (source="/../assets/bg2.jpg")]
		private var Bg2:Class; 
		private var bg2:Bitmap;
		
		[Embed (source="/../assets/bg3.jpg")]
		private var Bg3:Class; 
		private var bg3:Bitmap;
		
		private const TRANSITION_SPEED:Number = 5;
		
		
		public function Background(){
			bg1 = new Bg1();
			addChild(bg1);
			
			bg2 = new Bg2();
			addChild(bg2);
			
			bg3 = new Bg3();
			addChild(bg3);
			
			bg2.alpha = 0;
			bg3.alpha = 0;
		}
		
		
		public function setImage(val:String):void{
			trace("setImage: "+val);
			switch(val){
				case "satellite":	
					TweenLite.to(bg2, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
					TweenLite.to(bg3, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
					TweenLite.to(bg1, TRANSITION_SPEED, {alpha:1, ease:Circ.easeOut}); // show
					break;
				case "cancer":				
					TweenLite.to(bg1, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
					TweenLite.to(bg3, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
					TweenLite.to(bg2, TRANSITION_SPEED, {alpha:1, ease:Circ.easeOut}); // show
					break;
				case "yt":
					TweenLite.to(bg1, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
					TweenLite.to(bg2, TRANSITION_SPEED, {alpha:0, ease:Circ.easeOut}); // hide
					TweenLite.to(bg3, TRANSITION_SPEED, {alpha:1, ease:Circ.easeOut}); // show
					break;		
			}
			
		}
	}
	
}