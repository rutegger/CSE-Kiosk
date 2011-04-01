package{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.mangum.display.*;
	import com.mangum.display.FlashEffTester;
	import com.mangum.display.Nav;
	import com.mangum.display.Positioner;
	import com.mangum.display.SSP.SSPManager;
	import com.mangum.display.YT.YTManager;
	import com.mangum.events.ActionEvent;
	import com.mangum.text.Messenger;
	import com.mangum.utils.IdleTimer;
	import com.mangum.display.weather.WeatherManager;
	
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
		
		private var sspm:SSPManager; 
		private var ytManager:YTManager;
		private var idleTimer:IdleTimer;
		private var content:MovieClip = new MovieClip();
		private var slideContainer:MovieClip = new MovieClip();
		private var satelliteSlide:MovieClip;
		
		private var clock:Messenger; // for testing
		
		public function Main(){	
			init();
			
			// **** for testing:
			var ver:Messenger = new Messenger("V .04",60,0x000000,12);
			addChild(ver);
			clock = new Messenger(String(idleTimer.idleTime),100);
			clock.setAttribute("size",20);
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
			
//			hideCursor();			
			
			// ********* Kiosk Background ********* 			
			var bg:Background = new Background();
			addChild(bg);
			
			// ********* Weather Widget ********* 
			var weather:WeatherManager = new WeatherManager();
			addChild(weather);
			weather.scaleX = .95;
			weather.scaleY = .95
			weather.x = 620;
			weather.y = 10;
			
			// ********* Main Content Holder ********* 			
			addChild(content);
			content.name = "content";
			
			// ********* Navigation ********* 
			var arr:Array = [{id:"yt", title:"YouTube Videos"},
							 {id:"energy", title:"Water & Energy Nexus"},
							 {id:"satellite", title:"Student Satellite"}];			
			var n:Nav = new Nav(arr);
			content.addChild(n);
			n.x = (stage.stageWidth / 2) - (n.width / 2);
			n.y = 900;			
			n.addEventListener("navSelected",onNavSelected,false,0,true);	
			
			// ********* Content Slides ********* 
			content.addChild(slideContainer);
			slideContainer.y = 200;
			
			// YouTube 		
			ytManager = new YTManager(640,390);
			slideContainer.addChild(ytManager);
			ytManager.x = 180;
			ytManager.y = 100;
			// Satellite
			satelliteSlide = new SatelliteSlide();
			slideContainer.addChild(satelliteSlide);
			satelliteSlide.x = stage.stageWidth +200;
			satelliteSlide.y = 10;			
		
			// ********* SlideshowPro *********
			sspm = new SSPManager(stage, "http://fic.engr.utexas.edu/ecjkiosk/slideshowpro/images.php?album=5");	
			addChild(sspm);
			sspm.name = "sspm";
			sspm.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);			
			sspm.addEventListener("onFadeOutSSP", onFadeOutSSP, false, 0, true);
			sspm.addEventListener("onFadeInSSP", onFadeInSSP, false, 0, true);
			
			// ********* Timeout *********
			idleTimer = new IdleTimer(stage, 20);	
			idleTimer.addEventListener("handleInteractivity", handleInteractivity);	
			
			// ********* FlashEff *********
//			var ft:FlashEffTester = new FlashEffTester();
//			addChild(ft);
	
		}	
		
		
		/* EVENT HANDLERS */
		
		private function onNavSelected(e:ActionEvent):void{
			trace("Main.as >>>> "+e.msg);
			moveSlide(e.msg);
		}
		
		private function onFadeOutSSP(e:Event):void{	
			if (this.getChildByName("sspm") != null){
				removeChild(sspm);
			}							
		}
		
		private function onFadeInSSP(e:Event):void{	
			if (this.getChildByName("content") != null) {
				removeChild(content);
			}		
		}
		
		private function onMouse(e:MouseEvent):void{
			Mouse.hide();
		}
		
		private function handleInteractivity(e:Event):void{	// user interaction timeout
			ytManager.pauseMovie();
			addChild(sspm);
			sspm.show(true);
		}
		
		private function onClick(e:MouseEvent):void{ // user clicks screen
			sspm.show(false);
			if (this.getChildByName("content") == null)addChild(content);			
			setChildIndex(sspm,numChildren-1);// put sspm on top
		}
		
		
		/* PRIVATE METHODS */
		
		private function moveSlide(val:String):void{
			switch (val){
				case "yt":
					TweenLite.to(slideContainer, 1.5, {x:0, ease:Cubic.easeOut});	
					break;
				case "satellite":
					TweenLite.to(slideContainer, 1.5, {x:-1700, ease:Cubic.easeOut});	
					ytManager.pauseMovie();
					break;
			}
		}
		
		private function hideCursor():void{
			// Hide cursor - kludgy, but Mouse.hidu() alone doesn't work
			addEventListener(MouseEvent.CLICK, onMouse, false, 0, true);
			addEventListener(MouseEvent.MOUSE_MOVE, onMouse, false, 0, true);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouse, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OVER, onMouse, false, 0, true);
		}		
	}	
}