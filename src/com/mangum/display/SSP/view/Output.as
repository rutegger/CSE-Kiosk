package com.mangum.display.SSP.view{
	
	import flash.display.Sprite;
	
	import net.slideshowpro.slideshowpro.SSPModePlaybackEvent;
	import net.slideshowpro.slideshowpro.SlideShowPro;
	
	
	public class Output extends Sprite{
		
		private var _ssp:SlideShowPro;
		private var _playing:Boolean = false;		
		private const TRANSITION_SPEED:Number = 3;	
		
		public function Output(ssp:SlideShowPro){
			_ssp = ssp;
			addChild(_ssp);
			config(_ssp);
			

		}		
		
		/* PUBLIC METHODS */
		
		public function pauseMe():void{
			_ssp.displayMode = "Manual"; //have to set the displayMode to 'Manual' before using pauseMedia
			_ssp.pauseMedia();
		}
		
		public function playMe():void{
			_ssp.playMedia();
			_ssp.displayMode = "Auto"; //have to set the displayMode to 'Auto' so slideshow continues
		}
		
		
		/* PRIVATE METHODS */
		
		private function config(ssp:SlideShowPro):void{
			ssp.width = 900;
			ssp.height = 600;
			ssp.contentScale = "Crop to Fit All";
			ssp.directorLargeQuality = 100;
			ssp.transitionStyle = "Cross Fade";
			ssp.transitionLength = 3;
			ssp.transitionPause = 5;	
			ssp.panZoom = "On"
			ssp.panZoomDirection = "Random";
			ssp.panZoomScale = [1,1.2];	
			ssp.captionAppearance = "Overlay Auto (if Available)";
			ssp.captionPosition = "Bottom";
			ssp.captionTextSize = 14;
			ssp.captionTextColor = 0xF2EFEA;
			ssp.captionElements = "Caption Only";
			ssp.captionHeaderBackgroundAlpha = .6;
			ssp.contentOrder = "Sequential";
//			ssp.galleryAppearance = "Hidden";
			ssp.mediaPlayerAppearance = "Hidden";
			ssp.navAppearance = "Hidden";
			ssp.feedbackPreloaderAppearance = "Hidden";
			ssp.feedbackTimerAppearance = "Hidden";			
//			ssp.displayMode = "Auto";		
			ssp.pauseMedia();
			
		}
	}
	
}