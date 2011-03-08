package{
	
	import com.mangum.display.SSPManager;
	import com.mangum.display.YTManager;
	import com.mangum.text.Messenger;
	import com.mangum.utils.IdleTimer;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	[SWF(width='1680', height='1050', backgroundColor='#0000000', frameRate='24')]
	
	public class Main extends Sprite{
		
		private var sspm:SSPManager = new SSPManager(stage, "http://fic.engr.utexas.edu/ecjkiosk/slideshowpro/images.php?album=5");	
		private var ytManager:YTManager = new YTManager();
		private var idleTimer:IdleTimer;
		
		public function Main(){	
			init();
			
			//for testing:
			var msg:Messenger = new Messenger("V .02",100);
			addChild(msg);
		}
		
		
		private function init():void{
			
//			stage.displayState = StageDisplayState.FULL_SCREEN;	
			
			//hide cursor - klugy, but Mouse.hidu() alone doesn't work
//			addEventListener(MouseEvent.CLICK, onMouse, false, 0, true);
//			addEventListener(MouseEvent.MOUSE_MOVE, onMouse, false, 0, true);
//			addEventListener(MouseEvent.MOUSE_DOWN, onMouse, false, 0, true);
//			addEventListener(MouseEvent.MOUSE_OVER, onMouse, false, 0, true);
			
			//YouTube			
			addChild(ytManager);
//			showItem(ytManager,false);
			
			// SlideshowPro
			addChild(sspm);	

			
			// timeout
			idleTimer = new IdleTimer(stage, 45);	
			idleTimer.addEventListener("handleInteractivity", handleInteractivity);
			addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
		}		
		
		private function onMouse(e:MouseEvent):void{
			Mouse.hide();
		}
		
		private function handleInteractivity(e:Event):void{	
			sspm.show(true);
			ytManager.pauseMovie();
			showItem(ytManager,false);
			showItem(sspm,true);
		}
		
		private function onClick(e:MouseEvent):void{
			sspm.show(false);
			showItem(ytManager,true);
		}
		
		private function showItem(obj:DisplayObject, bool:Boolean = true):void{
			if(bool){
				addChild(obj);	
			}else{
				removeChild(obj);	
			}
		}
		
		
	}
	
}