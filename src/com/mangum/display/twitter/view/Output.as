
package com.mangum.display.twitter.view{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.mangum.text.Messenger;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Output extends Sprite{
		
		private static var RELOAD_TIME:Number = 8000;
		private static var ANIMATION_SPEED:Number = 1;
		
		private var container:Sprite;	
		private var numTweets:Number;	
		private var timer:Timer = new Timer(RELOAD_TIME); 
		private var containerY:Number = 0;
		private var tweetTitleArray:Array = new Array();
		private var tweetArray:Array = new Array();
		
		public function Output(num:Number):void {
			numTweets = num;
			init();
		}
		
		/* PUBLIC METHODS */
		
		public function createTweets(obj:Object):void{
			
			numTweets = obj.length;
			
			// first delete old strings		
			for(var j:uint = 0; j < numTweets; j++){
				//trace("j: "+j);
				tweetArray[j].setLabel("");
			}
			
			for(var i:uint = 0; i < numTweets; i++){				
				var name:String = obj[i].name;
				var created:String = obj[i].created;
				var msg:String = obj[i].message;
				var pattern:RegExp;// = new RegExp("http:\/\/.*"); // removes link
//				var str:String = "<b>@" + name + "</u>: " + " • " + formatDate(created) + " • "+ msg.replace(pattern,""); 
				var str:String = "                                " + msg.replace(pattern,"") + " |  " + formatDate(created); 
				tweetArray[i].setLabel(str);
			}
			//	tweet.setAttribute("font","UniversCE65Bold");			
		}
		
		
		/* EVENT HANDLERS */
		
		private function onTimer(e:TimerEvent):void{			
			if(containerY == -900) {
				containerY = 100;
				container.y = 100;
			} 
			containerY -= 100;
			roll(containerY);		
		}
		
		
		/* PRIVATE METHODS */
		
		private function formatDate(str:String):String{	
			var weekday:String = str.slice(0,3);
			var month:String = str.slice(4,8);
			var rawDay:String = str.slice(8,10);			
			var pattern:RegExp = new RegExp("^0+"); // removes leading 0's
			var day:String = rawDay.replace(pattern,""); 
			var rawTime:String = str.slice(11,16);
			var time:String = convertTime(rawTime.replace(":",""));
			//var time:String = convertTime(str.slice(11,15));
			var newStr:String = weekday+", "+month+day; //+ " "+time;
			return newStr;
		}
		
		private function convertTime(_t:String):String{
			var _mTime:Number = parseInt(_t);
			
			var AMPM:String = "AM";
			if (_mTime > 1200){
				_mTime = _mTime - 1200;
				AMPM = "PM";
			}
			
			var _digit:Number = 4;
			if (_mTime < 1000)_digit = 3;
			
			var _hr:String = _mTime.toString().substr(0, _digit - 2);
			var _mn:String = _mTime.toString().substr(-2);
			
			var _rtn:String = _hr + ":" + _mn + " " + AMPM;
			
			return _rtn;
		}
		
		private function init():void{
			var tweetMask:Shape = new Shape();
			tweetMask.graphics.lineStyle(1, 0x000000);
			tweetMask.graphics.beginFill(0xff0000);
			tweetMask.graphics.drawRect(20, 20, 425, 100);
			tweetMask.graphics.endFill();
			this.addChild(tweetMask);
			
			container = new Sprite();
			addChild(container);
			
			container.mask = tweetMask;
			
			createTweetContainers()
			
			// -----------			
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
		}
		
		private function createTweetContainers():void{
			var counter:uint = 30;
			for(var i:uint = 0; i < numTweets; i++){
				var tweetTitle:Messenger = new Messenger("@CockrellSchool:", 420, 0xC7B299, 15,true);
				var tweet:Messenger = new Messenger("--"+i, 420, 0xC7B299, 15);
//				tweet.setAttribute("leading", 20);
				tweetTitleArray[i] = tweetTitle;
				tweetArray[i] = tweet;
				container.addChild(tweet);
				container.addChild(tweetTitle);
				tweetTitle.x = 22;
				tweetTitle.y = counter;
				tweet.x = 22;
				tweet.y = tweetTitle.y;// - 1;
				counter += 100;
			}
		}
		
		private function roll(val:Number):void{
			TweenLite.to(container, ANIMATION_SPEED, {y:val, ease:Cubic.easeOut});
		}
		
		
		/* GETTERS & SETTERS */
		
	}
}