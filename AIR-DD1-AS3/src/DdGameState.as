package
{
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdGameState
	{
		private var __DUNGEON:int; //DUNGEON
		private var __X:int; //NUMBER OF ITEMS
		private var __J:int;
		private var __K:int;
		private var __G:int;
		private var __H:int;
		
		
		public function DdGameState()
		{
			__DUNGEON = 0;
			__X = 0;
			__J = 0;
			__K = 0;
			__G = Math.random()*24 +2; //INT(RND(0)*24+2;
			__H = Math.random()*24 +2; //INT(RND(0)*24+2);
		}
		
		public function move(x:int, y:int):void
		{
			__G += x;
			__H += y;
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
		
		/*
		02250 LOGIC
		get movement
		check to see if tile is occupied
		0 free square, move there
		1 wall RND(0)*12+1>9 chance of 1 HP damage
		2 trap RND(0)*3>2 chance of 1 HP damage
		  check for rope and spikes
		  decrement rope and spikes if you have them
		  if spikes check for rope  
		  if no spikes, dead
		  if both, you're out
		3 secret door
		4 NOP
		5 monster shoves you back
		  roll a 2 and no damage IF INT(RND(0)*2)+1=2
		  or HP -6
		  ...
		6 gold found INT(RND(0)*500+10) pieces
		  print # GOLD
		  then do poison check
		7 potion STR + 1, then poison check: IF RND(0)>.2 then C(0)=C(0)-INT(RND(0)*4+1)
		  print HP
		  finish move
		8 ption CON + 1, then poison check: IF RND(0)>.2 then C(0)=C(0)-INT(RND(0)*4+1)
		  print HP
		  finish move
		
		*/

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

		public function get G():int
		{
			return __G;
		}

		public function set G(value:int):void
		{
			__G = value;
		}

		public function get H():int
		{
			return __H;
		}

		public function set H(value:int):void
		{
			__H = value;
		}

		public function get K():int
		{
			return __K;
		}

		public function set K(value:int):void
		{
			__K = value;
		}


	}
}