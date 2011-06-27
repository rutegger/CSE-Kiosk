package com.mangum.display{
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import com.mangum.text.Messenger;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class LoaderMessage extends Sprite{
		
		private var _stage:Stage;
		private var container:Sprite;
		private var timer:Timer = new Timer(5000); 
		
		public function LoaderMessage(stg:Stage){
			_stage = stg;
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
			addChild(createMessage());
		
		}
		
		private function onTimer(e:TimerEvent):void{
			removeEventListener(TimerEvent.TIMER, onTimer);
			removeChild(container);
			timer.stop();
		}
		
		private function createMessage():Sprite{
			container = new Sprite;
			addChild(container);
			
			// modal bg
			var modal:Sprite = new Sprite();
			modal.graphics.lineStyle(3,0x000000);
			modal.graphics.beginFill(0x000000,.5);
			modal.graphics.drawRect(0,0,_stage.stageWidth,_stage.stageHeight);			
			modal.graphics.endFill();
			
			container.addChild(modal);
			
			// msg box
			var box:Sprite = new Sprite();
			box.graphics.lineStyle(1,0xffffff);
			box.graphics.beginFill(0x111111,.75);
			box.graphics.drawRoundRect(0,0,275,150,20);
			box.graphics.endFill();
			box.x = _stage.stageWidth/2-box.width/2;
			box.y = _stage.stageHeight/2-box.height/2;
			container.addChild(box);
			
//		    container.addChild(loaderAni);
			// **** for testing:
			var msg:Messenger = new Messenger("Loading...",300,0xffffff,50);
			container.addChild(msg);
			msg.x = (_stage.stageWidth/2-box.width/2) + 25;
			msg.y = _stage.stageHeight/2-box.height/2 + 40;

			return container;
		}
	}
}