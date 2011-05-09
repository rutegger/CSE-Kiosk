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
		
		public function TwitterManager(){
			//model
			ts = TwitterSerializer.getInstance(); // Singleton
			ts.addEventListener("onFeedLoaded", onFeedLoaded, false, 0, true);	
			
			//view
			output = new Output();
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