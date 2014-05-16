package
{
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdItem
	{
		public var id:int;
		public var name:String;
		public var price:int;
		public var range:Number;
		public var hitMultiplier:Number;
		public var criticalHitMultiplier:Number;
		
		public function DdItem(_id:int, _name:String, _price:int, _range:Number, hit_multiplier:Number, critical_hit_multiplier:Number)
		{
			id = _id;
			name = _name;
			price = _price;
			range = _range;
			hitMultiplier = hit_multiplier;
			criticalHitMultiplier = critical_hit_multiplier;
		}
	}
}