package
{
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdItem
	{
		private var __name:String;
		private var __price:int;
		
		public function DdItem(name:String, price:int)
		{
			__name = name;
			__price = price;
		}

		public function get name():String
		{
			return __name;
		}

		public function get price():int
		{
			return __price;
		}


	}
}