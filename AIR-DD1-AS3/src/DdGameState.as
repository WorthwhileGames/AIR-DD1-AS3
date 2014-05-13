package
{
	import org.wwlib.utils.WwDebug;
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdGameState
	{
		
		private var __debug:WwDebug;
		
		private var __DUNGEON:int; //DUNGEON
		private var __X:int; //NUMBER OF ITEMS
		private var __J:int; //equipped item
		private var __K:int; //current monster type
		//private var __G:int; //G, player row, y
		//private var __H:int; //H, player col, x
		private var __map:DdMap;
		private var __monsterAlive:Boolean; //K1
		private var __difficulty:int; //J4
		
		
		public function DdGameState()
		{
			__debug = WwDebug.instance;
			
			__DUNGEON = 0;
			__X = 0;
			__J = 0;
			__K = 0;
			//__G = Math.random()*24 +2; //INT(RND(0)*24+2);
			//__H = Math.random()*24 +2; //INT(RND(0)*24+2;
			
			__monsterAlive = true;
		}
		

		
		/*
		01770 REM READ OUT OLD GAME
		01775 RESTORE #7
		01780 READ #7,D
		01790 READ #7,X
		01800 READ #7,J
		01810 READ #7,G
		01820 READ #7,H
		01830 READ #7,K
		01840 FOR M=0 TO 25  //MAP
		01850 FOR N=0 TO 25
		01860 READ #7,D(M,N)
		01870 NEXT N
		01880 NEXT M
		01890 FOR M=1 TO X
		01900 READ #7,W(M)
		01910 NEXT M
		01920 FOR M=1 TO 10  //MONSTER TYPES
		01930 READ #7,B$(M)
		01940 FOR N=1 TO 6
		01950 READ #7,B(M,N)
		01960 NEXT N
		01970 NEXT M
		01980 FOR M=0 TO 7  //PLAYER STATS
		01990 READ #7,C$(M)
		02000 READ #7,C(M)
		02010 NEXT M
		02020 READ #7,N$  //?
		02030 READ #7,F1  //?
		02040 READ #7,F2  //?
		02050 FOR M=1 TO 15  //ITEM NAMES
		02060 READ #7,I$(M)
		02070 NEXT M
		02080 READ #7,X3  //?
		02090 FOR M=1 TO X3  //?
		02100 READ #7,X4(M)  //?
		02110 NEXT M
		02120 READ #7,X1  //?
		02130 FOR M=1 TO X1  //?
		02140 READ #7,X2(M)
		02150 NEXT M
		02151 READ #7,F2  //?
		02152 READ #7,F1  //?
		02160 GO TO 01510
		*/
		
		//public function getFullMapAsString():String
		//{
		//	return map.map(__H, __G);
		//}
		
		//public function getLookMapAsString():String
		//{
		//	return map.look(__H, __G);
		//}

		public function get DUNGEON():int
		{
			return __DUNGEON;
		}

		public function set DUNGEON(value:int):void
		{
			__DUNGEON = value;
		}

		public function get X():int
		{
			return __X;
		}

		public function set X(value:int):void
		{
			__X = value;
		}

		public function get J():int
		{
			return __J;
		}

		public function set J(value:int):void
		{
			__J = value;
		}
/*
		public function get H():int
		{
			return __H;
		}

		public function set H(value:int):void
		{
			__H = value;
		}

		public function get G():int
		{
			return __G;
		}

		public function set G(value:int):void
		{
			__G = value;
		}
*/
		public function get K():int
		{
			return __K;
		}

		public function set K(value:int):void
		{
			__K = value;
		}

		public function get map():DdMap
		{
			return __map;
		}

		public function set map(value:DdMap):void
		{
			__map = value;
		}

		public function get monsterAlive():Boolean
		{
			return __monsterAlive;
		}

		public function set monsterAlive(value:Boolean):void
		{
			__monsterAlive = value;
		}

		public function get difficulty():int
		{
			return __difficulty;
		}

		public function set difficulty(value:int):void
		{
			__difficulty = value;
		}


	}
}