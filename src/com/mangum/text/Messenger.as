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
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	public class Messenger extends Sprite {
				
		[Embed(source="/../assets/fonts/UniversLT57Condensed.ttf", fontFamily="Univers57Cond",embedAsCFF="false")] 		
//		private var myFont:Font = new Helvetica();
		
		public var bar:String;
		
		private var _label:TextField;
		private var _labelText:String; 
		private var format:TextFormat;
		private var container:MovieClip =  new MovieClip();
		
		public function Messenger(msg:String,width:Number) {
			addChild(container);
			_labelText = msg;
			configureLabel(width);
			setLabel(_labelText);
			setShadow();			
		}
		
		/* PUBLIC METHODS */
		
		public function setLabel(str:String):void {
			_label.text = str;
		}	
		
		public function setSize(size:Number):void {
			format.size = size;
			_label.defaultTextFormat = format;
		}

		
		/* PRIVATE METHODS */
		private function configureLabel(width:Number):void {
			_label = new TextField();
			_label.embedFonts = true;
			_label.antiAliasType = AntiAliasType.ADVANCED;
			_label.autoSize = TextFieldAutoSize.LEFT;
			_label.background = false;
			_label.border = false;
			_label.selectable = false;
	
			format = new TextFormat();
//			format.font = myFont.fontName;
			format.font = "Univers57Cond";
			format.color = 0xFFFFFF;
			format.size = 10;
			format.bold = true;
			format.underline = false;
			format.kerning = true;
			format.letterSpacing = 0;			

			_label.defaultTextFormat = format;
			_label.wordWrap = true;
			_label.width = width;
			container.addChild(_label);
			container.cacheAsBitmap = true;
		}	
		
		private function setShadow():void{
			var shadow:DropShadowFilter = new DropShadowFilter(); 
			shadow.distance = 1; 
			shadow.angle = 25;
			shadow.alpha = .5;		
			this.filters = [shadow];		
		}
		
		/* GETTER SETTERS */
		
		
		
		
		
		
	}
}