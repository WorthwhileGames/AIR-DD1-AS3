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
			
			//name:String, price:int, range:Number, hit_multiplier:Number, critical_hit_multiplier:Number
			_item = new DdItem("SWORD", 10, 0, 0, 0);
			__items[0] = _item;
			_item = new DdItem("2-H-SWORD", 15, 0, 0, 0);
			__items[1] = _item;
			_item = new DdItem("DAGGER", 3, 0, 0, 0);
			__items[2] = _item;
			_item = new DdItem("MACE", 5, 0, 0, 0);
			__items[3] = _item;
			_item = new DdItem("SPEAR", 2, 10, 3/7, 5/11);
			__items[4] = _item;
			_item = new DdItem("BOW", 25, 15, 3/7, 5/11);
			__items[5] = _item;
			_item = new DdItem("ARROWS", 2, 1.5, 1/7, 1/5);
			__items[6] = _item;
			_item = new DdItem("LEATHER MAIL", 15, 4, 1/10, 1/8);
			__items[7] = _item;
			_item = new DdItem("CHAIN MAIL", 30, 4, 1/7, 1/6);
			__items[8] = _item;
			_item = new DdItem("TLTE MAIL", 50, 3, 1/8, 1/5);
			__items[9] = _item;
			_item = new DdItem("ROPE", 1, 5, 1/9, 1/6);
			__items[10] = _item;
			_item = new DdItem("SPIKES", 1, 8, 1/9, 1/4);
			__items[11] = _item;
			_item = new DdItem("FLASK OF OIL", 2, 6, 1/3, 2/3);
			__items[12] = _item;
			_item = new DdItem("SILVER CROSS", 25, 1.5, 1/3, 1/2);
			__items[13] = _item;
			_item = new DdItem("SPARE FOOD", 5, 0, 0, 0);
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