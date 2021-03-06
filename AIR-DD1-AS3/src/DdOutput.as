package
{
	import flash.text.TextField;
	
	import org.wwlib.flash.WwAudioManager;
	import org.wwlib.utils.WwDebug;
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdOutput
	{
		public static var LINE_HEIGHT:int = 16;
		
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
					var _char:String = __outputArray[__outputIndex];
					
					if (_char == "\n")
					{
						__outputTextfield.text += _char;
						WwAudioManager.playSound("return");
						__outputTextfield.y -= LINE_HEIGHT;
						__outputTextfield.height += LINE_HEIGHT;
					}
					else if (_char.length > 1)
					{
						//WwDebug.instance.msg(" printing: " + _char);
						if (__outputIndex <= __outputArray.length)
						{
							__outputTextfield.text += "\n" + _char;
						}
						else
						{
							__outputTextfield.text += _char;
						}
						WwAudioManager.playSound("return");
						__outputTextfield.y -= LINE_HEIGHT;
						__outputTextfield.height += LINE_HEIGHT;
					}
					else
					{
						__outputTextfield.text += _char;
						WwAudioManager.playSound("key");
					}
					__outputIndex++;
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
				
				if (new_msg == "\n")
				{
					__outputArray = ["\n"];
					//WwDebug.instance.msg(" printing empty line: " + __outputArray);
				}
				else
				{
					__outputArray = new_msg.split("\n"); //new_msg.split("");
				}
				__printing = true;
			}
		}
		
		public function isPendingOutput():Boolean
		{
			return __pendingOutput.length > 0;
		}

		public function get printing():Boolean
		{
			return __printing;
		}


	}
}