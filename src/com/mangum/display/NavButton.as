package com.mangum.display{
	
	import flash.display.MovieClip;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	
	public class NavButton extends MovieClip{
		
		private var bgColor:uint = 0xFFCC00;
		private var size:uint    = 80;
		private var offset:uint  = 50;
//		private var navText:NavText;
		
		public function NavButton():void {	
			trace("NavButton");
//			trace(navText);
//			glow(navText);
			
		}
	
		private function glow(mc:MovieClip):void{
			var glow:GlowFilter = new GlowFilter(); 
			glow.color = 0x009922; 
			glow.alpha = 1; 
			glow.blurX = 25; 
			glow.blurY = 25; 
			glow.quality = BitmapFilterQuality.MEDIUM; 
			
			mc.filters = [glow];
			trace("***>" +mc);
		}
		
	}
}