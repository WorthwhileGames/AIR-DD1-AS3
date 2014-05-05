package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.wwlib.utils.WwDebug;
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdKeyboard
	{
		public static const KEYBOARD_KEYS_LETTERS:Array = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
		public static const KEYBOARD_KEYS_NUMBERS:Array = ["1","2","3","4","5","6","7","8","9","0"];
		
		private var __mc:MovieClip;
		private var __handler:Function;
		
		public function DdKeyboard(_mc:MovieClip, _handler:Function)
		{
			__mc = _mc;
			__handler = _handler;
			
			WwDebug.instance.msg("Keyboard:init: __mc: " + __mc);
			
			if (__mc) init();
		}
		
		private function init():void
		{
			
			var btn_name:String;
			var btn_mc:MovieClip;
			var keys:Array = KEYBOARD_KEYS_LETTERS.concat(KEYBOARD_KEYS_NUMBERS);
			
			for (var i:int=0; i<keys.length; i++)
			{
				var key_char:String = keys[i];
				btn_name = "btn_tt_key_" + keys[i];
				WwDebug.instance.msg("Keyboard:init: btn_name: " + btn_name);
				btn_mc = __mc[btn_name];
				
				if (btn_mc)
				{
					btn_mc["tt_key_code"] =  key_char.charCodeAt(0);
				}
				
				setupKey(btn_mc);
			}
			
			btn_mc = __mc["btn_tt_key_return"];
			btn_mc["tt_key_code"] = 13;
			setupKey(btn_mc);
		}
		
		private function setupKey(_mc:MovieClip):void
		{
			if (_mc)
			{
				_mc.addEventListener(MouseEvent.MOUSE_DOWN, onKey);
			}
		}
		
		private function onKey(event:Event):void
		{
			var _mc:MovieClip = event.target as MovieClip;
			var key_code:int;
			
			if (_mc)
			{
				key_code = _mc["tt_key_code"];
				
				if (__handler)
				{
					__handler(key_code);
				}
			}
		}
	}
}