package com.mangum.display.YT{
	
	import ca.newcommerce.youtube.data.VideoData;
	import ca.newcommerce.youtube.events.VideoFeedEvent;
	import ca.newcommerce.youtube.feeds.VideoFeed;
	import ca.newcommerce.youtube.webservice.YouTubeFeedClient;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.mangum.display.YT.controller.YTMenu;
	import com.mangum.display.YT.model.YTLoader;
	import com.mangum.display.YT.view.InfoBox;
	import com.mangum.display.YT.view.MainViewer;
	import com.mangum.utils.EmailErrorAlerter;
	
	import flash.display.Sprite;
	import flash.events.Event;

	
	public class YTManager extends Sprite{
		
		private var _width:Number;
		private var _height:Number;
		private var count:int = 0;
		protected var _wsFeed:YouTubeFeedClient = YouTubeFeedClient.getInstance();	
		private var _ytEnabled:Boolean = true;
		private var _mainViewer:MainViewer;

		
		public function YTManager(width:Number,height:Number){	
			_width = width;
			_height = height;
			
			//model
			setUpFeed("cockrellSchool");
			
			// view
			_mainViewer = new MainViewer();
		}
	
		/* EVENT HANDLERS */
		
		private function onYTConnectionError(e:Event):void{
			trace("ERROR: YouTube is down : (");
			_ytEnabled = false; // disable to avoid other errors
			// send alert email to kiosk admin
			var emailError:EmailErrorAlerter = new EmailErrorAlerter();
			emailError.notify("YouTube Configuration Error (most likely Favorites has been set to private in YT settings)");
		}
		
		private function doFavoritesReady(evt:VideoFeedEvent):void{
			_wsFeed.removeEventListener(VideoFeedEvent.USER_FAVORITES_DATA_RECEIVED, doFavoritesReady);
			var vids:Array = new Array();
			var video:VideoData;
			var videoFeed:VideoFeed = evt.feed;				
			
			while (video = videoFeed.next()){
				vids.push({id:video.actualId,title:video.title,description:video.content}); // put id & title into 2D array
			}	
			
			// view
			_mainViewer.init(vids,_width,_height);
			addChild(_mainViewer);			
		}
		
		
		/* PUBLIC METHODS */
		
		public function pauseMovie():void{
			if (_ytEnabled) _mainViewer.pauseMovie();
		}
		
		public function playMovie():void{
			if (_ytEnabled) _mainViewer.startVideo();
		}
		
		/* PRIVATE METHODS */	
		
		private function setUpFeed(fav:String):void{
			_wsFeed.getUserFavorites(fav);
			_wsFeed.addEventListener(VideoFeedEvent.USER_FAVORITES_DATA_RECEIVED, doFavoritesReady,false,0,true);
			_wsFeed.addEventListener("onYTConnectionError", onYTConnectionError);
		}
	}	
}

