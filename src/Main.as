package{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*; 
	TweenPlugin.activate([MotionBlurPlugin]);
	
	import com.mangum.display.*;
	import com.mangum.display.SSP.SSPManager;
	import com.mangum.display.YT.YTManager;
	import com.mangum.display.delicious.DeliciousManager;
	import com.mangum.display.nav.Navigator;
	import com.mangum.display.twitter.TwitterManager;
	import com.mangum.display.weather.DashboardManager;
	import com.mangum.events.ActionEvent;
	import com.mangum.text.Messenger;
	import com.mangum.utils.IdleTimer;
	import com.mangum.utils.MouseSpeed;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;

	
	[SWF(width='1866', height='1050', backgroundColor='#cccccc', frameRate='24')]
	
	public class Main extends Sprite{
		
		private var screens:Array = new Array({id:"home", bg:"/../assets/bg0.jpg"},
											  {id:"button1", bg:"/../assets/bg1.jpg"},
											  {id:"button2", bg:"/../assets/bg2.jpg"},
											  {id:"button3", bg:"/../assets/bg3.jpg"});
		private var bg:Background;		
		private var sspm:SSPManager; 
		private var ytManager:YTManager;
		private var idleTimer:IdleTimer;
		private var content:MovieClip = new MovieClip();
		private var currentSelection:String;
		
		private var n:Navigator;
		private var slideContainer:MovieClip = new MovieClip();
		private var satelliteSlide:MovieClip;
		private var cancerSlide:MovieClip;
		
		private var ms:MouseSpeed = new MouseSpeed();
		private var xSpeed:Number	= 0;
		private var ySpeed:Number	= 0;
		private var friction:Number	= 0.96;
		private var offsetX:Number	= 0;
		private var offsetY:Number	= 0;	
		private var fumbling:int    = 0;
		
		private var help:Help = new Help();
		
		private var clock:Messenger; // for testing
		
		public function Main(){	
			
			init();
			
			// **** for testing:
			var ver:Messenger = new Messenger("V .5",60,0x000000,12);
//			addChild(ver);
			
			clock = new Messenger(String(idleTimer.idleTime),100);
			clock.setAttribute("size",15);/* ignoring this */
			clock.setAttribute("color",0xffffff); /* ignoring this */
//			addChild(clock);
			Positioner.topCenter(stage,clock);
			idleTimer.addEventListener("tic",onTic,false,0,true);
			
			var loadMsg:LoaderMessage = new LoaderMessage(stage);
			addChild(loadMsg);
			
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
			bg = new Background(screens);
			addChild(bg);
			
			// ********* Weather Widget ********* 
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
			twitter.y = 15;			
			
			// ********* Delicious Widget ********* 
			var dm:DeliciousManager = new DeliciousManager();
			addChild(dm);
			
			dm.x = 960;
			dm.y = 40;	
			
			// ********* Main Content Holder ********* 			
			addChild(content);
			content.name = "content";
			
			
			// ********* Navigation ********* 
			
			n = new Navigator(screens);
			addChild(n);
			n.x = 0;
			n.y = 902;
			n.addEventListener("navSelected",onNavSelected,false,0,true);
			n.setDefault();
			
	
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
			var slide1:Slide1 = new Slide1();
			slideContainer.addChild(slide1);
			slide1.x = stage.stageWidth; 
//			slide1.y = 100;	

			// Water Research
			cancerSlide = new CancerSlide();
			slideContainer.addChild(cancerSlide);
			cancerSlide.x =(stage.stageWidth*2);
			cancerSlide.y = 10;		
			
			// YouTube 		
			ytManager = new YTManager(640,390);
			slideContainer.addChild(ytManager);
			ytManager.x = (stage.stageWidth*3+300);
			ytManager.y = 240;					
			
			// ********* Timeout *********
			idleTimer = new IdleTimer(stage, 20);
			idleTimer.addEventListener("handleInteractivity", handleInteractivity);	
						
			stage.addEventListener(MouseEvent.CLICK, onClick);
			addEventListener("UIClick", onUIClick,false,0,true);
			
			addChild(help);
			help.x = 50;
			help.y = 800;
						
		}		
		
		
		/* EVENT HANDLERS */
		
		protected function onClick(event:MouseEvent):void{
			helpBubble(true);
		}		
		
		protected function onUIClick(event:Event):void{
			// cancel help bubble
			helpBubble(false);
		}		

		protected function onNavSelected(e:ActionEvent):void{
			moveSlide(e.msg);
		}
		
		protected function onMouse(e:MouseEvent):void{
			Mouse.hide();
		}
		
		protected function handleInteractivity(e:Event):void{	// user interaction timeout, send home
			moveSlide("home");
			n.setDefault();
		}
		

		/* PRIVATE METHODS */
		
		private function helpBubble(bool:Boolean):void{
			if(bool){
				fumbling++;
			} else {
			    fumbling = 0;
				TweenLite.to(help, 2, {alpha:0, ease:Sine.easeOut});
			}	
			if(fumbling > 3){
				TweenLite.to(help, 2, {alpha:1, ease:Sine.easeOut});
			}
		}
		
		private function moveSlide(val:String):void{
			currentSelection = val;
			switch (val){
				case "home":
					TweenMax.to(slideContainer, 1.5, {x:0, ease:Cubic.easeOut, onComplete:onSlideComplete,onCompleteParams:[val]/*, motionBlur:{strength:1, fastMode:true, padding:10*/});
					ytManager.pauseMovie();
					sspm.playMe();
					break;
				case "button1":
					TweenMax.to(slideContainer, 1.5, {x:-stage.stageWidth, ease:Cubic.easeOut, onComplete:onSlideComplete,onCompleteParams:[val]/*, motionBlur:{strength:1, fastMode:true, padding:10*/});	
					ytManager.pauseMovie();	
					sspm.pauseMe();
					break;
				case "button2":
					TweenMax.to(slideContainer, 1.5, {x:-stage.stageWidth *2, ease:Cubic.easeOut, onComplete:onSlideComplete,onCompleteParams:[val]/*, motionBlur:{strength:1, fastMode:true, padding:10*/});	
					ytManager.pauseMovie();
					sspm.pauseMe();
					break;
				case "button3":
					TweenMax.to(slideContainer, 1.5, {x:-stage.stageWidth*3, ease:Cubic.easeOut, onComplete:onSlideComplete,onCompleteParams:[val]/*, motionBlur:{strength:1, fastMode:true, padding:10*/});	
					sspm.pauseMe();
					break;				
			}	
			bg.setImage(val);
		}
		
		private function onSlideComplete(sel:String):void{
			// stub
		}
		
		private function hideCursor():void{
			// Hide cursor - kludgy, but Mouse.hide() alone doesn't work
			addEventListener(MouseEvent.CLICK, onMouse, false, 0, true);
			addEventListener(MouseEvent.MOUSE_MOVE, onMouse, false, 0, true);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouse, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OVER, onMouse, false, 0, true);
		}		
	}	
}