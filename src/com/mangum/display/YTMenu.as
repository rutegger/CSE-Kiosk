package com.mangum.display{
		
	import com.mangum.display.YTLoader;
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
		private var _boxSize:Number
		private var navBg:Sprite = new NavBg();
		private var gutter:Number = 30;		
		
		public function YTMenu(arr:Array,width:Number=200,boxSize:Number=500){	
			var height:Number=width*.5;
			_boxSize = boxSize;
			mkMenu(arr,width,height,boxSize);
			this.addEventListener("selected", onSelected);
//		    this.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
		}
		
		/* EVENT HANDLERS */
		
//		private function onClick(e:MouseEvent):Number{
//			return e.localX;
//		}
		
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
	
		private function mkMenu(arr:Array,w:Number,h:Number,b:Number):void{
			cont = new MovieClip();
			addChild(cont);
//			cont.addChild(navBg);
//			navBg.x = -gutter/2;
			createThumbs(arr,w,h,b);
		}
		
		private function createThumbs(arr:Array,w:Number,h:Number,b:Number):void{		
			var xCount:Number = 0;
			var len:uint = arr.length;	
			var multiplier:Number = w * arr.length;
			
			for(var i:uint = 0; i < len; i++){
				var yt:YTLoader = new YTLoader(arr[i].id,w,h,true); 
				
				cont.addChild(yt);	

				yt.x = xCount;
				yt.y += 15;	
				
				trace("curr width: "+xCount);
				
				//so we can access later
				movArr[i] = yt;						
				
				mkTitle(arr[i].title, w, h, xCount);
				xCount+=w+25;
			}			
			
			navBg.width = xCount+gutter/1.5;
			navBg.height = 75 + gutter;
				
			// to access later
//			movArr[0].x = 0;
//			movArr[1].x = 400;
			
			movArr[0].highlight();
			
 		}		
		
		private function mkTitle(txt:String,width:Number,height:Number,pos:Number):void{
			var msg:Messenger = new Messenger(txt,width);
			addChild(msg);
			msg.x = pos;
			msg.y = height+gutter/1.5;
			
//			msg.setSize(20);
		}
		
		
		/* GETTER SETTERS */
		
		public function get w():Number {
			return navBg.width;
		}		
				
		public function get h():Number {
			return navBg.height;
		}			

		
	}
	
}