package
{
	import flash.utils.Dictionary;
	
	import org.wwlib.utils.WwDebug;
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdMonsters
	{
		private var __types:Array;
		public var spawnOrder:Array;
		public var spawnIndex:int;
		
		public static const NUM_MONSTER_TYPES:int = 11;
		
		public function DdMonsters()
		{
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
			
			__types = new Array(NUM_MONSTER_TYPES);
			
			var monster:DdMonster;
			
			monster = new DdMonster(0, "NA",0,0,0,0,0,0);
			__types[0] = monster;
			
			monster = new DdMonster(1, "MAN",1,13,26,1,1,500);
			__types[1] = monster;
			
			monster = new DdMonster(2, "GOBLIN",2,13,24,1,1,600);
			__types[2] = monster;
			
			monster = new DdMonster(3, "TROLL",3,15,35,1,1,1000);
			__types[3] = monster;
			
			monster = new DdMonster(4, "SKELETON",4,22,12,1,1,50);
			__types[4] = monster;
			
			monster = new DdMonster(5, "BALROG",5,18,110,1,1,5000);
			__types[5] = monster;
			
			monster = new DdMonster(6, "OCHRE JELLY",6,11,20,1,1,0);
			__types[6] = monster;
			
			monster = new DdMonster(7, "GREY OOZE",7,11,13,1,1,0);
			__types[7] = monster;
			
			monster = new DdMonster(8, "GNOME",8,13,30,1,1,100);
			__types[8] = monster;
			
			monster = new DdMonster(9, "KOBOLD",9,15,16,1,1,500);
			__types[9] = monster;
			
			monster = new DdMonster(10, "MUMMY",10,16,30,1,1,100);
			__types[10] = monster;
			
			spawnOrder = [1,2,3,4,5,6,7,8,9,10];
			spawnOrder = ShuffleArray(spawnOrder);
			spawnIndex = 0;
			
			WwDebug.instance.msg("Monsters: spawnOrder: " + spawnOrder);
			
		}
		
		public function spawnMonster():DdMonster
		{
			var _monster:DdMonster;
			
			if (spawnIndex < spawnOrder.length)
			{
				_monster = getMonsterByID(spawnOrder[spawnIndex]);
				spawnIndex++;
			}
			else
			{
				_monster = getMonsterByID(0);
			}
			return _monster;
		}
		
		public function ShuffleArray(_array:Array):Array
		{
			
			for (var i:int = _array.length; i > 0; i--)
			{
				var j:int = DdRoll.D(i);
				var k:int = _array[j];
				_array[j] = _array[i - 1];
				_array[i - 1]  = k;
			}
			return _array;
		}
		
		/*
		private void button1_Click(object sender, EventArgs e)
		{
			int[] array = {1,2,3,4,5};
			array = ShuffleArray(array);
		}
		int[] ShuffleArray(int[] array)
		{
			Random r = new Random();
			for (int i = array.Length; i > 0; i--)
			{
				int j = r.Next(i);
				int k = array[j];
				array[j] = array[i - 1];
				array[i - 1]  = k;
			}
			return array;
		}
		*/

		
		public function reset(_difficulty:int=1):void
		{
			for (var i:int = 1; i<= NUM_MONSTER_TYPES; i++)
			{
				var monster:DdMonster = __types[i] as DdMonster;
				monster.reset(_difficulty);
			}
			
			spawnOrder = [1,2,3,4,5,6,7,8,9,10];
			spawnOrder = ShuffleArray(spawnOrder);
			spawnIndex = 0;
		}

		public function getMonsterByID(id:int):DdMonster
		{
			return __types[id];
		}

	}
}