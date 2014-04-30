package
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdMonsters
	{
		private var __types:Dictionary;
		
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
			
			__types = new Dictionary();
			
			var monster:DdMonster;
			
			monster = new DdMonster("MAN",1,13,26,1,1,500);
			__types[monster.name] = monster;
			
			monster = new DdMonster("GOBLIN",2,13,24,1,1,600);
			__types[monster.name] = monster;
			
			monster = new DdMonster("TROLL",3,15,35,1,1,1000);
			__types[monster.name] = monster;
			
			monster = new DdMonster("SKELETON",4,22,12,1,1,50);
			__types[monster.name] = monster;
			
			monster = new DdMonster("BALROG",5,18,110,1,1,5000);
			__types[monster.name] = monster;
			
			monster = new DdMonster("OCHRE JELLY",6,11,20,1,1,0);
			__types[monster.name] = monster;
			
			monster = new DdMonster("GREY OOZE",7,11,13,1,1,0);
			__types[monster.name] = monster;
			
			monster = new DdMonster("GNOME",8,13,30,1,1,100);
			__types[monster.name] = monster;
			
			monster = new DdMonster("KOBOLD",9,15,16,1,1,500);
			__types[monster.name] = monster;
			
			monster = new DdMonster("MUMMY",10,16,30,1,1,100);
			__types[monster.name] = monster;
			
			
		}

		public function type(name:String):DdMonster
		{
			return __types[name];
		}

	}
}