package
{
	
	/**
	 * ...
	 * @author Andrew Rapo (andrew@worthwhilegames.org)
	 * @license MIT
	 */
	public class DdRoll
	{
		
		public static const POISON_ROLL_THRESHOLD:Number = 0.2;
		
		public function DdRoll()
		{
		}
		
		public static function D(sides:int):int
		{
			return Math.random()*sides;
		}
		
		public static function R(range:Number):Number
		{
			return Math.random()*range;
		}
		
		public static function D6x3():int
		{
			var result:int;
			for (var i:int=0; i<3; i++)
			{
				var r:int = Math.random()*6+1;
				result = result + r;
			}
			
			return result;
		}
	}
}