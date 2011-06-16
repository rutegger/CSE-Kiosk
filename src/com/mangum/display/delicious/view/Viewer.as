package com.mangum.display.delicious.view{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.mangum.text.Messenger;
	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Viewer extends Sprite{
		
		private static var RELOAD_TIME:Number = 10000;
		private static var ANIMATION_SPEED:Number = 2;
		
		private var _news:Array;
		private var _numStories:int;
		private var messageTitle:Messenger;
		private var message:Messenger;
		private var timer:Timer = new Timer(RELOAD_TIME); 
		
		public function Viewer(numberOfStories:int){
			_numStories = numberOfStories;
			init();
	
		}
		
		/* EVENT HANDLERS */
		
		private function onTimer(e:TimerEvent):void{			
			message.alpha = 0;
			TweenLite.to(message, ANIMATION_SPEED, {alpha:1, ease:Cubic.easeOut});
			createStory();
		}
		
		public function init():void{
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
			createHolder();
		}
		
		public function createStory():void{
			var rand:int = randRange(0,_numStories-1);			
			message.setLabel("                      "+_news[rand].message);
			var dif:Number = Math.floor(message.h);

			switch(dif){
				case 24:
					dif = 17;
					break;
				case 42:
					dif = 10;
					break;
				case 62:
					dif = 0;
					break;
			}
			
			messageTitle.y = dif;	
			message.y = dif;
		}
		
		private function randRange(min:Number, max:Number):Number{
			var randomNum:Number = Math.round((Math.random() * (max - min )) + min);					
			return randomNum;
		}	
		
		private function createHolder():void {
			messageTitle = new Messenger("In the News:", 420, 0xC7B299, 15,true);
			message = new Messenger("--", 420, 0xC7B299, 15);
			message.setAttribute("leading", 2);			
			addChild(messageTitle);
			addChild(message);
			messageTitle.x = 22;	
			message.x = 22;			
		}
		
		/* GETTERS & SETTERS */
		
		public function set news(arr:Array):void {
			_news = arr;
		}
		
	}
}