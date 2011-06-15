package com.mangum.display.delicious.view{
	
	import flash.display.Sprite;	
	import com.mangum.text.Messenger;
	
	public class Viewer extends Sprite{
		
		private var message:Messenger;
		
		public function Viewer(){
			createHolder();
		}
		
		public function createStory(news:Array):void{
			trace("story: "+news[0].created);
			trace("message: "+news[0].message);	 
			message.setLabel(news[0].message);
		}
		
		private function createHolder():void {
			message = new Messenger("xxxxxxxxxxxxxxx", 420, 0xC7B299, 15);
			message.setAttribute("leading", 2);			
			addChild(message);
			message.x = 22;
			
		}
	}
}