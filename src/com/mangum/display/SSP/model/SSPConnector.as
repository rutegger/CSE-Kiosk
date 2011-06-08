package com.mangum.display.SSP.model{
	
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	
	import com.mangum.utils.EmailErrorAlerter;
	
	import net.slideshowpro.slideshowpro.*;
	
	
	public class SSPConnector extends Sprite{
		
		private var _ssp:SlideShowPro;	
				
		public function SSPConnector(path:String):void {		
			init(path);
		}
		
		private function init(_path:String):void{
			_ssp = new SlideShowPro();	
			_ssp.setData(_path,"Director");
			_ssp.addEventListener(IOErrorEvent.IO_ERROR, onSSPIOerror);
			_ssp.addEventListener(SSPAlbumEvent.ALBUM_START, onAlbumStart);
		}
		
		/* EVENT HANDLERS */
		
		private function onAlbumStart(e:SSPAlbumEvent):void {
			dispatchEvent(new Event("onSSPLoaded"));
			_ssp.nextImage();
		}			
		
		private function onSSPIOerror(e:IOErrorEvent):void{
			trace("ssp error");
			// send alert email to kiosk admin
			var emailError:EmailErrorAlerter = new EmailErrorAlerter();
			emailError.notify("SSP Connection Error");
			dispatchEvent(new Event("onSSPError"));
		}
		
		
		/* GETTERS & SETTERS */		
	
		public function get ssp():SlideShowPro {
			return _ssp;
		}		
		
	}
	
}