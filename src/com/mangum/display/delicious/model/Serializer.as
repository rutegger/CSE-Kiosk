package com.mangum.display.delicious.model{
	

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import com.mangum.utils.EmailErrorAlerter;
	
	
	public class Serializer extends Sprite{
		
		private var _reload:Number = 1800000; //30 min	
		private var feed:XML;
		private var feed_url:URLRequest;
		private var feedLoader:URLLoader;
		
		private var timer:Timer = new Timer(_reload); 
		
		private var _name:String;
		private var _created:String;
		private var _message:String;
		private var _newsArr:Array = new Array();
		
		public function Serializer(user:String, num:Number):void {
			init(user, num);
		}
		
		/* PRIVATE METHODS */
		
		private function init(user:String, num:Number):void {			
			feed = new XML();
			feedLoader = new URLLoader();
			var feed_xml_url:String = "http://feeds.delicious.com/v2/rss/"+user+"?count="+num;	
			feed_url= new URLRequest(feed_xml_url);
			feedLoader.load(feed_url);
			feedLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);			
			feedLoader.addEventListener(Event.COMPLETE, feedLoaded, false, 0, true);
//			Security.allowDomain("*", "http://feeds.delicious.com/");
			
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
			// send alert email to kiosk admin
			var emailError:EmailErrorAlerter = new EmailErrorAlerter();
			emailError.notify("Delicious Connection Error");
		}
		
		private function feedLoaded(e:Event):void{
			feed = XML(feedLoader.data);
			
//			trace("delicious: \n"+feed); //XML

			
			var len:uint = feed.channel.child("item").length();
			
			for(var i:uint = 0; i < len; i++){			
				_newsArr[i] = {created:feed.channel.item[i].pubDate,
							   message:feed.channel.item[i].description};
			}
			
			_created = _newsArr[0].created;
			_message = _newsArr[0].message;
			
			dispatchEvent(new Event("onFeedLoaded"));
		}			
		
		
		/* GETTER SETTERS */
		
		public function get news():Array {
			return _newsArr;
		}
		
		
	}
}