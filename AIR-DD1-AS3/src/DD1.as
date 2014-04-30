package
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.sensors.Accelerometer;
	import flash.utils.getTimer;
	
	import org.wwlib.flash.WwAppBG;
	import org.wwlib.flash.WwAudioManager;
	import org.wwlib.utils.WwDebug;
	import org.wwlib.utils.WwDeviceInfo;
	
	
	/**
	 * ...
	 * @author Richard Garriot
	 * @author (AS3) Andrew Rapo
	 * @copyright 1977-2014 Richard Garriott
	 * 	REM DND-1
		REM 1500 lines
		REM (C)1977-2014 RICHARD GARRIOTT
		REM 79/02/28. 19.27.34.
		PROGRAM   DND1
		TRANSCRIBED and RESTRUCTURED BY DEJAY CLAYTON 2014
	 */
	
	[SWF(backgroundColor="#FFFFFF", width="1024", height="768", frameRate="59")]
	public class DD1 extends Sprite
	{
		private var __debug:WwDebug;
		private var __deviceInfo:WwDeviceInfo;
		private var __appFlashStage:MovieClip;
		private var __appFlashAlertsStage:MovieClip;
		private var __appDebugStage:MovieClip;
		
		private var __accelerometer:Accelerometer;
		private var __accelZ:Number;
		private var __activateDebug:Boolean = false;
		
		private var __prevTime:int;
		private var __frameTime:int;
		private var __totalSeconds:Number;
		private var __frameRate:Number;
		
		/** Embedded the default app image for immediate display. */
		[Embed(source="/Default-Landscape.png")]
		private var __defaultAppImageClass:Class;
		private var __defaultAppBitmap:Bitmap;
		
		private var __appStateManager:DdAppStateManager;
		
		public static var appStage:Stage;
		
		public function DD1()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			appStage = stage;
			appStage.color = 0xFFFFFF;
			appStage.scaleMode = StageScaleMode.NO_SCALE;
			appStage.align = StageAlign.TOP_LEFT;
			
			__appFlashStage = new MovieClip();
			__appFlashAlertsStage = new MovieClip();
			__appDebugStage = new MovieClip();
			
			stage.addChild(__appFlashStage);
			stage.addChild(__appFlashAlertsStage);
			stage.addChild(__appDebugStage);
			
			__defaultAppBitmap = new __defaultAppImageClass() as Bitmap;
			WwAppBG.init(__appFlashStage, __defaultAppBitmap);
			WwAppBG.show();
			
			__deviceInfo = WwDeviceInfo.init();
			WwDebug.init(__appDebugStage);
			__debug = WwDebug.instance;
			
			
			__debug.msg("os: " + __deviceInfo.os,"3");
			__debug.msg("devStr: " + __deviceInfo.devString,"3");
			__debug.msg("device: " + __deviceInfo.device,"3");
			__debug.msg("bgX: " + __deviceInfo.stageX,"3");
			__debug.msg("bgY: " + __deviceInfo.stageY,"3");
			__debug.msg("bgWidth: " + __deviceInfo.stageWidth,"3");
			__debug.msg("bgHeight: " + __deviceInfo.stageHeight,"3");
			__debug.msg("canvasX: " + __deviceInfo.canvasX,"3");
			__debug.msg("canvasY: " + __deviceInfo.canvasY,"3");
			__debug.msg("resolutionX: " + __deviceInfo.resolutionX,"3");
			__debug.msg("resolutionY: " + __deviceInfo.resolutionY,"3");
			__debug.msg("isDebugger: " + __deviceInfo.isDebugger,"3");
			__debug.msg("screenDPI: " + __deviceInfo.screenDPI,"3");			
			__debug.show = true;
			
			__appFlashStage.scaleX =  __deviceInfo.assetScaleFactor;
			__appFlashStage.scaleY =  __deviceInfo.assetScaleFactor;
			__appFlashStage.x =  __deviceInfo.stageX;
			__appFlashStage.y =  __deviceInfo.stageY;
			
			__appFlashAlertsStage.scaleX =  __deviceInfo.assetScaleFactor;
			__appFlashAlertsStage.scaleY =  __deviceInfo.assetScaleFactor;
			__appFlashAlertsStage.x =  __deviceInfo.stageX;
			__appFlashAlertsStage.y =  __deviceInfo.stageY;
			
			__appDebugStage.scaleX =  __deviceInfo.assetScaleFactor;
			__appDebugStage.scaleY =  __deviceInfo.assetScaleFactor;
			__appDebugStage.x =  __deviceInfo.stageX;
			__appDebugStage.y =  __deviceInfo.stageY;
			
			__debug.msg("assetScaleFactor: " + __deviceInfo.assetScaleFactor,"3");
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			// Audio Manager
			WwAudioManager.init();
			
			// App State Manager
			__appStateManager = DdAppStateManager.init(this, __appFlashStage);
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			//__debug.msg("onKeyDown: " + event.keyCode);
			if (__appStateManager)
			{
				__appStateManager.onKeyDown(event);
			}
		}
		
		private function onEnterFrame(event:Event):void
		{
			if (__appStateManager)
			{
				var total_milliseconds:int = getTimer();
				__frameTime = total_milliseconds - __prevTime;
				__prevTime = total_milliseconds;
				__frameRate = 1000.0 / __frameTime;
				__totalSeconds = total_milliseconds / 1000.0;
				__appStateManager.enterFrameUpdateHandler(__frameTime, __totalSeconds);
				WwDebug.fps = __frameRate;
			}
		}
	}
}