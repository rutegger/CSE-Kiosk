package com.mangum.display.delicious{
	
	import com.mangum.display.delicious.model.Serializer;
	import com.mangum.display.delicious.view.Viewer;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class DeliciousManager extends Sprite{
		
		private var ds:Serializer;
		private var viewer:Viewer;
		private var numberOfStories:Number = 15;
		
		public function DeliciousManager(){
			//model
			ds = new Serializer("cockrellschool", numberOfStories);
			ds.addEventListener("onFeedLoaded", onFeedLoaded, false, 0, true);	
			
			viewer = new Viewer(numberOfStories);
		}
		
		/* EVENT HANDLERS */
		
		private function onFeedLoaded(e:Event):void{	
//			trace("delicious: \n"+ds.news); //XML
//			for (var index:String in ds.news) {
//				trace(index+" => "+ds.news[index].message); 
//			}
			if(this.contains(viewer) == false){
				addChild(viewer);				
			}			
			viewer.news = ds.news;
			viewer.createStory();
		}
		

	}
	
	
}
	
	