package com.mangum.utils{
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.events.IOErrorEvent;
	
	public class EmailErrorAlerter{
		
		private const ADDRESS:String = "http://designwithoutmercy.com/ecjKiosk/errorMail.php";
		
		public function EmailErrorAlerter(){}		

		public function notify(errorType:String):void {

			var variables:URLVariables = new URLVariables;
			variables.errorType = errorType;
			var varSend:URLRequest = new URLRequest(ADDRESS);
			var varLoader:URLLoader = new URLLoader;
			varSend.method = URLRequestMethod.POST;
			varSend.data = variables;				
			varLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			varLoader.addEventListener(Event.COMPLETE, completeHandler);
			varLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);	
			varLoader.load(varSend);
		} 			
		
		private function completeHandler(e:Event):void{
			trace("email sent");			
		} 
		
		private function onIOError(e:IOErrorEvent):void{
			trace("Cannot send email", e);			
		}		
		
	}
}


