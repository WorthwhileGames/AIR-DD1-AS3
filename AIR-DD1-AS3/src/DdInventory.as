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
		
		public function reset():void
		{
			__inventory = new Array(16);
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
				if (item.id != 0)
				{
					_list += i + "\t" + item.name + "\n";
				}
			}
			
			return _list;
		}
		
		public function getItemCount():int
		{
			return __inventory.length;
		}
		
		public function getItemByID(_id:int):DdItem
		{
			var item:DdItem = null;
			
			outer: for (var i:int=0; i<__inventory.length; i++)
			{
				item = __inventory[i];
				if (item.id == _id)
				{
					break outer;
				}
			}
			
			return item;
		}
		
		public function hasItem(id:int):Boolean
		{
			var result:Boolean = false;
			
			for (var i:int=0; i<__inventory.length; i++)
			{
				var item:DdItem = __inventory[i];
				if (item.id == id) result = true;
			}
			
			return result;
		}
		
		public function dropItem(item:DdItem):void
		{
			var item_index:int = __inventory.indexOf(item);
			
			if (item_index != -1)
			{
				__inventory.splice(item_index, 1);
			}
		}
	}
}