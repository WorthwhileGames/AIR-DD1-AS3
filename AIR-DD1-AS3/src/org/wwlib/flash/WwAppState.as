package org.wwlib.flash
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.AccelerometerEvent;
	
	import avmplus.getQualifiedClassName;
	
	import org.wwlib.utils.WwDebug;
	import org.wwlib.utils.WwDeviceInfo;
	
	//import starling.display.Sprite;
	
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class WwAppState extends flash.display.Sprite
	{
		protected var __debug:WwDebug;
		protected var __deviceInfo:WwDeviceInfo;
		protected var __app:flash.display.Sprite;
		protected var __appStage:MovieClip;
		
		protected var __lableList:Array;
		protected var __currentLabel:String;
		protected var __defaultLabel:String = "a";
		protected var __currentLabelIndex:int;


		
		public function WwAppState()
		{
			__debug = WwDebug.instance;
			__deviceInfo = WwDeviceInfo.instance;
		}
		
		public function init(_app:flash.display.Sprite, _stage:MovieClip):void
		{
			__app = _app;
			__appStage = _stage;
		}
		
		public function enterFrameUpdateHandler(frame_time:int, total_seconds:Number):void
		{
		}
		
		public function accelerometerUpdateHandler(event:AccelerometerEvent):void
		{
		}
		
		public function setupTimelineCallbacks(_timeline:MovieClip):void
		{
			_timeline.label_callback = labelCallback;
			_timeline.anim_callback = animCallback;
		}
		
		public function removeTimelineCallbacks(_timeline:MovieClip):void
		{
			_timeline.label_callback = null;
			_timeline.anim_callback = null;
		}
		
		
		public function labelCallback(label_list:Array):void
		{
			__debug.msg(getQualifiedClassName(this) + ": labelCallback: " + label_list, "1");
			__currentLabelIndex = 0;
			__currentLabel = "";
			if ((label_list != null) && (label_list.length > 0))
			{
				__lableList = label_list;
				__currentLabel = __lableList[__currentLabelIndex];
			}
			else
			{
				__lableList = [];
			}
		}
		
		public function getNextLabel():Boolean
		{
			__currentLabelIndex++;
			if (__currentLabelIndex < __lableList.length)
			{
				__currentLabel = __lableList[__currentLabelIndex];
				if ((__currentLabel == null) || (__currentLabel == ""))
				{
					__currentLabel = __defaultLabel;
				}
				return true;
			}
			else
			{
				__currentLabelIndex = 0;
				__currentLabel = __lableList[__currentLabelIndex];
				return false;
			}
			
		}
		
		public function animCallback(anim_state:String):void
		{
			__debug.msg(getQualifiedClassName(this) + ": animCallback: " + anim_state, "1");
			switch (anim_state)
			{
				case "EOL": //End Of Label
					//__debug.msg("  EOL", "1");
					break;
				case "EOS": //End Of Scene
					//__debug.msg("  EOS", "1");
					break;
				default:
					break;
			}
		}
		
		public function reset():void
		{
		}
		
		public function show():void
		{
		}
		
		public function hide():void
		{
		}
		
		public function suspend():void
		{
		}
		
		public function save(id:String):void
		{
		}
		
		public function load(id:String):void
		{
		}
		
		//public function get starlingRoot():starling.display.Sprite
		//{
		//	return null;
		//}
		
		public function dispose():void
		{
			__lableList = null;
		}
	}
}