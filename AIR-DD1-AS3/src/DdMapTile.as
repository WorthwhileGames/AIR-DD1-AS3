package
{
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdMapTile
	{
		private var __type:int;
		private var __visible:Boolean;
		
		public function DdMapTile(_type:int)
		{
			__type = _type;
			__visible = false;
		}

		public function get type():int
		{
			return __type;
		}

		public function set type(value:int):void
		{
			__type = value;
		}

		public function get visible():Boolean
		{
			return __visible;
		}

		public function set visible(value:Boolean):void
		{
			__visible = value;
		}


	}
}