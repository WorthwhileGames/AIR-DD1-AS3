package
{
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdPlayer
	{
		private var __name:String;
		
		private var __HP:int;
		private var __STR:int;
		private var __DEX:int;
		private var __CON:int;
		private var __CHAR:int;
		private var __WIS:int;
		private var __INT:int;
		private var __GOLD:int;
		
		private var __clericSpells:Array;
		private var __wizardSpells:Array;
		
		private var __inventory:DdInventory;
		
		public function DdPlayer()
		{
			rollStats();
			__inventory = new DdInventory();
			__clericSpells = new Array();
			__wizardSpells = new Array();
		}
		
		public function rollStats():void{
			
			__STR = rollThreeSixSidedDice();
			__DEX = rollThreeSixSidedDice();
			__CON = rollThreeSixSidedDice();
			__CHAR = rollThreeSixSidedDice();
			__WIS = rollThreeSixSidedDice();
			__INT = rollThreeSixSidedDice();
			__GOLD = rollThreeSixSidedDice() * 15;
		}
		
		private function rollThreeSixSidedDice():int
		{
			var result:int;
			for (var i:int=0; i<3; i++)
			{
				var r:int = Math.random()*6+1;
				result = result + r;
			}
			
			return result;
		}
		
		public function statsList():String
		{
			var _list:String = "PLAYER: " + name + "\n";
			
			_list += "STR=" + __STR + "\n";
			_list += "DEX=" + __DEX + "\n";
			_list += "CON=" + __CON + "\n";
			_list += "CHAR=" + __CHAR + "\n";
			_list += "WIS=" + __WIS + "\n";
			_list += "INT=" + __INT + "\n";
			_list += "GOLD=" + __GOLD + "\n";
			_list += "HP=" + __HP + "\n";
		
			return _list;
		}

		public function get name():String
		{
			return __name;
		}

		public function set name(value:String):void
		{
			__name = value;
		}

		public function get STR():int
		{
			return __STR;
		}

		public function set STR(value:int):void
		{
			__STR = value;
		}

		public function get DEX():int
		{
			return __DEX;
		}

		public function get CON():int
		{
			return __CON;
		}
		
		public function set CON(value:int):void
		{
			__CON = value;
		}
		
		public function get CHAR():int
		{
			return __CHAR;
		}

		public function get WIS():int
		{
			return __WIS;
		}

		public function get INT():int
		{
			return __INT;
		}

		public function get GOLD():int
		{
			return __GOLD;
		}

		public function set GOLD(value:int):void
		{
			__GOLD = value;
		}

		public function get inventory():DdInventory
		{
			return __inventory;
		}

		public function get HP():int
		{
			return __HP;
		}

		public function set HP(value:int):void
		{
			__HP = value;
		}

		public function get clericSpells():Array
		{
			return __clericSpells;
		}

		public function get wizardSpells():Array
		{
			return __wizardSpells;
		}

	}
}