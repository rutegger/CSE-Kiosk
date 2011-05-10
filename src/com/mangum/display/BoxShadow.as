package com.mangum.display{
	
	import flash.display.MovieClip;
	import flash.filters.DropShadowFilter;
	
	/** 
	 * Main comment text.
	 * 
	 * @tag Tag text.
	 */
	
	
	public class BoxShadow  extends MovieClip{
		
		public function BoxShadow(){
			var shadow:DropShadowFilter = new DropShadowFilter(); 
			shadow.distance = 5; 
			shadow.angle = 30; 
			shadow.alpha = .4;
			shadow.blurX = 20;
			shadow.blurY = 20;
			shadow.quality = 2;	
			this.filters = [shadow];
		}
	}
	
}