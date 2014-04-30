package
{
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdInventory
	{
		private var __inventory:Array;
		
		public function DdInventory()
		{
			__inventory = new Array();
		}
		
		public function addItem(item:DdItem):void
		{
			__inventory.push(item);
		}
		
		public function inventoryList():String
		{
			var _list:String = "EQUIMPENT:\n";
			
			for (var i:int=0; i<__inventory.length; i++)
			{
				var item:DdItem = __inventory[i];
				_list += (i + 1) + "\t" + item.name + "\n";
			}
			
			return _list;
		}
	}
}