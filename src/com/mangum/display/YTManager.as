package com.mangum.display{
	
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
	
	public class YTManager extends MovieClip{
		
		private var _width:Number;
		private var _height:Number;
		private var main:YTLoader;
		private var menu:YTMenu;
		private var count:int = 0;
		protected var _wsFeed:YouTubeFeedClient = YouTubeFeedClient.getInstance();	
		
		public function YTManager(width:Number,height:Number){	
			_width = width;
			_height = height;
			
			_wsFeed.getUserFavorites("cockrellSchool");
			_wsFeed.addEventListener(VideoFeedEvent.USER_FAVORITES_DATA_RECEIVED, doFavoritesReady,false,0,true);
			_wsFeed.addEventListener("onYTConnectionError", onYTConnectionError);
			// stage.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
		}
		
		/* PUBLIC METHODS */
		
		public function pauseMovie():void{
			main.pause();
		}
		
		/* EVENT HANDLERS */
		
		private function onYTConnectionError(e:Event):void{
			trace("YT's down : (");
		}
		
		private function onSelected(e:ActionEvent):void{
			main.playVideo(e.msg);		
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
		
		private function build(vids:Array):void{	
			mkMovie(vids);
			mkNav(vids);
		}
		
		private function mkMovie(arr:Array):void{
			var box:Sprite = new Box();
			addChild(box);
			box.x = 5;
			box.y = -10;
			box.width = _width + 25;
			box.height = _height - 5;
			
			main = new YTLoader(arr[0].id,_width,_height,false);  
			addChild(main);	
	
			main.mask = createMask();
		}
		
		private function mkNav(arr:Array):void{
			var box:Sprite = new Box();
			addChild(box);
			
			box.width = 550;
			box.height = 500;
			menu = new YTMenu(arr,150,545); // mov array, thumb width
			addChild(menu);				
			menu.x = 310;
			menu.y = 380;			
			
			box.x = menu.x - 15;
			box.y = menu.y;
			
			menu.addEventListener("selected", onSelected, false, 0, true);
		}
		
		private function createMask():Sprite{
			var shape:Sprite = new Sprite();					
			shape.graphics.lineStyle(1, 0);
			shape.graphics.beginFill(0xFF00FF);
			shape.graphics.drawRect(0,0,1650,_height+70); // since the mask wont follow the slide I just made the width 100%; 
			                                              // also have to add gutter _hieght for some reason
			shape.graphics.endFill();
			shape.y = 50;
			return shape;
		}
		
		
	}
	
}

