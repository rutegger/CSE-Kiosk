package com.mangum.display.SSP{
	
	import com.mangum.display.SSP.controller.Controller;
	import com.mangum.display.SSP.model.SSPConnector;
	import com.mangum.display.SSP.view.Output;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import net.slideshowpro.slideshowpro.SlideShowPro;
	
	[SWF(width='1680', height='1050', backgroundColor='#0000000', frameRate='24')]
	
	public class SSPManager extends Sprite{
		
		private var model:SSPConnector;
		private var view:Output;
		private var controller:Controller;
	
		private var _ssp:SlideShowPro;
		
		public function SSPManager(path:String){		
			
			// model
			model = new SSPConnector(path);
			model.addEventListener("onSSPLoaded", onSSPLoaded, false, 0, true);	
			
			// view
			view = new Output(model.ssp);
			
			// controller
//			controller = new Controller(model.ssp);
		}
		
		/* PUBLIC METHODS */
		
		public function pauseMe():void{
			view.pauseMe()
		}
		
		public function playMe():void{
			view.playMe();
		}
		
		/* PRIVATE METHODS*/

		
		
		/* EVENT HANDLERS */
		
		private function onSSPLoaded(e:Event):void{		
			if(this.contains(view) == false){
				addChild(view);
//				view_ssp = model.ssp;
//				trace("_ssp: "+_ssp.contentOrder);
//				_ssp.playMedia();
			}			
		}	
		
	}
}

