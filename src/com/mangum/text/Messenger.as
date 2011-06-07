package com.mangum.text {
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Messenger extends Sprite {
				
		[Embed(source="/../assets/fonts/UniversLT57Condensed.ttf", fontFamily="Univers57Cond",embedAsCFF="false")] 		
		
		public var bar:String;
		
		private var _label:TextField;
		private var _labelText:String; 
		private var _color:Number; 
		private var _size:Number; 
		private var format:TextFormat;
		private var container:MovieClip =  new MovieClip();
		
		public function Messenger(msg:String,width:Number,color:Number=0x000000,size:Number=20) {
			addChild(container);
			_labelText = msg;
			_color = color;
			_size = size;
			configureLabel(width,color,size);
			setLabel(_labelText);
//			setShadow();			
		}
		
		/* PUBLIC METHODS */
		
		public function setLabel(str:String):void {
//			trace("setLabel("+str+")");
			_label.htmlText = str;
		}	
		
		public function setAttribute(attribute:String, value:Number):void {
			//trace("setAttribute("+setAttribute+", "+value+")");
			format[attribute] = value;

			_label.defaultTextFormat = format;
		}

		
		/* PRIVATE METHODS */
		private function configureLabel(width:Number,color:Number,size:Number):void {
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
			format.color = color;
			format.size = size;
			format.bold = false;
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
			shadow.distance = .5; 
			shadow.angle = 25;
			shadow.alpha = .5;		
			this.filters = [shadow];		
		}
		
		/* GETTER SETTERS */
		
	
	}
}