package
{
	import org.wwlib.utils.WwDebug;
		
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdPendingAction
	{
		private var __debug:WwDebug;
		
		private var __label:String;
		private var __action:Function;
		private var __delay:int;
		
		
		public function DdPendingAction(label:String, func:Function, delay:int=0)
		{
			__debug = WwDebug.instance;
			
			__label = label;
			__action = func;
			__delay = delay;
			//__debug.msg("DdPendingAction: " + __label + ": func: " + __action, "2");
		}
		
		public function execute():Boolean
		{
			if (__delay > 0)
			{
				//__debug.msg("Action: " + __label + ": delay: " + __delay, "2");
				__delay--;
				return false;
			}
			else
			{
				//__debug.msg("Action: " + __label + ": executing: ");
				__action();
				__debug.msg("Action Done: " + __label, "2");
				return true;
			}
		}
		
		public function get label():String
		{
			return __label;
		}

		public function set label(value:String):void
		{
			__label = value;
		}

		public function get action():Function
		{
			return __action;
		}

		public function set action(value:Function):void
		{
			__action = value;
		}

		public function get delay():int
		{
			return __delay;
		}

		public function set delay(value:int):void
		{
			__delay = value;
		}
	}
}