package com.mangum.display.YT.model{
	
	import ca.newcommerce.youtube.DataTracer;
	import ca.newcommerce.youtube.events.VideoDataEvent;
	import ca.newcommerce.youtube.webservice.YouTubeFeedClient;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.mangum.display.HitArea;
	import com.mangum.events.ActionEvent;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.Security;
	
	
	public class YTLoader extends MovieClip{
		
		private var player:Object; // This will hold the API player instance once it is initialized.	
		private var loader:Loader = new Loader();	
		private var _id:String;
		private var _w:Number;
		private var _h:Number;
		private var _thumb:Boolean;
		private var _bool:Boolean = true;	
//		private var blocker:Sprite = new BlockerMC();
		private var linkBlocker:YTLinkBlocker = new YTLinkBlocker();
		private var attempts:int = 0;
		
		public function YTLoader(id:String, w:Number, h:Number, thumb:Boolean){
			//		trace("YTLoader constructor id: "+id);
			_id = id;
			_w = w;
			_h = h;
			_thumb = thumb;
			
			Security.allowInsecureDomain("*");
			Security.allowDomain("*");
			
			var url:String = (thumb) ? "http://www.youtube.com/apiplayer?version=3" : "http://www.youtube.com/v/"+_id+"?version=3";
			
			var myRequest:URLRequest = new URLRequest(url);						
			
			loader.load(myRequest);			
			loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);								
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError,false,0,true);
			
		}

		
		private function onIOError(e:IOErrorEvent):void{
			attempts ++;
			if(attempts < 4){
				trace("io error #"+attempts+": "+e);
				// try again...
				var myRequest:URLRequest = new URLRequest("http://www.youtube.com/apiplayer?version=3");		
				loader.load(myRequest);		
			} else {
				trace("ERROR: after 3 attempts I gave up. Handle YT fail...");
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			}
			
		}		
		
		protected function doVideoInfoReady(evt:VideoDataEvent):void {
			//			_wsFeed.removeEventListener(VideoDataEvent.VIDEO_INFO_RECEIVED, doVideoInfoReady);	
			var data:Object = DataTracer.traceVideo(evt.video);
			//			trace(data.actualId+" title: " + data.title);
		}
		
		
		/* EVENT HANDLERS */
		
		private function onLoaderInit(event:Event):void {
			loader.contentLoaderInfo.removeEventListener(Event.INIT, onLoaderInit);
			addChild(loader);		
			loader.content.addEventListener("onReady", onPlayerReady,false,0,true);
			loader.content.addEventListener("onError", onPlayerError);
			loader.content.addEventListener("onStateChange", onPlayerStateChange);
			loader.content.addEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
		}
		
		private function onPlayerReady(event:Event):void {
			loader.content.removeEventListener("onReady", onPlayerReady);

			player = loader.content;
			player.cueVideoById(_id,10);
			player.setSize(_w, _h);		
			
			//			trace("******* "+_id+" quality level: "+player.getAvailableQualityLevels());
			
			//	player.loadVideoById(_vid); 
			//	player.setPlaybackQuality("hd720");
			//	player.cueVideoById(videoId:String, startSeconds:Number, suggestedQuality:String):Void
			//	player.cueVideoByUrl('http://www.youtube.com/user/CockrellSchool#p/c/C7FAB0C2D25EC82D');
			
			if (_thumb){
				mkButton();	
			} else {
				player.cueVideoById(_id);
//				addChild(blocker);
//				blocker.x = _w - blocker.width;
//				blocker.y = _h - blocker.height-1;
				addChild(linkBlocker);
				linkBlocker.x = _w - linkBlocker.width - 45;
				linkBlocker.y = _h - linkBlocker.height - 25;
				linkBlocker.width = 95;
				linkBlocker.height = 45;
//				alpha = 0;
			}
		}				
		
		private function onPlayerError(event:Event):void {
			//			trace("player error:", Object(event).data);
		}
		
		private function onPlayerStateChange(event:Event):void {
			//			trace("player state:", Object(event).data);	
			if(Object(event).data == 1){
				this.addEventListener(Event.ENTER_FRAME, onEnter, false, 0, true);
			} else if(Object(event).data == 2){
				this.removeEventListener(Event.ENTER_FRAME, onEnter);
			}			
		}
		
		private function onVideoPlaybackQualityChange(event:Event):void {
			//			trace("video quality:", Object(event).data);
		}				
		
		private function onClicked(e:Event):void{
			//			var s:Sprite = Sprite(e.currentTarget)
			//			s.alpha = .5;
			//			trace("player.getDuration(): "+player.getVideoUrls());
			dispatchEvent(new ActionEvent(_id, "selected", true));			
		}
		
		private function onEnter(e:Event):void{
			//			trace("*******> "+_id+": "+player.getDuration(), player.getCurrentTime());
			if(player.getDuration()!= 0 && player.getDuration() - 1 < player.getCurrentTime()){
				player.seekTo(0);
				player.pauseVideo();
				this.removeEventListener(Event.ENTER_FRAME, onEnter);
			} 
		}
		
		
		/* PRIVATE METHODS */
		
		private function setSize(_w:Number):void{
			player.setSize(_w, _h);
		}		
		
		private function mkButton():void{			
			// create btn to override youtube mov click
			var hitArea:HitArea = new HitArea(0,0,_w,_h);				
			addChild(hitArea);				
			hitArea.addEventListener("clicked", onClicked,false,0,true);	
		}		
		
		/* PUBLIC METHODS */
		
		public function playVideo(id:String):void{
			player.loadVideoById(id,0);
		}
		
		public function highlight(bool:Boolean=true):void{
			if(bool){
				TweenMax.to(this, 2, {glowFilter:{color:0xff6600, alpha:1, blurX:30, blurY:30, strength:1}, ease:Quart.easeOut});
			}else{
				TweenMax.to(this, .1, {glowFilter:{color:0xff6600, alpha:1, blurX:30, blurY:30, strength:0}});
			}			
		}
		
		public function pause():void{
//			trace(">>>>>>>>> "+player.getPlayerState());
			switch(player.getPlayerState()){ //ended (0), playing (1), paused (2), buffering (3), video cued (5).
				case 0: // ended
					player.pauseVideo();
					break;
				case -1: // unstarted
//					player.pauseVideo(); 
					break;
				case 1: // playing
					player.pauseVideo(); 
					break;
				case 2: // paused
					break;
				case 3: // buffering
					player.pauseVideo(); 
					break;
			}		
		}
		
		public function startVideo():void{
			player.playVideo();
		}
		
		
		/* GETTER SETTERS */
		
		public function set w(w:Number):void {
			_w = w;
			setSize(_w);
		}		
		public function get w():Number {
			return _w;
		}
		
		public function get h():Number {
			return _h;
		}
		
		public function get id():String {
			return _id;
		}
	}
	
	
	
}