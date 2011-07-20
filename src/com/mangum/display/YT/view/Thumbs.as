package com.mangum.display.YT.view{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.mangum.display.YT.model.YTLoader;
	import com.mangum.text.Messenger;
	import com.mangum.text.StringFX;
	
	import flash.display.Sprite;
	
	public class Thumbs extends Sprite{
		
		private var cont:Sprite;
		private var box:Sprite;
		private var boxShadow:Sprite;
		private var msgBgArr:Array;
		private var nowPlaying:Sprite;
		private var gutter:Number = 30;	
//		private var movArr:Array = new Array();
		private var _height:Number;
		private var _width:Number;
		private var movArr:Array = new Array();
		private var navBg:Sprite = new NavBg();
		
		public function Thumbs(arr:Array,thbWidth:Number,h:Number,boxWidth:Number){	
			
			var xCount:Number = 0;
			var xVal:Number = 0;
			var yVal:Number = 12;
			var len:uint = arr.length;	
			var multiplier:Number = thbWidth * arr.length;
			var newRow:Boolean = false;
			var currWidth:Number;
			var rows:int = 1;
			var totalHeight:Number;
			
			// **** might consider putting a cap on length
			
			msgBgArr = new Array();
			
			for(var i:uint = 0; i < len; i++){
				
				var yt:YTLoader = new YTLoader(arr[i].id,arr[i].title,arr[i].description,thbWidth,h,true); 
				boxShadow = new BoxShadow();
				addChild(boxShadow);
				box = new Box();
				addChild(box);
				
				currWidth = xCount + thbWidth;	
				
				if((boxWidth-currWidth) > 0){								
					xVal = xCount;																	
				} else {	
					rows++;
					xCount = 0;	
					xVal = 0;
					yVal += h * 1.75;						
				}
				
				yt.x = xVal;				
				yt.y = yVal;
				box.x =  xVal - 10;
				box.y =  yVal - 12;
				box.width = yt.w + 30;
				box.height = yt.h + 60;
				boxShadow.x = box.x + 5;
				boxShadow.y = box.y + 5;			
				boxShadow.width = box.width;
				boxShadow.height = box.height;
				
				xCount += thbWidth + 45;
				
				addChild(yt);
				
				var msgBg:Sprite = drawMsgBk(); 
				addChild(msgBg);					
				
				nowPlaying = new NowPlaying();
				addChild(nowPlaying);
				nowPlaying.x = yt.x;
				nowPlaying.y = yt.y;
				nowPlaying.alpha = 0;
				
				msgBg.x = box.x + 10;
				msgBg.y = box.y + 105;
				msgBg.width = box.width - 30;
				msgBg.height = 38;
				TweenMax.to(msgBg, 0, {tint:0x736357});
				
				var msg:Messenger = new Messenger("--",thbWidth-5,0xffffff,13,true);	
				msg.uppercase = true;
				msg.setLabel(StringFX.truncate(arr[i].title,45,"..."));
				msg.x = xVal;
				msg.y = yVal + h - 3;
				addChild(msg);	
				
				totalHeight = h+msg.height+(gutter*1.4);
				
				movArr[i] = {mov:yt, id:arr[i].id, mc:msgBg, np:nowPlaying};
				
				TweenMax.to(movArr[0].mc, 0, {tint:0xEEB111}); // highlight
				TweenLite.to(movArr[0].np, 0, {alpha:1});
			}			
			
			_height = (totalHeight * rows);
			_width = _width - gutter/3;
			
			navBg.width = xCount+gutter/1.5;
			navBg.height = 75 + gutter;
			
			// to access later
			//			movArr[0].x = 0;
			//			movArr[1].x = 400;
			
			//			movArr[0].highlight();
			
		}	
		
		private function drawMsgBk():Sprite{
			var box:Sprite = new Sprite();
			//			box.graphics.lineStyle(0,0x000000);
			box.graphics.beginFill(0x736357,1);
			box.graphics.drawRect(0,0,180,40);			
			box.graphics.endFill();
			return box;
		}
	}
}