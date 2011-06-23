package com.mangum.text {
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Messenger extends Sprite {
				
		[Embed(source="/../assets/fonts/UniversLT45Light.ttf", fontFamily="UniversLT45Light",fontWeight="normal", embedAsCFF="false")] 
		private static var Univers:Class;
		private var UniversFont:Font = new Univers();
		
		[Embed(source="/../assets/fonts/UniversCE65Bold.ttf", fontFamily="UniversCE65Bold",fontWeight="bold")] 
		private static var UniversBold:Class;
		private var UniversBoldFont:Font = new UniversBold();
			
		public var bar:String;
		
		private var _label:TextField;
		private var _labelText:String; 
		private var _color:Number; 
		private var _size:Number; 
		private var format:TextFormat;
		private var container:MovieClip =  new MovieClip();
		private var _bold:Boolean = false;
		private var _uppercase:Boolean = false;
		
		
		public function Messenger(msg:String,width:Number,color:Number=0x000000,size:Number=20,bold:Boolean=false) {
			
			_bold = bold;
			addChild(container);
			_labelText = msg;
			_color = color;
			_size = size;
			_bold = bold;
			configureLabel(width,color,size);
			setLabel(_labelText);
//			setShadow();			
		}
		
		/* PUBLIC METHODS */
		
		public function setLabel(str:String):void {
			if(_uppercase){
				var newStr:String = str.toUpperCase();
				_label.htmlText = newStr;
			} else {
				_label.htmlText = str;
			}
		}	
		
		public function setAttribute(attribute:String, value:Number):void {
			format[attribute] = value;
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
			if(!_bold){
				format.font = UniversFont.fontName;
			} else {
				format.font = UniversBoldFont.fontName;
			}			
			format.color = color;
			format.size = size;
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
			shadow.distance = .5; 
			shadow.angle = 25;
			shadow.alpha = .5;		
			this.filters = [shadow];		
		}
		
		/* GETTER SETTERS */
		public function get h():Number {
			return _label.height;
		}
		
		public function get lines():Number {
			return _label.numLines;
		}
		
		public function get uppercase():Boolean {
			return _uppercase;
		}
		
		public function set uppercase(val:Boolean):void {
			_uppercase = val;
		}
	
	}
}