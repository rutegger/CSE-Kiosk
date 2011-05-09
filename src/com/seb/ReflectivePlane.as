package com.seb{
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.objects.primitives.Plane;
	
	public class ReflectivePlane extends Plane
	{
		
		public var currentPitch : Number = 0 ; 
		public var targetPitch : Number = 0; 
		//public var pitchVel : Number = 0; 
		
		public var resetCounter : Number = -1; 
		
		public function ReflectivePlane(){
			
			var mat:ColorMaterial = new ColorMaterial(0x770000,1,true);
			mat.doubleSided = true; 
			mat.interactive = true; 
			
			super(mat,100,100,1,1);
		}
		
		public function update() : void{
			
			if(resetCounter>0){
				resetCounter--; 
			} 
			else if (resetCounter==0){
				resetFlip(); 
				resetCounter = -1; 
			}
			
			//pitchVel*= 0.7; 
			
			if(currentPitch!=targetPitch){
				var diff : Number = ((targetPitch-currentPitch)*0.1);
				currentPitch+=diff; 	
			}
			
			localRotationX = currentPitch; 
			
		}
		
		public function over() :void{		
			material.fillColor = 0xffffff; 	
			targetPitch = 180; 	
		}
		
		public function out() : void{
			resetCounter = 100; 	
		}
		
		public function click() : void{
			material.fillColor = 0x0000ff; 		
		}
		
		public function resetFlip() : void{
			
			material.fillColor = 0x770000; 
			
			targetPitch = 0; 
			
		}
		
		
	}
}