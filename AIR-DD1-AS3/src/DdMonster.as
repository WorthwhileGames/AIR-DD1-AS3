package
{
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdMonster
	{
		private var __name:String;
		private var __stat1:int;
		private var __stat2:int;
		private var __stat3:int;
		private var __stat4:int;
		private var __stat5:int;
		private var __stat6:int;
		
		public function DdMonster(name:String, s1:int, s2:int, s3:int, s4:int, s5:int, s6:int)
		{
			__name = name;
			__stat1 = s1;
			__stat2 = s2;
			__stat3 = s3;
			__stat4 = s4;
			__stat5 = s5;
			__stat6 = s6;
			
			__stat4 = __stat3;
			__stat5 = __stat6;
			__stat1 = 1;
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
		01265 B(M,4)=B(M,3)
		01267 B(M,5)=B(M,6)
		01269 B(M,1)=1
		01270 NEXT M
		01280 RETURN
		*/

		public function get name():String
		{
			return __name;
		}

		public function get stat1():int
		{
			return __stat1;
		}

		public function get stat2():int
		{
			return __stat2;
		}

		public function get stat3():int
		{
			return __stat3;
		}

		public function get stat4():int
		{
			return __stat4;
		}

		public function get stat5():int
		{
			return __stat5;
		}

		public function get stat6():int
		{
			return __stat6;
		}


	}
}