package com.mangum.display{
	
	import flash.display.Sprite;
	import com.jumpeye.Events.FLASHEFFEvents;
//	import com.jumpeye.flashEff2.symbol.brightSquares.FESBrightSquares;
	import com.jumpeye.flashEff2.symbol.equalizer.FESEqualizer;
	import com.jumpeye.flashEff2.symbol.unpack.FESUnpack;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class FlashEffTester extends Sprite{
		
		[Embed (source="/../assets/background.jpg")]
		private var Test:Class; 
		private var myImage:Bitmap = new Test;
		
		private var myEffect:FlashEff2Flex;
		private var showEffect:FESUnpack;
		private var hideEffect:FESEqualizer;
		
		public function FlashEffTester(){
			addChild(myImage);
			
			// Once the image has been loaded, create the FlashEff2Flex
			// component instance, set it up and apply it on the image.
			myEffect = new FlashEff2Flex();
			
			// The hide transition starts 3 seconds after the show transition
			// has endded.
			//			myEffect.hideDelay = 3;
			myEffect.addEventListener(FLASHEFFEvents.TRANSITION_END, restartShowEffect);
			
			// Create the show and hide pattern instances. These instances will
			// actually execute the show and hide effects.
			showEffect = new FESUnpack();
			showEffect.stepsNumber = 8;
			showEffect.smooth = true;
			//			showEffect.squareWidth = 20
			//			showEffect.squareHeight = 20;
			showEffect.tweenDuration = 2;
			
			myEffect.showTransition = showEffect;
			hideEffect = new FESEqualizer();
			hideEffect.equalizerPercentage = 50;
			hideEffect.tweenDuration = 2;
			myEffect.hideTransition = hideEffect;
			
			// The FlashEff2Flex instance MUST be added to the display list
			// before setting the target object.
			addChild(myEffect);
			//			myEffect._targetInstanceName = "myImg";	// this returning error: FLASHEFF2 ERROR: Target must be a non-null DisplayObject.
			myEffect.target = myImage;
		}
		
		private function restartShowEffect(evt:FLASHEFFEvents):void {
			// Once the hide transition has endded, restart the show transition.
			var effectInstance:FlashEff2Flex = FlashEff2Flex(evt.target);
			if (effectInstance.currentTransitionType == "hide")
				effectInstance.show();
		}

	}
	
}