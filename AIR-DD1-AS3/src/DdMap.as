package
{
	import flash.geom.Point;
	
	import org.wwlib.utils.WwDebug;
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdMap
	{
		private static var ROWS:int = 25;
		private static var COLUMNS:int = 25;
		private static var PLAYER_SYMBOL:int = 9;
		private static var MONSTER_SYMBOL:int = 5;
		
		public static var TILE_ID_MONSTER:int = 5;
		
		private var __rows:Array;
		private var __symbols:Array = [" ","*","2","3","4","5","6","7","8","X","0"];
		
		public function DdMap()
		{
			init();
		}
		
		private function init():void
		{	
			
		}
		
		public function generate(dungeon_number:int):void
		{
			__rows = new Array();
			var _row:Array;
			
			_row = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]; __rows.push(_row);
			_row = [1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,1,1,1,1,1,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0]; __rows.push(_row);
			_row = [1,0,0,0,0,0,0,0,0,0,1,0,0,1,1,1,0,0,1,1,1,1,1,1,1]; __rows.push(_row);
			_row = [1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1]; __rows.push(_row);
			_row = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]; __rows.push(_row);
			
			for (var i:int=0; i<ROWS; i++)
			{
				var row:Array = __rows[i];
				
				for (var j:int=0; j<COLUMNS; j++)
				{
					if (row[j] == 0)
					{
						if (DdRoll.R(1) >= 0.97) row[j] = 7;  //DEBUG 0.97
						if (DdRoll.R(1) >= 0.97) row[j] = 8;  //DEBUG 0.97
					}
				}
			}
			
		}
		
		public function load(dungeon_number:int):void
		{

		}
		
		public function look(player_x:int, player_y:int):String
		{
			var result:String = "";
			var map_start_x:int = Math.max(0, player_x - 5); //MAGIC NUMBER
			var map_end_x:int = Math.min(ROWS, player_x + 5); //MAGIC NUMBER
			var map_start_y:int = Math.max(0, player_y - 5); //MAGIC NUMBER
			var map_end_y:int = Math.min(COLUMNS, player_y + 5); //MAGIC NUMBER
			
			//WwDebug.instance.msg("map: " + __rows + ", " + __rows.length);
			
			for (var y:int=map_start_y; y < map_end_y; y++)
			{
				var row:Array = __rows[y];
				//WwDebug.instance.msg(i + ": " + row);
				
				for (var x:int=map_start_x; x < map_end_x; x++)
				{
					if ((player_x == x) && (player_y == y))
					{
						result += __symbols[PLAYER_SYMBOL];
					}
					else
					{
						result += __symbols[row[x]];
					}
				}
				
				result += "\n";
			}
			
			return result;
		}
		
		public function map(player:DdPlayer, monster:DdMonster):String
		{
			var result:String = "";
			
			//WwDebug.instance.msg("map: " + __rows + ", " + __rows.length);
			
			for (var i:int=0; i<ROWS; i++)
			{
				var row:Array = __rows[i];
				//WwDebug.instance.msg(i + ": " + row);
				 
				for (var j:int=0; j<COLUMNS; j++)
				{
					if ((player.x == j) && (player.y == i))
					{
						result += __symbols[PLAYER_SYMBOL];
					}
					else if ((monster.x == j) && (monster.y == i))
					{
						result += __symbols[MONSTER_SYMBOL];
					}
					else
					{
						result += __symbols[row[j]];
					}
				}
				
				result += "\n";
			}
			
			return result;
		}
		
		/*
		01400 REM READ DUNGEON AND START GAME
		01410 RESTORE #D
		1415 PRINT "READING DUNGEON NUM. ";D
		01420 FOR M=0 TO 25
		01430 FOR N=0 TO 25
		01431 D(M,N)=0
		01432 IF D=0 THEN 01450
		01440 READ #D,D(M,N)
		01443 IF D(M,N)<>0 THEN 01450
		01445 IF RND(0)<.97 THEN 01447
		01446 D(M,N)=7
		01447 IF RND(0)<.97 THEN 01450
		01448 D(M,N)=8
		01450 NEXT N
		01460 NEXT M
		*/
		
		public function getRandomFreeTile():Point
		{
			var free_tile_found:Boolean = false;
			var _x:int;
			var _y:int;
			
			while (!free_tile_found)
			{
				_x = DdRoll.D(24) +2; //INT(RND(0)*24+2);
				_y = DdRoll.D(24) +2; //INT(RND(0)*24+2);
				
				if (getTileType(_x, _y, null) == 0)
				{
					free_tile_found = true;
				}
			}
			
			return new Point(_x, _y);
		}
		
		public function getTileType(x:int, y:int, _monster:DdMonster=null):int
		{
			var _row:Array = __rows[y];
			var _type:int;
			
			if (_monster && (x == _monster.x) && (y == _monster.y))
			{
				_type = TILE_ID_MONSTER;
			}
			else
			{
				_type = _row[x];
			}
			return _type;
		}
		
		public function clearTile(x:int, y:int):void
		{
			var _row:Array = __rows[y];
			
			_row[x] = 0;
			
		}
		
		public function isOnMap(x:int, y:int):Boolean
		{
			if ((x > 0) && (x < ROWS) && (y > 0) && (y < ROWS))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
	}
}