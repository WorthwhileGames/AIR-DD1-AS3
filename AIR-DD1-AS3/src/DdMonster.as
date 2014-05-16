package
{
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdMonster
	{
		public var id:int;
		public var name:String;
		public var level:int;
		public var stat2:int;
		public var gold:int;
		public var maxGold:int;
		public var HP:int;
		public var maxHP:int;
		public var alive:Boolean;
		public var xOffset:int;
		public var yOffset:int;
		public var distance:Number;
		public var x:int;
		public var y:int;
		
		public function DdMonster(_id:int, _name:String, s1:int, s2:int, s3:int, s4:int, s5:int, s6:int)
		{
			id = _id;
			name = _name;
			level = s1; //level
			stat2 = s2; //
			gold = s3; //gold
			maxGold = s4; //max gold
			HP = s5; //hp
			maxHP = s6; //max hp
			
			reset();
		}
		
		public function reset(_difficulty:int=1):void
		{
			gold = maxGold * _difficulty;  //__stat4 = __stat3 * _difficulty;
			HP = maxHP * _difficulty;
			level = 1;
			
			alive = true;
			xOffset = 0;
			yOffset = 0;
			
			x = 10;
			y = 10;
		}
		
		public function kill():void
		{
			alive = false;
			HP = 0;
		}
		
		
		/*
		01150 DATA "MAN",1,13,26,1,1,500
		01160 DATA "GOBLIN",2,13,24,1,1,600
		01170 DATA "TROLL",3,15,35,1,1,1000
		01180 DATA "SKELETON",4,22,12,1,1,50
		01190 DATA "BALROG",5,18,110,1,1,5000
		01200 DATA "OCHRE JELLY",6,11,20,1,1,0
		01210 DATA "GREY OOZE",7,11,13,1,1,0
		01220 DATA "GNOME",8,13,30,1,1,100
		01230 DATA "KOBOLD",9,15,16,1,1,500
		01240 DATA "MUMMY",10,16,30,1,1,100
		01250 FOR M=1 TO 10
		01260 READ B$(M),B(M,1),B(M,2),B(M,3),B(M,4),B(M,5),B(M,6)
		01265 B(M,4)=B(M,3)  //BUG transposed?  Should be B(M,3)=B(M,4)
		01267 B(M,5)=B(M,6)
		01269 B(M,1)=1
		01270 NEXT M
		01280 RETURN
		*/

	}
}