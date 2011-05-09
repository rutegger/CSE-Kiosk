package{
	
	import com.mangum.utils.MouseSpeed;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[SWF(width='900', height='500', backgroundColor='#a2a2a2', frameRate='24')]
	public class ThrowTest extends Sprite{	
		
		
		public function ThrowTest(){
			var object:YTButton = new YTButton();
			var btn:SatelliteButton = new SatelliteButton();
			var ms:MouseSpeed = new MouseSpeed();
			var xSpeed:Number	= 0;
			var ySpeed:Number	= 0;
			var friction:Number	= 0.96;
			var offsetX:Number	= 0;
			var offsetY:Number	= 0;
			
			addChild(btn);
			addChild(object);
			
			object.y = stage.stageHeight/2			
			object.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			object.addEventListener(Event.ENTER_FRAME, throwobject);
			
			btn.addEventListener(MouseEvent.CLICK, onClick);
			
			function onClick(e:MouseEvent):void{
				trace("click!");
				stage.removeEventListener(Event.ENTER_FRAME, drag);
//				object.removeEventListener(Event.ENTER_FRAME, throwobject);
			}
			
			function mouseDownHandler(e:MouseEvent):void{
				stage.addEventListener(Event.ENTER_FRAME, drag);
				stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				offsetX = mouseX - object.x;
			}
			
			function mouseUpHandler(e:MouseEvent):void{
				stage.removeEventListener(Event.ENTER_FRAME, drag);
				stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				xSpeed = ms.getXSpeed();
			}

			function drag(e:Event):void{
				object.x = mouseX - offsetX;
				trace("drag: "+object.x);
			}
			
			function throwobject(e:Event){
				object.x += xSpeed;				
				xSpeed *= friction
				trace("throw: "+object.x);
			}
			
			function changeFriction(e:Event):void{
				friction = e.target.value;
			}
		
		}
			
	}
		
}