package{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.mangum.display.*;
	import com.mangum.display.FlashEffTester;
	import com.mangum.display.Nav;
	import com.mangum.display.Positioner;
	import com.mangum.display.SSP.SSPManager;
	import com.mangum.display.YT.YTManager;
	import com.mangum.display.dashboard.DashboardManager;
	import com.mangum.display.twitter.TwitterManager;
	import com.mangum.events.ActionEvent;
	import com.mangum.text.Messenger;
	import com.mangum.utils.IdleTimer;
	import com.mangum.utils.MouseSpeed;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	[SWF(width='1680', height='1050', backgroundColor='#ffffff', frameRate='24')]
	
	public class Main extends Sprite{
		
		private var bg:Background;		
		private var sspm:SSPManager; 
		private var ytManager:YTManager;
		private var idleTimer:IdleTimer;
		private var content:MovieClip = new MovieClip();
		private var currentSelection:String;
		
		private var ytBtn:MovieClip;
		private var satelliteBtn:MovieClip;
		private var cancerBtn:MovieClip;
		
		private var slideContainer:MovieClip = new MovieClip();
		private var satelliteSlide:MovieClip;
		private var cancerSlide:MovieClip;
		
		private var ms:MouseSpeed = new MouseSpeed();
		private var xSpeed:Number	= 0;
		private var ySpeed:Number	= 0;
		private var friction:Number	= 0.96;
		private var offsetX:Number	= 0;
		private var offsetY:Number	= 0;	
		
		
		private var clock:Messenger; // for testing
		
		public function Main(){	
					
			init();
			
			// **** for testing:
			var ver:Messenger = new Messenger("V .5",60,0x000000,12);
			addChild(ver);
			
			clock = new Messenger(String(idleTimer.idleTime),100);
			clock.setAttribute("size",15);
//			clock.setAttribute("color",0xffffff);
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
			hideCursor();			
			
			// ********* Kiosk Background ********* 			
			bg = new Background();
			addChild(bg);
			
			// ********* Dashboard Widget ********* 
			var dashboard:DashboardManager = new DashboardManager();
			addChild(dashboard);
			dashboard.scaleX = 1.5;
			dashboard.scaleY = 1.5
			dashboard.x = 15;
			dashboard.y = 5;
			
			// ********* Twitter Widget ********* 
			var twitter:TwitterManager = new TwitterManager();
			addChild(twitter);

			twitter.x = 205;
			twitter.y = 10;
			
			
			// ********* Main Content Holder ********* 			
			addChild(content);
			content.name = "content";
			
			// ********* Navigation ********* 
			ytBtn= new YTButton();
			satelliteBtn = new SatelliteButton();
			cancerBtn = new CancerButton();
			var arr:Array = [{id:"satellite", mc:satelliteBtn},
							 {id:"cancer", mc:cancerBtn},
							 {id:"yt", mc:ytBtn}];			
			var n:Nav = new Nav(arr);
			content.addChild(n);
			n.x = 450;
			n.y = 900;			
			n.addEventListener("navSelected",onNavSelected,false,0,true);
			
			
			// ********* Content Slides ********* 
			content.addChild(slideContainer);
			slideContainer.y = 200;

			// Background
			var isogrid:Isogrid = new Isogrid();
			slideContainer.addChild(isogrid);
			isogrid.y = -70;
			
			// SlideshowPro 
			sspm = new SSPManager("http://fic.engr.utexas.edu/ecjkiosk/slideshowpro/images.php?album=5");	
			slideContainer.addChild(sspm);
			sspm.x = 200;
			sspm.y = 20;
			
			// Satellite
			satelliteSlide = new SatelliteSlide();
			slideContainer.addChild(satelliteSlide);
			satelliteSlide.x = stage.stageWidth +200; 
			satelliteSlide.y = 100;	

			// Water Research
			cancerSlide = new CancerSlide();
			slideContainer.addChild(cancerSlide);
			cancerSlide.x =(stage.stageWidth*2) + 200;
			cancerSlide.y = 10;		
			
			// YouTube 		
			ytManager = new YTManager(640,390);
			slideContainer.addChild(ytManager);
			ytManager.x = (stage.stageWidth*3) + 200;
			ytManager.y = 100;					
			
			// ********* Timeout *********
			idleTimer = new IdleTimer(stage, 20);
			idleTimer.addEventListener("handleInteractivity", handleInteractivity);	
						
		}		
		
		
		/* EVENT HANDLERS */
		
		private function onNavSelected(e:ActionEvent):void{
			moveSlide(e.msg);
			
			TweenLite.to(satelliteBtn, .5, {y:0, ease:Cubic.easeOut});	
			TweenLite.to(cancerBtn, .5, {y:0, ease:Cubic.easeOut});
			TweenLite.to(ytBtn, .5, {y:0, ease:Cubic.easeOut});
			TweenLite.to(this[e.msg+"Btn"], .5, {y:10, ease:Cubic.easeOut});	
		}
		
		private function onMouse(e:MouseEvent):void{
			Mouse.hide();
		}
		
		private function handleInteractivity(e:Event):void{	// user interaction timeout
			moveSlide("slideshow");
		}
		

		/* PRIVATE METHODS */
		
		private function moveSlide(val:String):void{
			currentSelection = val;
//			slideContainer.removeEventListener(Event.ENTER_FRAME, throwobject);
			switch (val){
				case "slideshow":
					TweenLite.to(slideContainer, 1.5, {x:0, ease:Cubic.easeOut, onComplete: setBg,onCompleteParams:[val]});	
					ytManager.pauseMovie();
					sspm.playMe();
					break;
				case "satellite":
					TweenLite.to(slideContainer, 1.5, {x:-1700, ease:Cubic.easeOut, onComplete: setBg,onCompleteParams:[val]});	
					ytManager.pauseMovie();
					sspm.pauseMe();
					break;
				case "cancer":
					TweenLite.to(slideContainer, 1.5, {x:-3400, ease:Cubic.easeOut, onComplete: setBg,onCompleteParams:[val]});	
					ytManager.pauseMovie();
					sspm.pauseMe();
					break;
				case "yt":
					TweenLite.to(slideContainer, 1.5, {x:-5100, ease:Cubic.easeOut, onComplete: setBg,onCompleteParams:[val]});	
//					ytManager.playMovie();
					sspm.pauseMe();
					break;				
			}
			
			bg.setImage(val);
		}
		
		private function setBg(sel:String):void{
//			trace("sel: "+sel, currentSelection);
//			bg.setImage(sel);
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