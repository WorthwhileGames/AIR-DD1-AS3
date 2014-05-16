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
		
		public static var ITEM_ID_NA:int = 0;
		public static var ITEM_ID_SWORD:int = 1;
		public static var ITEM_ID_2_H_SWORD:int = 2;
		public static var ITEM_ID_DAGGER:int = 3;
		public static var ITEM_ID_MACE:int = 4;
		public static var ITEM_ID_SPEAR:int = 5;
		public static var ITEM_ID_BOW:int = 6;
		public static var ITEM_ID_ARROWS:int = 7;
		public static var ITEM_ID_LEATHER_MAIL:int = 8;
		public static var ITEM_ID_CHAIN_MAIL:int = 9;
		public static var ITEM_ID_PLATE_MAIL:int = 10;
		public static var ITEM_ID_ROPE:int = 11;
		public static var ITEM_ID_SPIKES:int = 12;
		public static var ITEM_ID_FLASK_OF_OIL:int = 13;
		public static var ITEM_ID_SILVER_CROSS:int = 14;
		public static var ITEM_ID_SPARE_FOOD:int = 15;
		
		public function DdItems()
		{
			__items = new Array(16);
			
			var _item:DdItem;
			
			//name:String, price:int, range:Number, hit_multiplier:Number, critical_hit_multiplier:Number
			_item = new DdItem(0, "NA", 0, 0, 0, 0);
			__items[0] = _item;
			
			_item = new DdItem(1, "SWORD", 10, 0, 0, 0);
			__items[1] = _item;
			
			_item = new DdItem(2, "2-H-SWORD", 15, 0, 0, 0);
			__items[2] = _item;
			
			_item = new DdItem(3, "DAGGER", 3, 0, 0, 0);
			__items[3] = _item;
			
			_item = new DdItem(4, "MACE", 5, 0, 0, 0);
			__items[4] = _item;
			
			_item = new DdItem(5, "SPEAR", 2, 10, 3/7, 5/11);
			__items[5] = _item;
			
			_item = new DdItem(6, "BOW", 25, 15, 3/7, 5/11);
			__items[6] = _item;
			
			_item = new DdItem(7, "ARROWS", 2, 1.5, 1/7, 1/5);
			__items[7] = _item;
			
			_item = new DdItem(8, "LEATHER MAIL", 15, 4, 1/10, 1/8);
			__items[8] = _item;
			
			_item = new DdItem(9, "CHAIN MAIL", 30, 4, 1/7, 1/6);
			__items[9] = _item;
			
			_item = new DdItem(10, "PLATE MAIL", 50, 3, 1/8, 1/5);
			__items[10] = _item;
			
			_item = new DdItem(11, "ROPE", 1, 5, 1/9, 1/6);
			__items[11] = _item;
			
			_item = new DdItem(12, "SPIKES", 1, 8, 1/9, 1/4);
			__items[12] = _item;
			
			_item = new DdItem(13, "FLASK OF OIL", 2, 6, 1/3, 2/3);
			__items[13] = _item;
			
			_item = new DdItem(14, "SILVER CROSS", 25, 1.5, 1/3, 1/2);
			__items[14] = _item;
			
			_item = new DdItem(15, "SPARE FOOD", 5, 0, 0, 0);
			__items[15] = _item;
		}
	
		public function item(index:int):DdItem
		{
			return __items[index];
		}
		
		public function itemList():String
		{
			var _list:String = "";
			
			for (var i:int=1; i<=15; i++)
			{
				var item:DdItem = __items[i];
				_list += (i) + "\t" + item.name + "\t" + item.price + "\n";
			}
			
			return _list
		}
	}
}