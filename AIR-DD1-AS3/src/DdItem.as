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
		private var __range:Number;
		private var __hitMultiplier:Number;
		private var __criticalHitMultiplier:Number;
		
		public function DdItem(name:String, price:int, range:Number, hit_multiplier:Number, critical_hit_multiplier:Number)
		{
			__name = name;
			__price = price;
			__range = range;
			__hitMultiplier = hit_multiplier;
			__criticalHitMultiplier = critical_hit_multiplier;
		}

		public function get name():String
		{
			return __name;
		}

		public function get price():int
		{
			return __price;
		}

		public function get range():Number
		{
			return __range;
		}


	}
}