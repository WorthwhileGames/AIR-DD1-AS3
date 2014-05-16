package
{
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdSpell
	{
		public var id:int;
		public var name:String;
		public var cost:int;
		
		
		public function DdSpell(_id:int, _name:String, _cost:int)
		{
			id = _id;
			name = _name;
			cost = _cost;
		}
	}
}