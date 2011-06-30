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
	import com.mangum.events.VidEvent;
	import com.mangum.text.Messenger;
	import com.mangum.text.StringFX;
	import com.mangum.utils.EmailErrorAlerter;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	
	public class YTManager extends Sprite{
		
		private var _width:Number;
		private var _height:Number;
		private var mov:YTLoader;
		private var menu:YTMenu;
		private var count:int = 0;
		protected var _wsFeed:YouTubeFeedClient = YouTubeFeedClient.getInstance();	
		private var _ytEnabled:Boolean = true;
		private var _description:String;
		private var _infoBox:InfoBox;
		
		public function YTManager(width:Number,height:Number){	
			_width = width;
			_height = height;
			
			setUpFeed("cockrellSchool");
		}
		
		
		/* PUBLIC METHODS */
		
		public function pauseMovie():void{
			if (_ytEnabled) mov.pause();
		}
		
		public function playMovie():void{
			if (_ytEnabled) mov.startVideo();
		}
		
		/* EVENT HANDLERS */
		
		private function onYTConnectionError(e:Event):void{
			trace("ERROR: YouTube is down : (");
			_ytEnabled = false; // disable to avoid other errors
			// send alert email to kiosk admin
			var emailError:EmailErrorAlerter = new EmailErrorAlerter();
			emailError.notify("YouTube Configuration Error (most likely Favorites has been set to private in YT settings)");
		}
		
		private function onSelected(e:VidEvent):void{
			mov.playVideo(e.args.id);
			_infoBox.updateText(e.args.title,e.args.description);
		}

		private function doFavoritesReady(evt:VideoFeedEvent):void{
			_wsFeed.removeEventListener(VideoFeedEvent.USER_FAVORITES_DATA_RECEIVED, doFavoritesReady);
			var vids:Array = new Array();
			var video:VideoData;
			var videoFeed:VideoFeed = evt.feed;				
			
			while (video = videoFeed.next()){
				vids.push({id:video.actualId,title:video.title,description:video.content}); // put id & title into 2D array
				//	_wsFeed.getVideoComments(video.actualId);
			}	
			build(vids);
			
			// Add Video Caption
			_infoBox =  new InfoBox();
			addChild(_infoBox);
			_infoBox.y = 410;
			_infoBox.x = 160;
			
			trace(vids[0].title);
			_infoBox.updateText(vids[0].title, vids[0].description);
			
		}
		
		
		/* PRIVATE METHODS */	
		
		private function setUpFeed(fav:String):void{
			_wsFeed.getUserFavorites(fav);
			_wsFeed.addEventListener(VideoFeedEvent.USER_FAVORITES_DATA_RECEIVED, doFavoritesReady,false,0,true);
			_wsFeed.addEventListener("onYTConnectionError", onYTConnectionError);
		}
		
		private function build(vids:Array):void{		
			var boxShadow:Sprite = new BoxShadow();
			addChild(boxShadow);
			boxShadow.x = 7;
			boxShadow.y = -7;
			boxShadow.width = _width + 28;
			boxShadow.height = _height - 2;
			
			var box:Sprite = new Box();
			addChild(box);
			box.x = 2;
			box.y = -12;
			box.width = _width + 28;
			box.height = _height - 2;
			TweenMax.to(box, 1, {tint:0x736357}); // set to brown
			
			
			
			if(vids.length > 0){
				addChild(mkMovie(vids));
				addChild(mkNav(vids));
			} else {
				trace("Sorry, Cockrell School Videos not available");
			}		
		}
		
		private function mkMovie(arr:Array):MovieClip{	
			mov = new YTLoader(arr[0].id, arr[0].title, arr[0].description, _width,_height,false);  
			mov.mask = createMask();
			return mov;
		}
		
		private function mkNav(arr:Array):MovieClip{
			menu = new YTMenu(arr,196,4); // mov array, thumb width, # of columns			
			menu.x = 685;
			menu.y = 45;					
			menu.addEventListener("selected", onSelected, false, 0, true);
			menu.buttonMode = false;
			return menu;
		}
		
		private function createMask():Sprite{
			var shape:Sprite = new Sprite();					
			shape.graphics.lineStyle(1, 0);
			shape.graphics.beginFill(0xFF00FF);
			shape.graphics.drawRect(0,-70,1900,370); // since the mask wont follow the slide I just made the width 100%; 
			                                         // also have to add gutter _hieght for some reason
			shape.graphics.endFill();
			shape.y = 300;
			return shape;
		}
	}
	
}

