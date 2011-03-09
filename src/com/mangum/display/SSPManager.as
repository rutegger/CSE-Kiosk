package com.mangum.display{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.mangum.display.Positioner;
	import com.mangum.display.SSPManager;
	
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.events.Event;
	
	import net.slideshowpro.slideshowpro.*;
	
	public class SSPManager extends Sprite{
		
		private var ssp:SlideShowPro;
		private var _stage:Stage;
		private var _path:String;
		private var resume:Sprite = new Resume();
		private var _playing:Boolean = false;
		
		private const TRANSITION_SPEED:Number = 3;
		
		[Embed (source="/../assets/cse.png")]
		private var Logo:Class; 
		
		
		public function SSPManager(stage:Stage,path:String){
			_stage = stage;
			_path = path;
			mkSSP();
			mkResumeBtn();
		}
		
		public function show(bool:Boolean):void{
			var val:Number = (bool) ? 1 : 0;
			var speed:Number  = (bool) ? TRANSITION_SPEED : TRANSITION_SPEED/3;
			TweenLite.to(ssp, speed, {alpha:val,onComplete:onAlphaTweenComplete, onCompleteParams:[bool]});		
			
			if(bool){
				trace("playMedia");
				ssp.playMedia();
				addChild(resume);
				_playing = true;
			}else{
				trace("pauseMedia");
				ssp.pauseMedia();
				removeResume();
				_playing = false;
			}
		}
		
		private function onAlphaTweenComplete(bool:Boolean):void{
			if(!bool) dispatchEvent(new Event("onFadeOutSSP")); 
		}
		
		private function mkResumeBtn():void{
			resume.name = "resume";
			addChild(resume);
		}
		
		private function removeResume():void{	
			if (this.getChildByName("resume") != null) {
				removeChild(resume);
			}
		}
		
		private function mkSSP():void{
			ssp = new SlideShowPro();	
			//			ssp.pauseMedia();
			ssp.setData(_path,"Director");
			ssp.width = 1680;
			ssp.height = 1050;
//			ssp.contentScale = "Crop to Fit All";
			ssp.directorLargeQuality = 100;
			ssp.transitionStyle = "Cross Fade";
			ssp.transitionLength = 3;
			ssp.transitionPause = 10;
			//			ssp.panZoom = "On";
			ssp.panZoomDirection = "Random";
			ssp.panZoomScale = [1,1.2];		
			ssp.contentOrder = "Sequential";
			ssp.galleryAppearance = "Hidden";
			ssp.mediaPlayerAppearance = "Hidden";
			ssp.navAppearance = "Hidden";
			ssp.feedbackPreloaderAppearance = "Hidden";
			ssp.feedbackTimerAppearance = "Hidden";
			//			ssp.autoFinishMode = "Restart";
			//			ssp.loop = "On";
			//			ssp.startup = "Open Gallery";
			ssp.displayMode = "Auto";	
			addChild(ssp);
			
			ssp.addEventListener(SSPVideoEvent.VIDEO_START, onVideoEvent);
			ssp.addEventListener(SSPModePlaybackEvent.DISPLAY_MODE, onModePlaybackEvent);
			
			var cseLogo:Bitmap = new Logo();
			var container:MovieClip = new MovieClip();
			addChild(container);
			container.addChild(cseLogo);
			Positioner.bottomRight(_stage,container);
			
			var glow:GlowFilter = new GlowFilter(); 
			glow.color = 0xffffff; 
			glow.alpha = .5; 
			glow.blurX = 15; 
			glow.blurY = 15; 
			glow.quality = BitmapFilterQuality.HIGH; 
			glow.strength = .5;
			
			cseLogo.filters = [glow];
			cseLogo.blendMode = "screen";
			_playing = true;
		}		
		
		private function onVideoEvent(event:SSPVideoEvent):void {
			//			if (event.type=="videoStart") {				
			//				ssp.contentScale = "Proportional";
			//				ssp.panZoom = "Off";
			//			} else {
			//				ssp.contentScale = "None";
			//				ssp.panZoom = "On";
			//			}
		}
		
		private function onModePlaybackEvent(event:SSPModePlaybackEvent):void {
			trace("event.mode: "+event.mode);	
			if(event.mode == "Manual"){
				//					ssp.pauseMedia();
				trace(ssp);
				trace("pauseMedia");
			}else{
				ssp.playMedia();
			}
		}
		
		
		
		
	}
	
}