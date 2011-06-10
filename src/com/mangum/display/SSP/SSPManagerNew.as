package com.mangum.display.SSP{
	
	import com.mangum.display.SSP.controller.Controller;
	import com.mangum.display.SSP.model.SSPConnector;
	import com.mangum.display.SSP.view.Output;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width='1680', height='1050', backgroundColor='#0000000', frameRate='24')]
	
	public class SSPManagerNew extends Sprite{
		
		private var model:SSPConnector;
		private var view:Output;
		private var controller:Controller;
		
		
		public function SSPManagerNew(){		
			
			// model
			model = new SSPConnector("http://fic.engr.utexas.edu/ecjkiosk/slideshowpro/images.php?album=5");
			model.addEventListener("onSSPLoaded", onSSPLoaded, false, 0, true);		
			
			// view
			view = new Output(model.ssp);
			
			// controller
			controller = new Controller(model.ssp);
		}
		
		
		/* EVENT HANDLERS */
		
		private function onSSPLoaded(e:Event):void{		
			if(this.contains(view) == false){
				addChild(view);
			}			
		}	
		
	}
}

