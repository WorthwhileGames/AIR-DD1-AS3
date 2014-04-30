package
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdItems
	{
		private var __items:Array;
		
		public function DdItems()
		{
			__items = new Array(15);
			
			var _item:DdItem;
			
			_item = new DdItem("SWORD", 10);
			__items[0] = _item;
			_item = new DdItem("2-H-SWORD", 15);
			__items[1] = _item;
			_item = new DdItem("DAGGER", 3);
			__items[2] = _item;
			_item = new DdItem("MACE", 5);
			__items[3] = _item;
			_item = new DdItem("SPEAR", 2);
			__items[4] = _item;
			_item = new DdItem("BOW", 25);
			__items[5] = _item;
			_item = new DdItem("ARROWS", 2);
			__items[6] = _item;
			_item = new DdItem("LEATHER MAIL", 15);
			__items[7] = _item;
			_item = new DdItem("CHAIN MAIL", 30);
			__items[8] = _item;
			_item = new DdItem("TLTE MAIL", 50);
			__items[9] = _item;
			_item = new DdItem("ROPE", 1);
			__items[10] = _item;
			_item = new DdItem("SPIKES", 1);
			__items[11] = _item;
			_item = new DdItem("FLASK OF OIL", 2);
			__items[12] = _item;
			_item = new DdItem("SILVER CROSS", 25);
			__items[13] = _item;
			_item = new DdItem("SPARE FOOD", 5);
			__items[14] = _item;
		}
	
		public function item(index:int):DdItem
		{
			return __items[index];
		}
		
		public function itemList():String
		{
			var _list:String = "";
			
			for (var i:int=0; i<15; i++)
			{
				var item:DdItem = __items[i];
				_list += (i+1) + "\t" + item.name + "\t" + item.price + "\n";
			}
			
			return _list
		}
	}
}