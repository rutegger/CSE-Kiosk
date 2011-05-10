package com.mangum.display.YT{
	
	import ca.newcommerce.youtube.data.VideoData;
	import ca.newcommerce.youtube.events.VideoFeedEvent;
	import ca.newcommerce.youtube.feeds.VideoFeed;
	import ca.newcommerce.youtube.webservice.YouTubeFeedClient;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.mangum.events.ActionEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.mangum.display.Slide;
	import com.mangum.display.YT.model.YTLoader;
	import com.mangum.display.YT.controller.YTMenu;
	
	public class YTManager extends Slide{
		
		private var _width:Number;
		private var _height:Number;
		private var mov:YTLoader;
		private var menu:YTMenu;
		private var count:int = 0;
		protected var _wsFeed:YouTubeFeedClient = YouTubeFeedClient.getInstance();	
		
		public function YTManager(width:Number,height:Number){	
			_width = width;
			_height = height;
			
			setUpFeed("cockrellSchool");
	
			// stage.addEventListener(MouseEvent.CLICK, onClick, false, 0, true); 	
		}
		
		
		/* PUBLIC METHODS */
		
		public function pauseMovie():void{
			mov.pause();
		}
		
		public function playMovie():void{
			mov.startVideo();
		}
		
		/* EVENT HANDLERS */
		
		private function onYTConnectionError(e:Event):void{
			trace("YouTube is down : (");
		}
		
		private function onSelected(e:ActionEvent):void{
			mov.playVideo(e.msg);		
		}

		private function doFavoritesReady(evt:VideoFeedEvent):void{
			_wsFeed.removeEventListener(VideoFeedEvent.USER_FAVORITES_DATA_RECEIVED, doFavoritesReady);
			var vids:Array = new Array();
			var video:VideoData;
			var videoFeed:VideoFeed = evt.feed;				
			
			while (video = videoFeed.next()){
				vids.push({id:video.actualId,title:video.title}); // put id & title into 2D array
				//	_wsFeed.getVideoComments(video.actualId);
			}	
			build(vids);
		}
		
		private function onClick(e:MouseEvent):void{		
			if(e.stageX > stage.stageWidth/2){
				var val:Number = (menu.width *-1) + stage.stageWidth - 50;
				TweenLite.to(menu, 1, {x:val, ease:Cubic.easeOut});
			}else{
				TweenLite.to(menu, 1, {x:50, ease:Cubic.easeOut});
			}
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
			addChild(mkMovie(vids));
			addChild(mkNav(vids));
		}
		
		private function mkMovie(arr:Array):MovieClip{		
			mov = new YTLoader(arr[0].id,_width,_height,false);  
			mov.mask = createMask();
			return mov;
		}
		
		private function mkNav(arr:Array):MovieClip{
			menu = new YTMenu(arr,150,4); // mov array, thumb width, # of columns			
			menu.x = 755;
			menu.y = 50;					
			menu.addEventListener("selected", onSelected, false, 0, true);
			return menu;
		}
		
		private function createMask():Sprite{
			var shape:Sprite = new Sprite();					
			shape.graphics.lineStyle(1, 0);
			shape.graphics.beginFill(0xFF00FF);
			shape.graphics.drawRect(0,-70,1680,_height+40); // since the mask wont follow the slide I just made the width 100%; 
			                                                // also have to add gutter _hieght for some reason
			shape.graphics.endFill();
			shape.y = 300;
			return shape;
		}
		
		
	}
	
}

