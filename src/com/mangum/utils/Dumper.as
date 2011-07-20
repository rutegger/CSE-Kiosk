package com.mangum.utils{
	
	
	public class Dumper{
		public function Dumper(){trace("Dumper");
		}
		
		public static function dumpObject(obj:Object):void{
			for (var i in obj){
				trace(i+": "+obj[i])
			}
			trace("---------------");
		}
	}
}