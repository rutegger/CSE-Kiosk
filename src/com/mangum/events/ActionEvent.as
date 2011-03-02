package com.mangum.events{
	
	import flash.events.Event;
	
	public class ActionEvent extends Event{
		
//		public static const ANIMATE_IN        : String = "animateIn";
//		public static const ANIMATE_OUT       : String = "animateOut";
		
//		public var args:Object;
		public var msg:String;
		
		public function ActionEvent(str:String, type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
			msg = str;
		}
		
	}
}