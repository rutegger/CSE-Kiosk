package com.mangum.display.YT{
		
	import com.mangum.events.ActionEvent;
	import com.mangum.text.Messenger;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	
	public class YTMenu extends MovieClip{		
	
		private var cont:MovieClip;
		private var movArr:Array = new Array();
		private var _width:Number;
		private var _height:Number;
		private var navBg:Sprite = new NavBg();
		private var gutter:Number = 30;	
		private var box:Sprite;
		
		public function YTMenu(arr:Array,thumbWidth:Number=200,boxWidth:Number=500){	
			var height:Number=thumbWidth*.5;
			_width = boxWidth;
			
			box = new Box();
			addChild(box);
			box.x = -5;
			box.y = 0;
			
			mkMenu(arr,thumbWidth,height,boxWidth);
			this.addEventListener("selected", onSelected);
			
		}
		
		/* EVENT HANDLERS */
		
		
		private function onSelected(e:ActionEvent):void{
//			trace(e.msg);
//			trace(movArr[0].id);
			var len:int = movArr.length;
			for(var i:int = 0; i < len; i++){				
				if(movArr[i].id != e.msg){					
					movArr[i].highlight(false);
				}else{
					movArr[i].highlight();				
				}			
			}			
		}	
		
		/* PRIVATE METHODS */
		
		private function mkMenu(arr:Array,thbWidth:Number,h:Number,boxWidth:Number):void{
			cont = new MovieClip();
			addChild(cont);
//			cont.addChild(navBg);
//			navBg.x = -gutter/2;
			createThumbs(arr,thbWidth,h,boxWidth);
		}
		
		private function createThumbs(arr:Array,thbWidth:Number,h:Number,boxWidth:Number):void{		
			var xCount:Number = 0;
			var xVal:Number = 0;
			var yVal:Number = 17;
			var len:uint = arr.length;	
			var multiplier:Number = thbWidth * arr.length;
			var newRow:Boolean = false;
			var currWidth:Number;
			var rows:int = 1;
			var totalHeight:Number;
			
			for(var i:uint = 0; i < len; i++){
				var yt:YTLoader = new YTLoader(arr[i].id,thbWidth,h,true); 
				cont.addChild(yt);
				//so we can access later
				movArr[i] = yt;		
				currWidth = xCount + thbWidth;	
				
				if((boxWidth-currWidth) > 0){								
					xVal = xCount;																	
				} else {	
					rows++;
					xCount = 0;	
					xVal = 0;
					yVal += h * 2.2;						
				}

				yt.x = xVal;
				
				yt.y = yVal;
				var msg:Messenger = new Messenger(arr[i].title,thbWidth,0xcc3333,13);
				
				totalHeight = h+msg.height+(gutter*2);
				
//				msg.setAttribute("color",0xff00ff); //doesn't work ??
				
				addChild(msg);
			
				msg.x = xVal;
				msg.y = yVal + h;
				xCount += thbWidth + 25;			
			}			
			
			_height = (totalHeight * rows);
			_width = _width - gutter/3;
			
			box.width = _width;
			box.height = _height;
			
			navBg.width = xCount+gutter/1.5;
			navBg.height = 75 + gutter;
				
			// to access later
//			movArr[0].x = 0;
//			movArr[1].x = 400;
			
			movArr[0].highlight();
			
 		}		
		
		
		/* GETTER SETTERS */
		
		public function get w():Number {
			return _width;
		}		
				
		public function get h():Number {
			return _height;
		}			
		

		
	}
	
}