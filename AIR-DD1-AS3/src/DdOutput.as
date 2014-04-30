package
{
	import flash.text.TextField;
	
	import org.wwlib.flash.WwAudioManager;
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdOutput
	{
		private var __outputTextfield:TextField;
		private var __pendingOutput:Vector.<String>;
		private var __printing:Boolean;
		
		
		private var __outputArray:Array;
		private var __outputIndex:int;
		
		public function DdOutput(output_textfield:TextField)
		{
			__outputTextfield = output_textfield;
			__pendingOutput = new Vector.<String>;
			__printing = false;
		}

		public function print(msg:String, carriage_return:Boolean=true):void
		{
			if (carriage_return)
			{
				msg += "\n";
			}
			__pendingOutput.push(msg);

		}
		
		public function output():void
		{
			if (__printing)
			{
				if (__outputIndex < __outputArray.length)
				{
					var _char:String = __outputArray[__outputIndex++];
					__outputTextfield.text += _char;
					if (_char == "\n")
					{
						WwAudioManager.playSound("click");
					}
					else
					{
						WwAudioManager.playSound("click_fast");
					}
				}
				else
				{
					__printing = false;
				}
			}
			else if (isPendingOutput())
			{
				var new_msg:String = __pendingOutput.shift();
				__outputIndex = 0;
				__outputArray = new_msg.split("");
				__printing = true;
			}
		}
		
		public function isPendingOutput():Boolean
		{
			return __pendingOutput.length > 0;
		}

	}
}