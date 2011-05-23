package com.mangum.utils{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import flash.utils.*;
	
	import com.mangum.events.ActionEvent;

	public class IdleTimer extends MovieClip{
		
		private var inactiveTime:int = 1000;
	    private var _idleTime:int;
//	    private var _pauseTime:int = 30;
		private var t:Timer = new Timer(inactiveTime);
		private var tCount:Number = 0;
		
		public function IdleTimer(stage:Stage,idleTime:int = 30){
			_idleTime = idleTime;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			t.addEventListener(TimerEvent.TIMER, onTimer);
			t.start();		
		}
		
		/* PUBLIC METHODS */
		
		public function begin():void{
			t.start();
		}
		
		
		/* PRIVATE METHODS */
		
		private function onMouseDown(e:MouseEvent):void {
//			dispatchEvent(new Event("cancelIdle"));
			t.reset();
			t.start();
			tCount = 0;	
		}
		
		private function onTimer(e:TimerEvent):void {
			tCount++;
//			trace(tCount);
			dispatchEvent(new ActionEvent(String(tCount), "tic", true));
			
			if(tCount >= _idleTime){
				handleInactivity();
			}
		}
		private function handleInactivity():void {	
			dispatchEvent(new Event("handleInteractivity"));
			t.reset();
			tCount = 0;	
//			_idleTime = _pauseTime;
			t.stop();
		}
		
		
		/* GETTER SETTERS */
		
 		public function get idleTime():int {
	       return _idleTime;
		}	
		
		public function set idleTime(idleTime:int):void {
	       _idleTime = idleTime;
		} 
		
	}
}


