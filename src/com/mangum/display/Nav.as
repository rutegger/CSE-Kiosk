package com.mangum.display{
	
	import com.mangum.display.HitArea;
	import com.mangum.events.ActionEvent;
	import com.mangum.text.Messenger;
	import com.mangum.display.HitArea	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import mx.flash.UIMovieClip;
	
	
	public class Nav extends Sprite{
		
		private var _items:Array;
//		private var arrowRight:Sprite = new ArrowRight();
//		private var arrowLeft:Sprite = new ArrowLeft();
		private var _current:uint = 0;
		
		public function Nav(items:Array){	
			_items = items;	
			if (stage) createMenuItems();
			else addEventListener(Event.ADDED_TO_STAGE, init);
//			showArrow(arrowLeft,false);
//			showArrow(arrowRight,false);
		}
		
		
		/* EVENT HANDLERS */	
		
		private function setSlide(slide:String):void{
			
			dispatchEvent(new ActionEvent(slide, "navSelected", true));
//			var slide:String;
//			
//			if (getIndex(slide) != -1){
//				_current = getIndex(slide);
//				slide = slide;		
//			}else {	
//				if(slide == "right"){
//					showArrow(arrowLeft,true);
//					_current ++;					
//				}else if(slide == "left"){
//					_current --;
//					showArrow(arrowRight,true);							
//				}
//				slide = _items[_current].id;
//				
//			} 			
//			setArrows();			
//			dispatchEvent(new ActionEvent(slide, "navSelected", true));
		}
		
		private function onClicked(e:Event):void{
			setSlide(e.target.name);
		}
		
		
		/* PRIVATE METHODS */	
		
//		private function showArrow(mc:Sprite,bool:Boolean):void{
//			mc.y = (bool) ? 0 : 1000;
//		}		
		
		private function getIndex(target:String):int{
			var index:int = -1;
			for(var i:uint = 0; i < _items.length; i++){
				if(target == _items[i].id){
					index = i;			
				}				
			}
			return index;
		}
		
//		private function setArrows():void{
//			if (_current >= _items.length-1){
//				showArrow(arrowRight,false);				
//			} else {
//				showArrow(arrowRight,true);
//			}
//			if (_current == 0){
//				showArrow(arrowLeft,false);
//			} else {
//				showArrow(arrowLeft,true);
//			}
//		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			createMenuItems();
			
//			addChild(arrowRight);
//			arrowRight.name = "right"
//			arrowRight.x = this.width-100;
//			addChild(arrowLeft);
//			arrowLeft.name = "left"
//			arrowLeft.x = -50;
//			
//			arrowRight.addEventListener(MouseEvent.CLICK, onClicked, false, 0 , true);
//			arrowLeft.addEventListener(MouseEvent.CLICK, onClicked, false, 0 , true);
		}
		
		private function createMenuItems():void{
			
			//trace(_items[i].mc.width+","+stage.stageWidth);
			var div:Number = Math.floor(stage.stageWidth/_items[i].mc.width);
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
		
		public function set current(val:int):void {
			_current = current;
//			showArrow(arrowRight,true);
//			showArrow(arrowLeft, false);
		}		
		public function get current():int {
			return _current;
		}
		
	}
	
}

