package com.mangum.display{
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	import flash.display.Stage;
	
	public class Positioner{
			
		public function Positioner(){}
		
		public static function center(o:Object):void {
			o.x = (o.stage.stageWidth / 2) - (o.width / 2);
			o.y = o.stage.stageHeight;
			var yVal:Number = (o.stage.stageHeight / 2) - (o.height / 2);			
			TweenLite.to(o, 0.5, {y:yVal, motionBlur:{strength:0.5, quality:2}, ease:Cubic.easeInOut});
		}
		
		public static function topCenter(o:Object):void {
			var xVal:Number = (o.stage.stageWidth / 2) - (o.width / 2);
			TweenLite.to(o, 0.5, {x:xVal, y:-100, motionBlur:{strength:0.5, quality:2}, ease:Cubic.easeOut});
		}
		
		public static function centerRight(o:Object):void {
			var xVal:Number = o.stage.stageWidth + o.width;
			var yVal:Number = o.stage.stageHeight/2 - o.height/2;
			TweenLite.to(o, 0.75, {x:xVal, y:yVal, motionBlur:{strength:0.5, quality:2}, ease:Cubic.easeOut});	
		}
		
		public static function topLeft(o:Object):void {
			o.x = 0;
			o.y = 0;
		}
		
		public static function topRight(stage:Stage,o:Object):void {
			o.x = stage.stageWidth - o.width/1.45;
			o.y = -100;
			
		}
		
		public static function bottomRight(stage:Stage, o:Object):void {
			o.x = stage.stageWidth - o.width
			o.y = stage.stageHeight-(o.height-20);			
//			TweenLite.to(o, 0.75, {x:xVal, y:yVal, motionBlur:{strength:0.5, quality:2}, ease:Cubic.easeOut});	
		}
		
		
		
		
	}
}
