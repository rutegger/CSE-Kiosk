package com.mangum.text {
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Messenger extends Sprite {
		
		private var label:TextField;
		private var labelText:String; 
		private var container:MovieClip =  new MovieClip();
		
		public function Messenger(msg:String,width:Number) {
			addChild(container);
			labelText = msg;
			configureLabel(width);
			setLabel(labelText);
			setShadow();			
		}
		
		/* PUBLIC METHODS */
		
		public function setLabel(str:String):void {
			label.text = str;
		}	

		
		/* PRIVATE METHODS */
		private function configureLabel(width:Number):void {
			label = new TextField();
			label.autoSize = TextFieldAutoSize.LEFT;
			label.background = false;
			label.border = false;
			label.selectable = false;
			
			var format:TextFormat = new TextFormat();
			format.font = "Arial";
			format.color = 0xFFFFFF;
			format.size = 10;
			format.bold = true;
			format.underline = false;
			format.kerning = true;
			format.letterSpacing = 0;			

			label.defaultTextFormat = format;
			label.wordWrap = true;
			label.width = width;
			container.addChild(label);
			container.cacheAsBitmap = true;
		}	
		
		private function setShadow():void{
			var shadow:DropShadowFilter = new DropShadowFilter(); 
			shadow.distance = 1; 
			shadow.angle = 25;
			shadow.alpha = .5;		
			this.filters = [shadow];		
		}
		
		
	}
}