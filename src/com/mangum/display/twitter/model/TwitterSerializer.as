package com.mangum.display.twitter.model{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	
	public class TwitterSerializer extends Sprite{
		
		private var _reload:Number = 900000; //15 min	
		private var feed:XML;
		private var feed_url:URLRequest;
		private var feedLoader:URLLoader;
		
		private var timer:Timer = new Timer(_reload); 
		
		private var _name:String;
		private var _created:String;
		private var _message:String;
		private var _tweetArr:Array = new Array();
		
		public function TwitterSerializer(user:String, num:Number):void {
			init(user, num);
		}
		
		/* PRIVATE METHODS */
		
		private function init(user:String, num:Number):void {			
			feed = new XML();
			feedLoader = new URLLoader();				
			var feed_xml_url:String = "http://twitter.com/statuses/user_timeline/"+user+".xml?count="+num;	
			feed_url= new URLRequest(feed_xml_url);
			feedLoader.load(feed_url);
			feedLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);			
			feedLoader.addEventListener(Event.COMPLETE, feedLoaded, false, 0, true);
//			Security.allowDomain("*", "xoap.weather.com");
			
			// Reload feed		
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
		}
		
		
		/* EVENT HANDLERS */
	
		private function onTimer(e:TimerEvent):void{
			feedLoader.load(feed_url);
		}
		
		private function onIOError(e:IOErrorEvent):void{
			trace("An IO Error has occured.\n\n", e);
		}
		
		private function feedLoaded(e:Event):void{
			feed = XML(feedLoader.data);
		    		   
//			trace("twitter: \n"+feed); //XML

			
			var len:uint = feed.child("status").length();
			
			for(var i:uint = 0; i < len; i++){			
				_tweetArr[i] = {name:feed.status[i].user.name,
								created:feed.status[i].created_at,
								message:feed.status[i].text};
			}
			
			_created = _tweetArr[0].created;
			_message = _tweetArr[0].message;
				
			dispatchEvent(new Event("onFeedLoaded"));
		}			
		
		
		/* GETTER SETTERS */
		
		public function get tweets():Array {
			return _tweetArr;
		}
		

	}
}