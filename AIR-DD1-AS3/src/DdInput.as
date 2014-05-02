package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import org.wwlib.flash.WwAudioManager;
	import org.wwlib.utils.WwDebug;
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdInput
	{
		private var __readBuffer:Vector.<String>;
		private var __inputString:String;
		private var __reading:Boolean;
		private var __complete:Boolean;
		private var __onCompleteHandler:Function;
		
		public function DdInput()
		{
			WwDebug.instance.msg("DdInput: ");
			reset();
		}
		
		private function reset():void
		{
			__readBuffer = new Vector.<String>;
			__inputString = "";
			__reading = false;
			__complete = false;
			//WwDebug.instance.msg("  reset: " + __reading);
		}
		
		public function read(on_complete_handler:Function):void
		{
			__onCompleteHandler = on_complete_handler;
			__readBuffer = new Vector.<String>;
			__readBuffer.push(" ");
			__reading = true;
			__complete = false;
			__inputString = "";
			//WwDebug.instance.msg("  read: " + __reading);
		}
		
		public function appendCharacter(_char:String):void
		{
			__readBuffer.push(_char);
			__inputString += _char;
			//WwDebug.instance.msg("  appendCharacter: " + __inputString);
		}
		
		public function onKeyDown(key_code:int):void
		{
			//WwDebug.instance.msg("  onKeyDown: " + key_code);
			var _char:String = String.fromCharCode(key_code);
			if (!__complete)
			{
				if (key_code == 13)
				{
					//__readBuffer.push("\n");
					__complete = true;
				}
				else
				{
					appendCharacter(_char);
				}
			}
		}

		public function getReadBufferAsString(clear_buffer:Boolean=true):String
		{
			var _char:String;
			var buffer_as_string:String = "";
			for each (_char in __readBuffer)
			{
				buffer_as_string += _char;
			}
			__readBuffer = new Vector.<String>;
			return buffer_as_string;
		}

		public function bufferIsNotEmpty():Boolean
		{
			return __readBuffer.length > 0;
		}
		
		public function set readBuffer(value:Vector.<String>):void
		{
			__readBuffer = value;
		}

		public function get reading():Boolean
		{
			return __reading;
		}

		public function complete():Boolean
		{
			return __complete;
		}
		
		public function onComplete():void
		{
			//WwDebug.instance.msg("  onComplete: " + __onCompleteHandler);
			if (__onCompleteHandler)
			{
				var args:Array = __inputString.split(" ");
				reset();
				__onCompleteHandler(args);
			}
		}

	}
}