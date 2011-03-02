package com.mangum.display{ 
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import com.mangum.events.SpriteEvent;
	
	public class Controller extends MovieClip{
		
		private var square:Sprite = new Sprite();
		
		public function Controller(){
			init();
		}
		
		private function init():void{
			initSquare()
			initListener();
		}
		
		private function initSquare():void{
			addChild(square);
			square.graphics.lineStyle(3,0x00ff00);
			square.graphics.beginFill(0x0000FF);
			square.graphics.drawRect(0,0,10,10);
			square.graphics.endFill();		
			square.x = 100;
			square.y = 100;
		}
		
		private function initListener():void{
			square.addEventListener(MouseEvent.MOUSE_DOWN,initDrag);
			square.addEventListener(MouseEvent.MOUSE_UP,stopsDrag);
			square.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void{
			var evtObj:Object = {val:square.x};
			dispatchEvent(new SpriteEvent(evtObj, "onBoxX", true)); 
		}
		
		private function initDrag(e:MouseEvent):void{
			square.startDrag();
		}
		private function stopsDrag(e:MouseEvent):void{
			square.stopDrag();
		}
	}
}
