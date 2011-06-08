package com.mangum.display.SSP.controller{
	
	import flash.display.Sprite;
	
	import net.slideshowpro.slideshowpro.*;
	import net.slideshowpro.slideshowpro.SlideShowPro;
	
	
	public class Controller extends Sprite{
		
		private var _ssp:SlideShowPro;
		
		public function Controller(ssp:SlideShowPro){
			_ssp = ssp;
			
			_ssp.addEventListener(SSPVideoEvent.VIDEO_START, onVideoEvent);
			_ssp.addEventListener(SSPModePlaybackEvent.DISPLAY_MODE, onModePlaybackEvent);
		}
		
		public function pauseMe():void{
			trace("controller pauseMe(): "+_ssp.playMedia);
			_ssp.pauseMedia();
		}
		
		private function onVideoEvent(event:SSPVideoEvent):void {
			
		}
		
		private function onModePlaybackEvent(event:SSPModePlaybackEvent):void {
			trace("event.mode: "+event.mode);	
			if(event.mode == "Manual"){
				//	ssp.pauseMedia();
//				trace("pauseMedia");
			}else{
//				_ssp.playMedia();
			}
		}
		
	}
	
}