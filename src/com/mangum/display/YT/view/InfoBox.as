package com.mangum.display.YT.view{
	
	import flash.display.Sprite;
	import com.mangum.text.Messenger;
	import com.mangum.text.StringFX;
	
	
	public class InfoBox extends Sprite{
		
		private var titleTxt:Messenger;
		private var descriptionTxt:Messenger 
		
		public function InfoBox(){			
			createMessageBox();
			
			createText();

		}
		
		private function createMessageBox():void{
			var descriptionBox:Sprite = new Box();
			descriptionBox.x = -15;
			descriptionBox.y = -20;
			descriptionBox.width = 515;
			descriptionBox.height = 200;
			
			var descriptionBoxShadow:Sprite = new BoxShadow();
			descriptionBoxShadow.x = descriptionBox.x + 5;
			descriptionBoxShadow.y = descriptionBox.y + 5;
			descriptionBoxShadow.width = descriptionBox.width;
			descriptionBoxShadow.height = descriptionBox.height;
			
			addChild(descriptionBoxShadow);
			addChild(descriptionBox);	
			
		}
		
		private function createText():void{
			// title
			titleTxt = new Messenger("--",450,0xE36F1E,23,true,false);	
			titleTxt.uppercase = true;
//			titleTxt.setLabel(StringFX.truncate(title,35,"..."));
			titleTxt.x = 0;
			titleTxt.y = 0;
			titleTxt.setAttribute("leading", -5);
			addChild(titleTxt);	
			
			
			// description
			descriptionTxt = new Messenger("---",450,0x717073,23,false,false);	
			descriptionTxt.uppercase = false;
			descriptionTxt.x = 0;
			descriptionTxt.setAttribute("leading", -5);
			addChild(descriptionTxt);	
		}
		
		public function updateText(title:String, description:String):void{
			titleTxt.setLabel(title);
			descriptionTxt.y = titleTxt.y + titleTxt.h + 10;
			descriptionTxt.setLabel(StringFX.truncate(description,145,"..."));
		}
		
		
	}
}