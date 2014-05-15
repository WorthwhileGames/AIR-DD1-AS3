package
{
	import flash.geom.Point;
	
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
		
		private var __attackEffectiveness:Number;
		private var __armorClass:Number;
		
		private var __x:int;
		private var __y:int;
		
		private var __classification:String;
		
		public function DdPlayer()
		{
			rollStats();
			__inventory = new DdInventory();
			__clericSpells = new Array();
			__wizardSpells = new Array();
		}
		
		public function rollStats():void{
			
			__STR = DdRoll.D6x3();
			__DEX = DdRoll.D6x3();
			__CON = DdRoll.D6x3();
			__CHAR = DdRoll.D6x3();
			__WIS = DdRoll.D6x3();
			__INT = DdRoll.D6x3();
			__GOLD = DdRoll.D6x3() * 15;
		}
		
		/*
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
		*/
		
		public function statsList():String
		{
			var _list:String = "PLAYER: " + name + "\n";
			
			_list += "CLASS: " + __classification + "\n";
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

		public function get attackEffectiveness():Number
		{
			return __attackEffectiveness;
		}

		public function set attackEffectiveness(value:Number):void
		{
			__attackEffectiveness = value;
		}

		public function get armorClass():Number
		{
			return __armorClass;
		}

		public function set armorClass(value:Number):void
		{
			__armorClass = value;
		}

		public function get x():int
		{
			return __x;
		}

		public function set x(value:int):void
		{
			__x = value;
		}

		public function get y():int
		{
			return __y;
		}

		public function set y(value:int):void
		{
			__y = value;
		}

		public function get classification():String
		{
			return __classification;
		}

		public function set classification(value:String):void
		{
			__classification = value;
			
			switch(__classification)
			{
				case "FIGHTER":
				{
					//00770 LET C(0)=INT(RND(0)*8+1)
					//00780 GO TO 00670
					HP = Math.random()*8+1;
					
					break;
				}
				case "CLERIC":
				{
					//00790 LET C(0)=INT(RND(0)*4+1)
					//00800 GO TO 00670
					HP  = Math.random()*4+1;
					break;
				}
				case "WIZARD":
				{
					//00810 LET C(0)=INT(RND(0)*6+1)
					//00820 GO TO 00670
					HP  = Math.random()*6+1;
					break;
				}
					
				default:
				{
					break;
				}
			}
		}


	}
}