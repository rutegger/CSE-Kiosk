package com.mangum.events{
	
	import flash.events.Event;
	
	public class VidEvent extends Event{
		
		public var args:Object;
		
		public function VidEvent(obj:Object, type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
			args = obj;
		}
	}
}