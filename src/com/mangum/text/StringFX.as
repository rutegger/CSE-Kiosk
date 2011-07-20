package com.mangum.text{
	
	public class StringFX{
		
		public function StringFX(value:*=""){}
		
		public static function truncate(val:String,truncCount:uint,endMsg:String = ""):String{
			var str:String = (val.length <= truncCount) ? val : val.substr(0,truncCount)+endMsg;
			return str;
		}
	}
}