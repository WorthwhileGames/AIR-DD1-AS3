package
{
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdMapTile
	{
		public var type:int;
		public var visible:Boolean;
		
		public function DdMapTile(_type:int)
		{
			type = _type;
			visible = false;
		}
	}
}