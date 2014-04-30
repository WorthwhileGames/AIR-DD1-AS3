package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.AccelerometerEvent;
	import flash.events.KeyboardEvent;
	
	import org.wwlib.flash.WwAppBG;
	import org.wwlib.flash.WwAppState;
	import org.wwlib.utils.WwDebug;
	import org.wwlib.utils.WwDeviceInfo;
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdAppStateManager
	{
		public static const STATE_LOGOS:String = "LOGOS";
		public static const STATE_MAIN_LOGIN:String = "MAIN_LOGIN";
		public static const STATE_MAIN_MENU:String = "MAIN_MENU";
		public static const STATE_MAIN:String = "MAIN";
		public static const STATE_COLORING:String = "COLORING";
		
		private static var __instance:DdAppStateManager;
		private var __debug:WwDebug;
		private var __app:flash.display.Sprite;
		private var __appStage:MovieClip;
		
		private var __frameTime:int;
		
		private var __currentState:WwAppState;

		/**
		 *   Construct the QcAppStateManager. This class is a Singleton, so it should not
		 *   be directly instantiated. Instead, call the static "instance" getter
		 *   to get an instance of it.
		 *   @param enforcer A SingletonEnforcer specifically designed to be
		 *                   impossible to pass by outside classes.
		 */
		public function DdAppStateManager(enforcer:SingletonEnforcer)
		{
			if (!(enforcer is SingletonEnforcer))
			{
				throw new ArgumentError("QcAppStateManager cannot be directly instantiated!");
			}
			
			__debug = WwDebug.instance;
			__frameTime = 0;			
		}
		
		/**
		 *   Initialize the singleton if it has not already been initialized
		 *   @return The singleton instance
		 */
		public static function init(_app:flash.display.Sprite, _stage:MovieClip): DdAppStateManager
		{
			if (__instance == null)
			{
				__instance = new DdAppStateManager(new SingletonEnforcer());
			}
			
			__instance.__app = _app;
			__instance.__appStage = _stage;
			__instance.setup();
			
			return __instance;
		}
		
		/**
		 *   Get the singleton instance
		 *   @return The singleton instance or null if it has not yet been
		 *           initialized
		 */
		public static function get instance(): DdAppStateManager
		{
			return __instance;
		}
		
		private function setup():void
		{
			gotoState(DdAppStateManager.STATE_LOGOS);
		}
		
		public function onKeyDown(event:KeyboardEvent):void
		{
			if (__currentState)
			{
				__currentState.onKeyDown(event);
			}
		}

		public function enterFrameUpdateHandler(frame_time:int, total_seconds:Number):void
		{
			if (__currentState)
			{
				__frameTime = frame_time;
				__currentState.enterFrameUpdateHandler(__frameTime, total_seconds);
			}
		}
		
		public function accelerometerUpdateHandler(event:AccelerometerEvent):void
		{
			if (__currentState)
			{
				__currentState.accelerometerUpdateHandler(event);
			}
		}
		
		public function gotoState(_state:String):void
		{
			//__debug.clear();
			__debug.msg("nextState: " + _state, "1");
			var app_state:WwAppState;
			
			disposeCurrentState();
			
			switch(_state)
			{
				case STATE_LOGOS:
					app_state =  new DdAppStateLogos();
					app_state.init(__app, __appStage);
					currentState = app_state;
					break;
				case STATE_MAIN:
					app_state =  new DdAppStateMain();
					app_state.init(__app, __appStage);
					currentState = app_state;
					break;

				default:
				{
					break;
				}
			}
		}
		
		private function disposeCurrentState():void
		{
			if (__currentState)
			{
				__appStage.removeChild(__currentState);
				__currentState.dispose();
				__currentState = null;
			}
		}
		
		public function set currentState(_state:WwAppState):void
		{			
			disposeCurrentState();
			
			__currentState = _state;
			if (__currentState)
			{
				__appStage.addChild(__currentState);
			}
		}
	}
}

/** A class that is here specifically to stop public instantiation of the
 *   WwSceneManager singleton. It is inaccessible by classes outside this file. */
class SingletonEnforcer{}