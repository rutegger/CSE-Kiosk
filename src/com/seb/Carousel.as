// Author : Seb Lee-Delisle
// Blog : sebleedelisle.com

package com.seb{
	import flash.events.Event;
	
	import org.papervision3d.core.effects.view.ReflectionView;
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	[SWF (width="800", height="600", backgroundColor="0x111111", frameRate="30")]
	
	// create planes in a carousel
	
	public class Carousel extends ReflectionView
	{
		
		public var numPlanes : int = 4; 
		public var planes : Array = new Array(); 
		public var planeContainer : DisplayObject3D; 
		
		public function Carousel(){
			super(800, 600, true, true); 
			
			planeContainer = new DisplayObject3D(); 
			
			scene.addChild(planeContainer); 
			
			makePlanes(); 
			
			camera.z = -900; 
			camera.y = 300; 
			
			surfaceHeight = -100; 
			
			addEventListener(Event.ENTER_FRAME, enterFrame); 
			
		}
		
		public function makePlanes() : void{
			
			var plane : ReflectivePlane; 
			
			for(var i : int = 0 ; i< numPlanes; i++){
				
				plane = new ReflectivePlane(); 
				//				plane.addEventListener(InteractiveScene3DEvent.OBJECT_OVER, planeOver); 
				//				plane.addEventListener(InteractiveScene3DEvent.OBJECT_OUT, planeOut); 
				plane.addEventListener(InteractiveScene3DEvent.OBJECT_CLICK, planeClick); 
				
				plane.yaw((360/numPlanes)*i);			
				plane.moveForward(600);				
				planeContainer.addChild(plane); 		
				planes.push(plane); 
				
			}
			
		}
		
		public function updatePlanes() : void{
			for each(var plane:ReflectivePlane in planes){
				plane.update();
			}
		}
		
		//		public function planeOver(e: InteractiveScene3DEvent) : void{
		//			trace("MOUSE OVER"); 	
		//			var refPlane : ReflectivePlane = e.displayObject3D as ReflectivePlane; 
		//			refPlane.over(); 	
		//		}
		//		
		//		public function planeOut(e: InteractiveScene3DEvent) : void{
		//			trace("MOUSE OUT"); 
		//			var refPlane : ReflectivePlane = e.displayObject3D as ReflectivePlane; 
		//			refPlane.out(); 
		//		}
		
		public function planeClick(e: InteractiveScene3DEvent) : void{
			trace("MOUSE CLICK"); 
			var refPlane : ReflectivePlane = e.displayObject3D as ReflectivePlane; 
			refPlane.click(); 
		}	
		
		public function enterFrame(e:Event) : void{			
			updatePlanes(); 	
			//			planeContainer.yaw(viewport.containerSprite.mouseX*0.005);
			planeContainer.yaw(1);
			singleRender(); 	
		}
		
	}
}
