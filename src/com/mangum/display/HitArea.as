package com.mangum.display{
		
		import flash.display.MovieClip;
		import flash.display.Sprite;
		import flash.events.Event;
		import flash.events.MouseEvent;
		
		public class HitArea extends MovieClip {
			
			public var hitAreaContainer:Sprite = new Sprite();		
			
			private var _xval:int;		
			private var _yval:int;
			private var _w:int;
			private var _h:int;
			
			public function HitArea($xval:int,$yval:int,$w:int,$h:int){			
				this._xval = $xval;
				this._yval = $yval;
				this._w = $w;
				this._h = $h;
				
				createHitArea(_xval,_yval,_w,_h);		
			}
			
			private function createHitArea(_xval:int,_yval:int,_w:int,_h:int):Sprite {						
				addChild(hitAreaContainer);	
				var shape:Sprite = new Sprite();
				
				shape.x=_xval;
				shape.y=_yval;
				shape.graphics.lineStyle(1, 0);
				shape.graphics.beginFill(0xFF00FF);
				shape.graphics.drawRect(0,0,_w,_h);
				shape.graphics.endFill();
				
				shape.alpha = 0 // hide button				
				
				hitAreaContainer.addChild(shape);
				hitAreaContainer.buttonMode = true;
				
				shape.addEventListener(MouseEvent.CLICK, onClick);
				shape.buttonMode = false;
				
				return shape;
			}	
			
			private function onClick(e:MouseEvent):void {
				dispatchEvent(new Event("clicked"));		
			}
				
			public function showButton(val:Boolean):void {
				hitAreaContainer.buttonMode = val;				
			}
			
		}
		
	}