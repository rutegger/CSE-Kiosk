package com.mangum.display{
	
	import com.mangum.display.HitArea;
	import com.mangum.events.ActionEvent;
	import com.mangum.text.Messenger;
	import com.seb.Carousel;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	
	public class Nav extends Sprite{
		
		private var _items:Array;
		
		public function Nav(items:Array){	
			_items = items;
			
			if (stage) createMenuItems();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		/* EVENT HANDLERS */		
		
		private function onClicked(e:Event):void{ 
			dispatchEvent(new ActionEvent(e.target.name, "navSelected", true));
		}
		
		
		/* PRIVATE METHODS */	
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			createMenuItems()
		}
		
		private function createMenuItems():void{
			
			//trace(_items[i].mc.width+","+stage.stageWidth);
			var div:Number = Math.floor(stage.stageWidth/_items[i].mc.width);
			//trace(div);
		    var xVal:Number = 0;
			var space:Number = 240;	// want this number			
			
			var len:int = _items.length;
			for(var i:int = 0;i < len; i++){
				var mc:MovieClip = _items[i].mc;
				addChild(mc);
				mc.x = xVal;
				var hitArea:HitArea = new HitArea(0, 0, mc.width, mc.height);				
				addChild(hitArea);	
				hitArea.x = mc.x;
				hitArea.name = _items[i].id;
				hitArea.addEventListener("clicked", onClicked);
				xVal += space;	
			}			
			
		}
		
		
		/* GETTER SETTERS */
		
	}
	
}

