package
{
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdMonster
	{
		private var __id:int;
		private var __name:String;
		private var __level:int;
		private var __stat2:int;
		private var __stat3:int;
		private var __stat4:int;
		private var __stat5:int;
		private var __stat6:int;
		private var __alive:Boolean;
		private var __xOffset:int;
		private var __yOffset:int;
		private var __distance:Number;
		private var __x:int;
		private var __y:int;
		
		public function DdMonster(id:int, name:String, s1:int, s2:int, s3:int, s4:int, s5:int, s6:int)
		{
			__id = id;
			__name = name;
			__level = s1; //level
			__stat2 = s2; //
			__stat3 = s3; //gold
			__stat4 = s4; //max gold
			__stat5 = s5; //hp
			__stat6 = s6; //max hp
			
			reset();
		}
		
		public function reset(_difficulty:int=1):void
		{
			__stat3 = __stat4 * _difficulty;  //__stat4 = __stat3 * _difficulty;
			__stat5 = __stat6 * _difficulty;
			__level = 1;
			
			__alive = true;
			__xOffset = 0;
			__yOffset = 0;
			
			__x = -1;
			__y = -1;
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

		public function get name():String
		{
			return __name;
		}

		public function get level():int
		{
			return __level;
		}

		public function get stat2():int
		{
			return __stat2;
		}

		public function get gold():int
		{
			return __stat3;
		}

		public function get maxGold():int
		{
			return __stat4;
		}

		public function get HP():int
		{
			return __stat5;
		}

		public function get maxHP():int
		{
			return __stat6;
		}

		public function set maxGold(value:int):void
		{
			__stat4 = value;
		}

		public function set HP(value:int):void
		{
			__stat5 = value;
		}

		public function get alive():Boolean
		{
			return __alive;
		}

		public function set alive(value:Boolean):void
		{
			__alive = value;
		}

		public function get xOffset():int
		{
			return __xOffset;
		}

		public function set xOffset(value:int):void
		{
			__xOffset = value;
		}

		public function get yOffset():int
		{
			return __yOffset;
		}

		public function set yOffset(value:int):void
		{
			__yOffset = value;
		}

		public function get distance():Number
		{
			return __distance;
		}

		public function set distance(value:Number):void
		{
			__distance = value;
		}

		public function get id():int
		{
			return __id;
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

		public function set gold(value:int):void
		{
			__stat3 = value;
		}


	}
}