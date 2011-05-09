package{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.mangum.display.*;
	import com.mangum.display.FlashEffTester;
	import com.mangum.display.Nav;
	import com.mangum.display.Positioner;
	import com.mangum.display.SSP.SSPManager;
	import com.mangum.display.YT.YTManager;
	import com.mangum.display.weather.WeatherManager;
	import com.mangum.display.twitter.TwitterManager;
	import com.mangum.events.ActionEvent;
	import com.mangum.text.Messenger;
	import com.mangum.utils.IdleTimer;
	import com.mangum.utils.MouseSpeed;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.display.Bitmap;
	
	[SWF(width='1680', height='1050', backgroundColor='#0000000', frameRate='24')]
	
	public class Main extends Sprite{
		
		private var bg:Background;
		private var sspm:SSPManager; 
		private var ytManager:YTManager;
		private var idleTimer:IdleTimer;
		private var content:MovieClip = new MovieClip();
		private var currentSelection:String;
		
		private var slideContainer:MovieClip = new MovieClip();
		private var satelliteSlide:MovieClip;
		private var cancerSlide:MovieClip;
		
		private var ms:MouseSpeed = new MouseSpeed();
		private var xSpeed:Number	= 0;
		private var ySpeed:Number	= 0;
		private var friction:Number	= 0.96;
		private var offsetX:Number	= 0;
		private var offsetY:Number	= 0;	
		
		[Embed (source="/../assets/hexagons.png")]
		private var Hex:Class; 

		
		private var clock:Messenger; // for testing
		
		public function Main(){	
					
			var name:String="flash mx";
//			trace(name.split("a")[1].slice(2, 4).toUpperCase());
			init();
			
			// **** for testing:
			var ver:Messenger = new Messenger("V .04",60,0x000000,12);
			addChild(ver);
//			clock = new Messenger(String(idleTimer.idleTime),100);
//			clock.	setAttribute("size",15);
//			clock.setAttribute("color",0xffffff);
//			Positioner.topCenter(stage,clock);
//			idleTimer.addEventListener("tic",onTic,false,0,true);
		
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
			bg = new Background();
			addChild(bg);
			
			// ********* Weather Widget ********* 
			var weather:WeatherManager = new WeatherManager();
			addChild(weather);
			weather.scaleX = 1.5;
			weather.scaleY = 1.5
			weather.x = 15;
			weather.y = 0;
			
			// ********* Twitter Widget ********* 
			var twitter:TwitterManager = new TwitterManager();
			addChild(twitter);

			twitter.x = 480;
			twitter.y = 8;
			
			// ********* Main Content Holder ********* 			
			addChild(content);
			content.name = "content";
			
			// ********* Navigation ********* 
			var ytBtn:MovieClip = new YTButton();
			var satelliteBtn:MovieClip = new SatelliteButton();
			var cancerBtn:MovieClip = new CancerButton();
			var arr:Array = [{id:"satellite", mc:satelliteBtn},
							 {id:"cancer", mc:cancerBtn},
							 {id:"yt", mc:ytBtn}];			
			var n:Nav = new Nav(arr);
			content.addChild(n);
//			n.x = (stage.stageWidth / 2) - (n.width / 2);
			n.x = 800;
			n.y = 0;			
			n.addEventListener("navSelected",onNavSelected,false,0,true);
			
			
			// ********* Content Slides ********* 
			content.addChild(slideContainer);
			slideContainer.y = 200;

			// Background
			var hex:Bitmap = new Hex();
			slideContainer.addChild(hex);
			hex.y = -70;
			
			// Satellite
			satelliteSlide = new SatelliteSlide();
			slideContainer.addChild(satelliteSlide);
			satelliteSlide.x = 110; 
			satelliteSlide.y = 70;	

			// Cancer Research
			cancerSlide = new CancerSlide();
			slideContainer.addChild(cancerSlide);
			cancerSlide.x = stage.stageWidth +200;
			cancerSlide.y = 10;		
			
			// YouTube 		
			ytManager = new YTManager(640,390);
			slideContainer.addChild(ytManager);
			ytManager.x = (stage.stageWidth*2) + 200;
			ytManager.y = 100;
						
//			slideContainer.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
//			slideContainer.addEventListener(Event.ENTER_FRAME, throwobject);	
		
		
			// ********* SlideshowPro *********
//			sspm = new SSPManager(stage, "http://fic.engr.utexas.edu/ecjkiosk/slideshowpro/images.php?album=5");	
//			addChild(sspm);
//			sspm.name = "sspm";
//			sspm.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);			
//			sspm.addEventListener("onFadeOutSSP", onFadeOutSSP, false, 0, true);
//			sspm.addEventListener("onFadeInSSP", onFadeInSSP, false, 0, true);
//			
//			// ********* Timeout *********
//			idleTimer = new IdleTimer(stage, 45);
//			idleTimer.addEventListener("handleInteractivity", handleInteractivity);	
						
			
			// ********* FlashEff *********
//			var ft:FlashEffTester = new FlashEffTester();
//			addChild(ft);
	
		}	
		
		
		
		
		/* EVENT HANDLERS */
		
//		private function mouseDownHandler(e:MouseEvent):void{	
//			slideContainer.addEventListener(Event.ENTER_FRAME, throwobject);	//if !exists
//			stage.addEventListener(Event.ENTER_FRAME, drag);
//			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
//			offsetX = mouseX - slideContainer.x;
//		}
		
//		private function mouseUpHandler(e:MouseEvent):void{
//			stage.removeEventListener(Event.ENTER_FRAME, drag);
//			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
//			xSpeed = ms.getXSpeed();
//		}
		
//		private function drag(e:Event):void{
//			slideContainer.x = mouseX - offsetX;
//			trace("drag: "+Math.floor(slideContainer.x),currentSelection);
//		}
		
//		private function throwobject(e:Event):void{
//			slideContainer.x += xSpeed;				
//			xSpeed *= friction
////			trace("throw: "+Math.floor(slideContainer.x),currentSelection);
////			if(Math.floor(slideContainer.x) > 0 ){
////				moveSlide("yt");
////			} else if(Math.floor(slideContainer.x) > -450 && Math.floor(slideContainer.x) < -1000 && currentSelection != "yt"){
////				moveSlide("yt");
////			} else if (Math.floor(slideContainer.x) <= -451 && currentSelection != "satellite"){
////				trace("sat?");
////				moveSlide("satellite");
////			} 
//			
//			slideContainer.x = Math.floor(slideContainer.x) - mouseX % 500;
//			
//			//  0 to -450 | -451 - 
//		}
		
		private function onNavSelected(e:ActionEvent):void{
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
			currentSelection = val;
//			slideContainer.removeEventListener(Event.ENTER_FRAME, throwobject);
			switch (val){
				case "satellite":
					TweenLite.to(slideContainer, 1.5, {x:0, ease:Cubic.easeOut, onComplete: setBg,onCompleteParams:[val]});	
					ytManager.pauseMovie();
					break;
				case "cancer":
					TweenLite.to(slideContainer, 1.5, {x:-1700, ease:Cubic.easeOut, onComplete: setBg,onCompleteParams:[val]});	
					ytManager.pauseMovie();
					break;
				case "yt":
					TweenLite.to(slideContainer, 1.5, {x:-3400 , ease:Cubic.easeOut, onComplete: setBg,onCompleteParams:[val]});	
					break;
			}
			
			bg.setImage(val);
		}
		
		private function setBg(sel:String):void{
			trace("sel: "+sel, currentSelection);
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