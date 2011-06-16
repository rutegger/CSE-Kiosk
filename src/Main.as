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
	import com.mangum.display.delicious.DeliciousManager;
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
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	
	[SWF(width='1866', height='1050', backgroundColor='#cccccc', frameRate='24')]
	
	public class Main extends Sprite{
		
		private var bg:Background;		
		private var sspm:SSPManager; 
		private var ytManager:YTManager;
		private var idleTimer:IdleTimer;
		private var content:MovieClip = new MovieClip();
		private var currentSelection:String;
		
		private var homeBtn:HomeBtn;
		private var button01:MovieClip; // satellite
		private var button02:MovieClip; // water research
		private var button03:MovieClip; // YouTube
		
		private var n:Nav;
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
			//addChild(ver);
			
			//clock = new Messenger(String(idleTimer.idleTime),100);
			//clock.setAttribute("size",15);
//			clock.setAttribute("color",0xffffff);
			//Positioner.topCenter(stage,clock);
			//idleTimer.addEventListener("tic",onTic,false,0,true);
			
		}

		
		/* TESTING FUNCTIONS */
		
		private function onTic(e:ActionEvent):void{	
			clock.setLabel(e.msg);
			if(this.getChildByName("clock") == null) addChild(clock);
		}
		/* ***************** */
		
		
		private function init():void{
						
//			stage.displayState = StageDisplayState.FULL_SCREEN;	
//			stage.scaleMode = StageScaleMode.NO_SCALE;
//			stage.align = StageAlign.TOP_LEFT;

//			hideCursor();			
			
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

			twitter.x = 495;
			twitter.y = 10;			
			
			// ********* Delicious Widget ********* 
			var dm:DeliciousManager = new DeliciousManager();
			addChild(dm);
			
			dm.x = 960;
			dm.y = 40;	
			
			// ********* Main Content Holder ********* 			
			addChild(content);
			content.name = "content";
			
			
			// ********* Navigation ********* 
			homeBtn = new HomeBtn();
			button01 = new Button01();
			button02 = new Button02();
			button03 = new Button03();
			var arr:Array = [{id:"ssp", mc:homeBtn},
							 {id:"satellite", mc:button01},
							 {id:"cancer", mc:button02},
							 {id:"yt", mc:button03}];			
			n = new Nav(arr);
			content.addChild(n);
			n.x = -80;
			n.y = 932;			
			n.addEventListener("navSelected",onNavSelected,false,0,true);
			
			
			// ********* Content Slides ********* 
			content.addChild(slideContainer);
			slideContainer.y = 0;

			// Background
			var isogrid:Isogrid = new Isogrid();
			slideContainer.addChild(isogrid);
			isogrid.y = -70;
			
			// SlideshowPro 
			var slide0:Slide0 = new Slide0();
			slideContainer.addChild(slide0);
			sspm = new SSPManager("http://fic.engr.utexas.edu/ecjkiosk/slideshowpro/images.php?album=5");	
			slideContainer.addChild(sspm);
			sspm.x = 821;
			sspm.y = 431;
			
			// Satellite
			satelliteSlide = new SatelliteSlide();
			slideContainer.addChild(satelliteSlide);
			satelliteSlide.x = stage.stageWidth; 
			satelliteSlide.y = 100;	

			// Water Research
			cancerSlide = new CancerSlide();
			slideContainer.addChild(cancerSlide);
			cancerSlide.x =(stage.stageWidth*2);
			cancerSlide.y = 10;		
			
			// YouTube 		
			ytManager = new YTManager(640,390);
			slideContainer.addChild(ytManager);
			ytManager.x = (stage.stageWidth*3);
			ytManager.y = 100;					
			
			// ********* Timeout *********
			idleTimer = new IdleTimer(stage, 20);
			idleTimer.addEventListener("handleInteractivity", handleInteractivity);	
						
		}		
		
		
		/* EVENT HANDLERS */
		
		private function onNavSelected(e:ActionEvent):void{
			moveSlide(e.msg);
			TweenLite.to(button01, .5, {y:0, ease:Cubic.easeOut});	
			TweenLite.to(button02, .5, {y:0, ease:Cubic.easeOut});
			TweenLite.to(button03, .5, {y:0, ease:Cubic.easeOut});
//			TweenLite.to(this[e.msg+"Btn"], .5, {y:-10, ease:Cubic.easeOut});	
		}
		
		private function onMouse(e:MouseEvent):void{
			Mouse.hide();
		}
		
		private function handleInteractivity(e:Event):void{	// user interaction timeout
			moveSlide("ssp");
			n.current = 0;
		}
		

		/* PRIVATE METHODS */
		
		private function moveSlide(val:String):void{
			currentSelection = val;
//			slideContainer.removeEventListener(Event.ENTER_FRAME, throwobject);
			switch (val){
				case "ssp":
					TweenLite.to(slideContainer, 1.5, {x:0, ease:Cubic.easeOut, onComplete: onSlideComplete,onCompleteParams:[val]});	
					ytManager.pauseMovie();
					sspm.playMe();
					break;
				case "satellite":
					TweenLite.to(slideContainer, 1.5, {x:-stage.stageWidth, ease:Cubic.easeOut, onComplete: onSlideComplete,onCompleteParams:[val]});	
					ytManager.pauseMovie();
					sspm.pauseMe();
					break;
				case "cancer":
					TweenLite.to(slideContainer, 1.5, {x:-stage.stageWidth *2, ease:Cubic.easeOut, onComplete: onSlideComplete,onCompleteParams:[val]});	
					ytManager.pauseMovie();
					sspm.pauseMe();
					break;
				case "yt":
					TweenLite.to(slideContainer, 1.5, {x:-stage.stageWidth*3, ease:Cubic.easeOut, onComplete: onSlideComplete,onCompleteParams:[val]});	
//					ytManager.playMovie();
					sspm.pauseMe();
					break;				
			}
			
			bg.setImage(val);
		}
		
		private function onSlideComplete(sel:String):void{
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