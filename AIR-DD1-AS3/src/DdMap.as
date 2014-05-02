package
{
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
					if (Math.random() >= 0.97) row[j] = 7;  //DEBUG 0.97
					if (Math.random() >= 0.97) row[j] = 8;  //DEBUG 0.97
				}
			}
			
		}
		
		public function load(dungeon_number:int):void
		{

		}
		
		public function map(_state:DdGameState):String
		{
			var result:String = "";
			
			//WwDebug.instance.msg("map: " + __rows + ", " + __rows.length);
			
			for (var i:int=0; i<ROWS; i++)
			{
				var row:Array = __rows[i];
				//WwDebug.instance.msg(i + ": " + row);
				 
				for (var j:int=0; j<COLUMNS; j++)
				{
					if ((_state.G == j) && (_state.H == i))
					{
						result += __symbols[PLAYER_SYMBOL];
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
	}
}