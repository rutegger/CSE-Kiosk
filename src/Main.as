package{
	
	import com.mangum.display.*;
	import com.mangum.display.Nav;
	import com.mangum.display.Positioner;
	import com.mangum.display.SSPManager;
	import com.mangum.display.YTManager;
	import com.mangum.events.ActionEvent;
	import com.mangum.text.Messenger;
	import com.mangum.utils.IdleTimer;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
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
		private var content:MovieClip = new MovieClip();
		private var clock:Messenger;
		
		public function Main(){	
			init();
			
			//for testing:
			var ver:Messenger = new Messenger("V .03",60);
			addChild(ver);
			clock = new Messenger(String(idleTimer.idleTime),100);
			clock.name = "clock";
			clock.setSize(50);
			Positioner.topCenter(stage,clock);
			idleTimer.addEventListener("tic",onTic,false,0,true);
		
		}
		
		/* TESTING FUNCTIONS */
		
		private function onTic(e:ActionEvent):void{			
			clock.setLabel(e.msg);
			if(this.getChildByName("clock") == null) addChild(clock);
		}
		/* ***************** */
		
		
		private function init():void{
			
//			stage.displayState = StageDisplayState.FULL_SCREEN;	
			
			// Hide cursor - klugy, but Mouse.hidu() alone doesn't work
			addEventListener(MouseEvent.CLICK, onMouse, false, 0, true);
			addEventListener(MouseEvent.MOUSE_MOVE, onMouse, false, 0, true);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouse, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OVER, onMouse, false, 0, true);
			
			// ********* Kiosk Background ********* 
			
			var bg:Background = new Background();
			addChild(bg);
			
			// ********* Main Content Holder ********* 
			
			addChild(content);
			content.name = "content";
			
			// ********* Navigation ********* 
			var arr:Array = [{id:"yt",title:"YouTube Videos"},
							 {id:"energy",title:"Water & Energy Nexus"},
							 {id:"satellite",title:"Student Satellite"}];			
			var n:Nav = new Nav(arr);
			content.addChild(n);
			n.x = (stage.stageWidth / 2) - (n.width / 2);
			n.y = 50;			
			
			// ********* YouTube ********* 		
			content.addChild(ytManager);
		
			// ********* SlideshowPro *********
			addChild(sspm);
			sspm.name = "sspm";
			
			// ********* Timeout *********
			idleTimer = new IdleTimer(stage, 15);	
			idleTimer.addEventListener("handleInteractivity", handleInteractivity);
			
			
			sspm.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);			
			sspm.addEventListener("onFadeOutSSP", onFadeOutSSP, false, 0, true);
		}			
		
		private function onFadeOutSSP(e:Event):void{			
			removeChild(sspm);
		}
		
		private function onMouse(e:MouseEvent):void{
			Mouse.hide();
		}
		
		private function handleInteractivity(e:Event):void{	
//			trace("handleInt");
			ytManager.pauseMovie();
			removeChild(content);
			addChild(sspm);
			sspm.show(true);
		}
		
		private function onClick(e:MouseEvent):void{
//			trace("onClick");
			sspm.show(false);
			if (this.getChildByName("content") == null) {
				addChild(content);
			}
			
		}
		
	}
	
}