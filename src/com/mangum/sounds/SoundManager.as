package com.mangum.sounds{
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class SoundManager{
		
		[Embed(source='/../assets/sounds/beep1.mp3')]	 
		private var MySound:Class; 		 
		private var sound:Sound; 
			
		public function SoundManager(){}
		
		public function beep():void{	
			sound = (new MySound) as Sound; 			     
			sound.play(); 			     
		}
	}
}