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
		public var name:String;
		
		public var HP:int;
		public var STR:int;
		public var DEX:int;
		public var CON:int;
		public var CHAR:int;
		public var WIS:int;
		public var INT:int;
		public var GOLD:int;
		
		public var clericSpells:DdSpellInventory;
		public var spells:DdSpellInventory;
		
		public var inventory:DdInventory;
		
		public var attackEffectiveness:Number;
		public var armorClass:Number;
		
		public var x:int;
		public var y:int;
		
		public var equippedItemID:int;
		public var equippedItem:DdItem;
		
		public var equippedClericalSpellID:int;
		public var equippedClericalSpell:DdSpell;
		
		public var equippedSpellID:int;
		public var equippedSpell:DdSpell;
		
		private var __classification:String;
		
		public function DdPlayer()
		{
			rollStats();
			inventory = new DdInventory();
			clericSpells = new DdSpellInventory();
			spells = new DdSpellInventory();
			
			equip(0);
			equipClericalSpell(0);
			equipSpell(0);
		}
		
		public function equip(item_id):void
		{
			var item:DdItem;
			
			item = inventory.getItemByID(item_id);
			if (item != null)
			{
				equippedItemID = item_id;
				equippedItem = item;
			}
		}
		
		public function dropEquippedItem():void
		{
			if (equippedItem != null)
			{
				inventory.dropItem(equippedItem);
				equip(0);
			}
		}
		
		public function equipClericalSpell(item_id):void
		{
			var item:DdSpell;
			
			item = clericSpells.getItemByID(item_id);
			if (item != null)
			{
				equippedClericalSpellID = item_id;
				equippedClericalSpell = item;
			}
		}
		
		public function dropEquippedSpell():void
		{
			if (equippedSpell != null)
			{
				clericSpells.dropItem(equippedSpell);
				equip(0);
			}
		}
		
		public function equipSpell(item_id):void
		{
			var item:DdSpell;
			
			item = clericSpells.getItemByID(item_id);
			if (item != null)
			{
				equippedSpellID = item_id;
				equippedSpell = item;
			}
		}
		
		public function dropEquippedClericalSpell():void
		{
			if (equippedClericalSpell != null)
			{
				clericSpells.dropItem(equippedClericalSpell);
				equip(0);
			}
		}
		
		public function rollStats():void{
			
			STR = DdRoll.D6x3();
			DEX = DdRoll.D6x3();
			CON = DdRoll.D6x3();
			CHAR = DdRoll.D6x3();
			WIS = DdRoll.D6x3();
			INT = DdRoll.D6x3();
			GOLD = DdRoll.D6x3() * 15;
		}
		
		public function statsList():String
		{
			var _list:String = "PLAYER: " + name + "\n";
			
			_list += "CLASS: " + __classification + "\n";
			_list += "STR=" + STR + "\n";
			_list += "DEX=" + DEX + "\n";
			_list += "CON=" + CON + "\n";
			_list += "CHAR=" + CHAR + "\n";
			_list += "WIS=" + WIS + "\n";
			_list += "INT=" + INT + "\n";
			_list += "GOLD=" + GOLD + "\n";
			_list += "HP=" + HP + "\n";
		
			return _list;
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