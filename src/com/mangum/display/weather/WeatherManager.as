package com.mangum.display.weather{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.mangum.display.weather.model.WeatherService;
	import com.mangum.display.weather.view.Output;

	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;	
	
	public class WeatherManager extends Sprite{
		
		private var ws:WeatherService;	
		private var output:Output;
		
		public function WeatherManager(){
			
			//model
			ws = WeatherService.getInstance(); // Singleton
			ws.addEventListener("onWeatherLoaded", onWeatherLoaded, false, 0, true);	
			
			//view
			output = new Output();
			output.scaleX = .65;
			output.scaleY = .65;
			output.x = 5;
			output.y = 15;

		}		
		
		/* EVENT HANDLERS */
		
		private function onWeatherLoaded(e:Event):void{
			output.init(ws);
			addChild(output);

		}
	}
}




