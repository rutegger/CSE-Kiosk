package com.mangum.display.nav{
	
	import com.greensock.*;
	import com.greensock.plugins.*;
	import com.mangum.display.HitArea;
	import com.mangum.events.ActionEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Navigator extends MovieClip{
		
		private var _screens:Array;
		private var navButtons:NavButtons;
		private var _current:uint = 0;
		
		public function Navigator(screens:Array){
			_screens = screens;
			init();
		}
		
		private function init():void{
			TweenPlugin.activate([TintPlugin]);
			
			navButtons = new NavButtons();
			addChild(navButtons);
			
			// assign buttons
			for (var i:int = 0; i < _screens.length; i++) {
				var hitArea:HitArea = new HitArea(0, 0, navButtons[_screens[i].id].width, navButtons[_screens[i].id].height);				
				addChild(hitArea);	
				hitArea.name = _screens[i].id;
				hitArea.x = navButtons[_screens[i].id].x;
				hitArea.addEventListener("clicked", onClick);
				navButtons[_screens[i].id].topBar.visible = false;
			}		

		}
		
		
		/* EVENT HANDLERS */
		
		protected function onClick(e:Event):void{
			dispatchEvent(new ActionEvent(e.target.name, "navSelected", true));
					
			for (var j:String in _screens){
				showTopBar(_screens[j].id,false);
				highlight(_screens[j].id,false);
				textGlow(_screens[j].id,false);
				arrow(_screens[j].id,false);
				if(_screens[j].id == e.target.name){
					arrow(_screens[j].id,true);
					showTopBar(e.target.name,true);
					highlight(e.target.name,true);
					textGlow(_screens[j].id,true);
				}
			}			
		}
		
		
		/* PRIVATE METHODS */
		
		private function showTopBar(mc:String,val:Boolean):void{
			navButtons[mc].topBar.visible = (val) ? true : false;
		}
		
		private function highlight(mc:String,val:Boolean):void{
			var col:Number = (val) ? 0xEEB111 : 0xC7B299
			TweenMax.to(navButtons[mc].stroke, 1, {tint:col});
		}
		
		private function textGlow(mc:String,val:Boolean):void{
			var col:Number = (val) ? 0xEEB111 : 0xffffff
			TweenMax.to(navButtons[mc].navText, 1, {tint:col});
		}
		
		private function arrow(mc:String,val:Boolean):void{
			var bright:Number = (val) ? 1 : 100
			TweenMax.to(navButtons[mc].arrow, 0, {colorTransform:{brightness:bright}});
		}
		
		
		/* PUBLIC METHODS */
		
		public function setDefault():void{
			arrow(_screens[0].id,true);
			showTopBar(_screens[0].id,true);
			highlight(_screens[0].id,true);
			textGlow(_screens[0].id,true);
		}
	}
	
}