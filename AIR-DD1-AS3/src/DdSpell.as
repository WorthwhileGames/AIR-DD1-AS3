package
{
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdSpell
	{
		private var __name:String;
		private var __cost:int;
		
		
		public function DdSpell(name:String, cost:int)
		{
			__name = name;
			__cost = cost;
		}

		public function get name():String
		{
			return __name;
		}

		public function get cost():int
		{
			return __cost;
		}


	}
}