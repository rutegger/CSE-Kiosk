package com.mangum.utils{
	

	
	public class UserEventLogger{
		
		public function UserEventLogger(){
		}
		
		public function logIt(msg:String):void{
			var seconds:String = new Date().seconds.toString();
			var minutes:String = new Date().minutes.toString();
			var hours:String = new Date().hours.toString();
			var date:String = new Date().date.toString();
			var month:String = new Date().month.toString();
			var time:String = month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;
			
			trace(msg,time);
		}
		
	}
}