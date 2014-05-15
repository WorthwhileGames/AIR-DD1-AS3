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
		private static var ROWS:int = 26;
		private static var COLUMNS:int = 26;
		private static var PLAYER_SYMBOL:int = 9;
		private static var MONSTER_SYMBOL:int = 5;
		
		public static var TILE_ID_MONSTER:int = 5;
		
		private var __rows:Array;
		private var __symbols:Array = [" ","*","2","3","4","5","6","7","8","X","0"];
		
		public var generated:Boolean = false;
		
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
			var row_data:Array;
			
			row_data = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]; generateRow(row_data);
			row_data = [1,6,2,0,1,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,6,1]; generateRow(row_data);
			row_data = [1,0,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,2,1]; generateRow(row_data);
			row_data = [1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,0,0,0,0,0,0,0,0,0,0,0,0,1,6,0,0,0,0,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,0,0,0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,0,0,0,1,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,0,0,0,1,1,1,1,1,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0]; generateRow(row_data);
			row_data = [1,0,0,0,0,0,0,0,0,0,1,0,0,1,1,1,4,1,1,1,1,1,1,1,0,1]; generateRow(row_data);
			row_data = [1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,6,1]; generateRow(row_data);
			row_data = [1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,2,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]; generateRow(row_data);
			row_data = [1,6,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,2,1]; generateRow(row_data);
			row_data = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]; generateRow(row_data);
			
			
			for (var i:int=0; i<ROWS; i++)
			{
				var row:Array = __rows[i];
				
				for (var j:int=0; j<COLUMNS; j++)
				{
					var tile:DdMapTile = row[j] as DdMapTile;
					
					if (tile.type == 0)
					{
						if (DdRoll.R(1) >= 0.97) tile.type = 7;  //DEBUG 0.97
						if (DdRoll.R(1) >= 0.97) tile.type = 8;  //DEBUG 0.97
					}
				}
			}
			
			generated = true;
		}
		
		private function generateRow(type_data:Array):void
		{
			var new_row:Array = new Array(COLUMNS);
			
			for (var i:int=0; i<COLUMNS; i++)
			{
				var new_tile:DdMapTile = new DdMapTile(type_data[i]);
				new_row[i] = new_tile;
			}
			__rows.push(new_row);
		}
		
		public function load(dungeon_number:int):void
		{

		}
		
		public function revealTile(x:int, y:int, radius:int=5):void{
			
			var _row:Array = __rows[y];
			
			var tile:DdMapTile = _row[x] as DdMapTile;
			
			tile.visible = true;
			
			var map_start_x:int = x - radius;
			var map_end_x:int = x + radius;
			var map_start_y:int = y - radius;
			var map_end_y:int = y + radius;
			
			for (var i:int=map_start_y; i < (map_end_y); i++)
			{
				for (var j:int=map_start_x; j < (map_end_x); j++)
				{
					if (isOnMap(i, j))
					{
						_row = __rows[i];
						tile = _row[j] as DdMapTile;
						tile.visible = true;
					}
				}
			}
		}
		
		/*
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
					var tile:DdMapTile = row[x] as DdMapTile;
					
					if ((player_x == x) && (player_y == y))
					{
						result += __symbols[PLAYER_SYMBOL];
					}
					else
					{
						result += __symbols[tile.type];
					}
				}
				
				result += "\n";
			}
			
			return result;
		}
		*/
		
		public function map(player:DdPlayer, monster:DdMonster, show_invisible:Boolean=false):String
		{
			var result:String = "";
			
			//WwDebug.instance.msg("map: " + __rows + ", " + __rows.length);
			
			for (var i:int=0; i<ROWS; i++)
			{
				var row:Array = __rows[i];
				//WwDebug.instance.msg(i + ": " + row);
				 
				for (var j:int=0; j<COLUMNS; j++)
				{
					var tile:DdMapTile = row[j] as DdMapTile;
					
					
					if ((player.x == j) && (player.y == i))
					{
						result += __symbols[PLAYER_SYMBOL];
					}
					else if (!show_invisible && tile.visible == false)
					{
						result += " ";
					}
					else if ((monster.x == j) && (monster.y == i))
					{
						result += __symbols[MONSTER_SYMBOL];
					}
					else
					{
						result += __symbols[tile.type];
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
			
			var tile:DdMapTile = _row[x] as DdMapTile;
			
			if (_monster && (x == _monster.x) && (y == _monster.y))
			{
				_type = TILE_ID_MONSTER;
			}
			else
			{
				_type = tile.type;
			}
			return _type;
		}
		
		public function clearTile(x:int, y:int):void
		{
			var _row:Array = __rows[y];
			
			var tile:DdMapTile = _row[x] as DdMapTile;
			
			tile.type = 0;
			
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