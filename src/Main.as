package{
	
	import com.mangum.display.SSPManager;
	import com.mangum.display.YTManager;
	import com.mangum.utils.IdleTimer;
	import com.mangum.text.Messenger;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.StageDisplayState;
	import flash.display.DisplayObject;
	
	[SWF(width='1680', height='1050', backgroundColor='#0000000', frameRate='24')]
	
	public class Main extends Sprite{
		
		private var sspm:SSPManager = new SSPManager(stage, "http://ficp.engr.utexas.edu/ssp/images.php?album=34");	
		private var ytManager:YTManager = new YTManager();
		private var idleTimer:IdleTimer;
		
		public function Main(){	
			init();
			
			//for testing:
			var msg:Messenger = new Messenger("V .02",100);
			addChild(msg);
		}
		
		
		private function init():void{
			stage.displayState = StageDisplayState.FULL_SCREEN;	
			
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