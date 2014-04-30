package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import org.wwlib.flash.WwAudioManager;
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdPrompt
	{
		private var __txtPrompt:TextField;
		private var __txtInput:TextField;
		private var __btnEnter:MovieClip;
		
		private var __callback:Function;

		
		public function DdPrompt(_prompt_field:TextField, _input_field:TextField, _enter_button:MovieClip)
		{
			__txtPrompt = _prompt_field;
			__txtInput = _input_field;
			__btnEnter = _enter_button;
			
			__txtInput.text = "";
			__txtPrompt.text = "";
			
			__btnEnter.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		public function prompt(_prompt:String, _callback:Function):void
		{
			__txtPrompt.text = _prompt;
			__callback = _callback;
		}
		
		private function onMouseDown(e:Event):void
		{
			WwAudioManager.playSound("click_fast");
			if (__callback) __callback(__txtInput.text);
		}
		
		public function set callback(value:Function):void
		{
			__callback = value;
		}
	}
}