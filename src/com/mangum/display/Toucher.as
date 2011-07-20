package com.mangum.display{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Toucher extends Sprite{
		
		private var _stage:Stage;
		private var touch:Touch;
		
		public function Toucher(stage:Stage){
			_stage = stage;
			init();
			
		}
		
		
		private function init():void{
			touch = new Touch;
			addChild(touch);
			touch.alpha = 0;
			_stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(event:Event):void{
			touch.alpha = 1;
			touch.scaleX = 1;
			touch.scaleY = 1;
			touch.x = event.target.stage.mouseX;
			touch.y = event.target.stage.mouseY;
			TweenLite.to(touch, 0.5, {scaleX:2, scaleY:2, alpha:0, ease:Quint.easeOut});
		
			
		}		
		
	}
}