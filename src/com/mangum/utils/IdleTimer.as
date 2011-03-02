﻿package com.mangum.utils{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.*;
	import flash.utils.*;

	public class IdleTimer extends MovieClip{
		
		private var inactiveTime:int = 1000;
	    private var _idleTime:int = 12;
	    private var _pauseTime:int = 30;
		private var t:Timer = new Timer(inactiveTime);
		private var tCount:Number = 0;
		
		public function IdleTimer(stage:Stage){
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			t.addEventListener(TimerEvent.TIMER, onTimer);
//			t.start();		
		}
		
		private function onMouseDown(e:MouseEvent):void {
//			dispatchEvent(new Event("cancelIdle"));
			t.reset();
			_idleTime = 12;
			t.start();
			tCount = 0;	
		}
		
		private function onTimer(e:TimerEvent):void {
			tCount++;
			trace(tCount);
			if(tCount >= _idleTime){
				handleInactivity();
			}
		}
		private function handleInactivity():void {	
			dispatchEvent(new Event("handleInteractivity"));
			t.reset();
			tCount = 0;	
			_idleTime = _pauseTime;
			t.stop();
		}
		
		
		/* GETTER SETTERS */
		
 		public function get idleTime():int {
	       return _idleTime;
		}	
		
		public function set idleTime(idleTime:int):void {
	       _idleTime = idleTime;
		} 
		
		public function get pauseTime():int {
	       return _pauseTime;
		}	
		
		public function set pauseTime(idleTime:int):void {
	       _pauseTime = pauseTime;
		} 
	}
}


