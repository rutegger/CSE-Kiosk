package com.mangum.display.YT.view{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.mangum.display.YT.controller.YTMenu;
	import com.mangum.display.YT.model.YTLoader;
	import com.mangum.events.VidEvent;
	import com.mangum.display.YT.view.InfoBox;
	
	import flash.display.Sprite;
	
	public class MainViewer extends Sprite{
		
		private var mov:YTLoader;
		private var menu:YTMenu;
		private var _infoBox:InfoBox;
		
		public function MainViewer(){}
		
		public function init(vids:Array,width:Number,height:Number):void{
			
			var boxShadow:Sprite = new BoxShadow();
			addChild(boxShadow);
			boxShadow.x = 7;
			boxShadow.y = -7;
			boxShadow.width = width + 28;
			boxShadow.height = height - 2;
			
			var box:Sprite = new Box();
			addChild(box);
			box.x = 2;
			box.y = -12;
			box.width = width + 28;
			box.height = height - 2;
			TweenMax.to(box, 1, {tint:0x736357}); // set to brown
			
			if(vids.length > 0){
				addChild(mkMovie(vids,width,height));
				addChild(mkNav(vids));
			} else {
				trace("Sorry, Cockrell School Videos not available");
			}		
			
			// Add Video Caption
			_infoBox =  new InfoBox();
			addChild(_infoBox);
			_infoBox.y = 410;
			_infoBox.x = 160;
			_infoBox.updateText(vids[0].title, vids[0].description);	

		}
		
		
		/* PUBLIC METHODS */
		
		public function pauseMovie():void{
			mov.pause()
		}
		
		public function startVideo():void{
			mov.startVideo()
		}
		
		
		/* EVENT HANDLERS */
		
		private function onSelected(e:VidEvent):void{
			mov.playVideo(e.args.id);
			_infoBox.updateText(e.args.title,e.args.description);
		}
		
		
		/* PRIVATE METHODS */	
		
		private function mkMovie(arr:Array,width:Number,height:Number):Sprite{	
			mov = new YTLoader(arr[0].id, arr[0].title, arr[0].description, width,height,false);  
			mov.mask = createMask();
			return mov;
		}
		
		private function mkNav(arr:Array):Sprite{
			menu = new YTMenu(arr,196,4); // mov array, thumb width, # of columns			
			menu.x = 685;
			menu.y = 45;					
			menu.addEventListener("selected", onSelected, false, 0, true);
			menu.buttonMode = false;
			return menu;
		}
		
		private function createMask():Sprite{
			var shape:Sprite = new Sprite();					
			shape.graphics.lineStyle(1, 0);
			shape.graphics.beginFill(0xFF00FF);
			shape.graphics.drawRect(0,-70,1900,370); // since the mask wont follow the slide I just made the width 100%; 
			// also have to add gutter _hieght for some reason
			shape.graphics.endFill();
			shape.y = 300;
			return shape;
		}
	}
}