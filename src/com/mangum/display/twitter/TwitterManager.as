package com.mangum.display.twitter{
	
	import com.mangum.display.twitter.model.TwitterSerializer;
	import com.mangum.display.twitter.view.Output;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class TwitterManager extends Sprite{
		
		private var ts:TwitterSerializer;
		private var output:Output;
		private var numberOfTweets:Number = 15;
		
		public function TwitterManager(){
			//model
			ts = new TwitterSerializer("CockrellSchool", numberOfTweets);
			ts.addEventListener("onFeedLoaded", onFeedLoaded, false, 0, true);	
			
			//view
			output = new Output(numberOfTweets);
		}
		
		/* EVENT HANDLERS */
		
		private function onFeedLoaded(e:Event):void{	
			if(this.contains(output) == false){
				addChild(output)
			}			
			output.createTweets(ts.tweets);
		}
	}
}