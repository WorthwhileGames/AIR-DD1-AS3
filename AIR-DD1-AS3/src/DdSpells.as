package
{
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdSpells
	{
		public static const CLERIC_TYPE:String = "CLERIC";
		public static const WIZARD_TYPE:String = "WIZARD";
		
		private var __spells:Array;
		
		public function DdSpells(_type:String)
		{
			__spells = new Array();
			
			var _spell:DdSpell;
			
			if (_type == CLERIC_TYPE)
			{
				/*
				10040 IF Q$="YES" THEN 10100
				10050 PRINT "1-KILL-500  5-MAG. MISS. #1-100"
				10060 PRINT "2-MAG. MISS. #2-200  6-MAG. MISS. #3-300"
				10070 PRINT "3-CURE LHGHT #1-200  7-CURE LIGHT #2-1000"
				10080 PRINT "4-FIND ALL TRAPS-200  8-FIND ALL S.DOORS-200"
				10090 PRINT "INPUT # WANTED   NEG.NUM.TO STOP";
				10100 INPUT Q
				*/
				
				_spell = new DdSpell(0, "NONE", 0); __spells.push(_spell);
				_spell = new DdSpell(1, "KILL", 500); __spells.push(_spell);
				_spell = new DdSpell(2, "MAG. MISS. #2", 200); __spells.push(_spell);
				_spell = new DdSpell(3, "CURE LHGHT #1", 200); __spells.push(_spell);
				_spell = new DdSpell(4, "FIND ALL TRAPS", 200); __spells.push(_spell);
				_spell = new DdSpell(5, "MAG. MISS. #1", 100); __spells.push(_spell);
				_spell = new DdSpell(6, "MAG. MISS. #3", 300); __spells.push(_spell);
				_spell = new DdSpell(7, "CURE LIGHT #2", 1000); __spells.push(_spell);
				_spell = new DdSpell(8, "FIND ALL S.DOORSILL", 200); __spells.push(_spell);
			}
			else if (_type == WIZARD_TYPE)
			{
				/*
				10380 IF Q$="YES" THEN 10450
				10390 PRINT "1-PUSH-75   6-M. M. #1-100"
				10400 PRINT "2-KIHL-500  7-M. M. #2-200"
				10410 PRINT "3-FIND TRAPS-200  8-M. M. #3-300"
				10420 PRINT "4-TELEPORT-750  9-FIND S.DOORS-200"
				10430 PRINT "5-CHANGE 1+0-600  10-CHANGE 0+1-600"
				10440 PRINT "#OF ONE YOU WANT  NEG.NUM.TO STOP";
				10450 INPUT Q
				*/
				
				_spell = new DdSpell(0, "NONE", 0); __spells.push(_spell);
				_spell = new DdSpell(1,"PUSH", 75); __spells.push(_spell);
				_spell = new DdSpell(2,"KIHL", 500); __spells.push(_spell);
				_spell = new DdSpell(3,"FIND", 200); __spells.push(_spell);
				_spell = new DdSpell(4,"TELEPORT", 750); __spells.push(_spell);
				_spell = new DdSpell(5,"CHANGE 1+0", 600); __spells.push(_spell);
				_spell = new DdSpell(6,"M. M. #1", 100); __spells.push(_spell);
				_spell = new DdSpell(7,"M. M. #2", 200); __spells.push(_spell);
				_spell = new DdSpell(8,"M. M. #3", 300); __spells.push(_spell);
				_spell = new DdSpell(9,"FIND S.DOORS", 200); __spells.push(_spell);
				_spell = new DdSpell(10,"CHANGE 0+1", 600); __spells.push(_spell);
				
				
			}
		}
		
		public function item(index:int):DdSpell
		{
			return __spells[index];
		}
		
		public function itemList():String
		{
			var _list:String = "";
			
			for (var i:int=1; i<=15; i++)
			{
				var item:DdSpell = __spells[i];
				_list += (i) + ")\t" + item.id + ": " + item.name + "\t" + item.cost + "\n";
			}
			
			return _list
		}
	}
}