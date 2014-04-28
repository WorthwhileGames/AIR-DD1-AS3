package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.AccelerometerEvent;
	
	import org.wwlib.dd1.UI_Logos;
	import org.wwlib.flash.WwAppState;
	
	//import starling.display.Sprite;
	
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdAppStateLogos extends WwAppState
	{
		private var __UI_Logos:UI_Logos;

		public function DdAppStateLogos()
		{
			super();
		}
		
		public override function init(_app:flash.display.Sprite, _stage:MovieClip):void
		{
			super.init(_app, _stage);
			__debug.msg("DdAppStateLogos: init: " + _app, "1");
			__UI_Logos = new UI_Logos();
			setupTimelineCallbacks(__UI_Logos);
			addChild(__UI_Logos);
			__UI_Logos.gotoAndPlay("a");
		}
		
		public override function enterFrameUpdateHandler(frame_time:int, total_seconds:Number):void
		{
		}
		
		public override function accelerometerUpdateHandler(event:AccelerometerEvent):void
		{
		}
		
		public override function animCallback(anim_state:String):void
		{
			super.animCallback(anim_state);
			switch (anim_state)
			{
				case "EOS":
					DdAppStateManager.instance.gotoState(DdAppStateManager.STATE_MAIN);
					break;
				default:
					break;
			}
		}

		
		public override function reset():void
		{
		}
		
		public override function show():void
		{
		}
		
		public override function hide():void
		{
		}
		
		public override function suspend():void
		{
		}
		
		public override function save(id:String):void
		{
		}
		
		public override function load(id:String):void
		{
		}
		
		//public override function get starlingRoot():starling.display.Sprite
		//{
		//	return null;
		//}
		
		public override function dispose():void
		{
			super.dispose();
			removeChild(__UI_Logos);
			__UI_Logos = null;
		}
		
	}
}