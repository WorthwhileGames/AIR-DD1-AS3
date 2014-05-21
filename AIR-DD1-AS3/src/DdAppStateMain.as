package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.AccelerometerEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.engine.BreakOpportunity;
	import flash.utils.describeType;
	
	import org.wwlib.dd1.UI_Main;
	import org.wwlib.flash.WwAppState;
	import org.wwlib.utils.WwDebug;
	
	//import starling.display.Sprite;
	
	
	/**
	 * ...
	 * @author Richard Garriot
	 * @author (AS3) Andrew Rapo
	 * @copyright 1977-2014 Richard Garriott
	 * 	REM DND-1
	 REM 1500 lines
	 REM (C)1977-2014 RICHARD GARRIOTT
	 REM 79/02/28. 19.27.34.
	 PROGRAM   DND1
	 TRANSCRIBED and RESTRUCTURED BY DEJAY CLAYTON 2014
	 */
	
	public class DdAppStateMain extends WwAppState
	{
		//public static const POISON_ROLL_THRESHOLD:Number = 0.2;
		
		private var __UI_Main:UI_Main;
		
		private var __txtTeletype:TextField;
		private var __txtMap:TextField;
		private var __txtStats:TextField;
		//private var __txtPrompt:TextField;
		//private var __txtInput:TextField;
		//private var __btnEnter:MovieClip;
				
		private var __input:DdInput;
		private var __output:DdOutput;
		
		private var __Q$:String;
		//private var resetOnLevelComplete:int;

		
		//private var __DUNGEON:int;
		//private var __class:String;
		private var __monsterDB:DdMonsters;
		private var __monster:DdMonster;
		//private var __inventoryCount:int;
		private var __itemTypes:DdItems;
		private var __spellTypesCleric:DdSpells;
		private var __spellTypesWizard:DdSpells;
		
		private var __player:DdPlayer;
		
		private var __pendingAction:DdPendingAction;
		private var __pendingFunction:Function;
		private var __pendingArgs:Array;
		private var __pendingCallback:Function;
		private var __map:DdMap;
		private var __state:DdGameState;
		private var __commands:Array;
		
		private var ttKeyboardMC:MovieClip;
		private var ttKeyboard:DdKeyboard;
		
		private var __cheatCount:int;
		private var __showHUD:Boolean;
		

		public function DdAppStateMain()
		{
			super();
		}
		
		override public function onKeyDown(event:KeyboardEvent):void
		{
			//__debug.msg("  onKeyDown: " + __input.reading);
			if (__input.reading)
			{
				__input.onKeyDown(event.keyCode);
			}
		}
		
		public function onVirtualKeyEvent(key_code:int):void
		{	
			//WwDebug.instance.msg("onVirtualKeyEvent:key_code: " + key_code);
			if (__input.reading)
			{
				__input.onKeyDown(key_code);
			}
		}
		
		public override function enterFrameUpdateHandler(frame_time:int, total_seconds:Number):void
		{
			if (__input.bufferIsNotEmpty())
			{
				__output.print(__input.getReadBufferAsString(), false);
			}
			else if (__input.complete())
			{
				//__debug.msg("  __input.complete(): " + __input.complete());
				__input.onComplete();
			}
			__output.output();
			
			if (__pendingAction && !__output.printing)
			{
				var _action:DdPendingAction = __pendingAction;
				__pendingAction = null;
				
				if (_action.execute())
				{
					//OK
				}
				else
				{
					__pendingAction = _action;
				}
				
			}
		}
		
		public override function init(_app:flash.display.Sprite, _stage:MovieClip):void
		{
			super.init(_app, _stage);
			__debug.msg("DdAppStateMain: init: " + _app, "1");
			__UI_Main = new UI_Main();
			setupTimelineCallbacks(__UI_Main);
			addChild(__UI_Main);
			__UI_Main.gotoAndPlay("a");
			
			__txtTeletype = __UI_Main.txt_teletype;
			__txtTeletype.y = 475; //MAGIC NUMBER
			__txtTeletype.height = DdOutput.LINE_HEIGHT * 3;
			
			__txtMap = __UI_Main.txt_map;
			__txtStats = __UI_Main.txt_stats;
			__showHUD = false;
			
			__txtMap.addEventListener(MouseEvent.MOUSE_DOWN, onMapClick);
			
			ttKeyboardMC = __UI_Main["keyboard"];
			ttKeyboard = new DdKeyboard(ttKeyboardMC, onVirtualKeyEvent);
			
			
			__input = new DdInput();
			__output = new DdOutput(__txtTeletype);
			
			__pendingFunction = null;
			__pendingArgs = null;
			__pendingCallback = null;
			
			__pendingAction = null;
						
			/*
			FILE #N,"SPEC"  Open file "SPEC" as file N
			RESTORE #N      Rewind file N
			READ #N, VAR    Read value from file N into variable VAR
			WRITE #N, VAR   Write value of VAR to file #N
			*/
		
			/*
			00010 LET J4=1
			00030 PRINT
			00100 BASE 0
			00110 LET X=0
			00120 LET J=0
			00130 LET K=0
			00140 X1=0
			00150 LET X3=0
			00160 LET J9=RND(CLK(J9))
			00170 DIM C(7),C$(7),W(100),D(50,50),P(100),I$(100),B(100,6),B$(100)
			00180 DIM E(100),F(100),X5(100),X6(100),X2(100),X4(100)
			00190 LET G=INT(RND(0)*24+2
			00200 LET H=INT(RND(0)*24+2)
			00210 FILE #1="DNG1"
			00220 FILE #2="DNG2",#3="DNG3",#4="DNG4",#5="DNG5",#6="DNG6"
			00230 RESTORE #4
			00240 FILE #7="GMSTR"
			00245 RESTORE #7
			00250 RESTORE #1
			00260 RESTORE #2
			00261 RESTORE #3
			00262 RESTORE #4
			00263 RESTORE #5
			00264 RESTORE #6
			00270 DATA "STR","DEX","CON","CHAR","WIS","INT","GOLD"
			00280 DATA "SWORD",10,"2-H-SWORD",15,"DAGGER",3,"MACE",5
			00290 DATA "SPEAR",2,"BOW",25,"ARROWS",2,"LEATHER MAIL",15
			00300 DATA "CHAIN MAIL",30,"TLTE MAIL",50,"ROPE",1,"SPIKES",1
			00310 DATA "FLASK OF OIL",2,"SILVER CROSS",25,"SPARE FOOD",5
			*/
			
			/*
			//__X = 0;  //equip count
			//__J = 0;  //equipped item
			//__K = 0;  //current monster type
			__X1 = 0;  //player clerical spell count
			__X3 = 0;  //selected clerical spell
			__J9 = 0; //RND(CLK(J9))  /unused var randomize
			__C = [0,0,0,0,0,0,0];
			__C$ = ["STR","DEX","CON","CHAR","WIS","INT","GOLD"];
			__W = new Array(100);  //inventory
			__D = new Array(100); //DdGameBoard();
			
			__P = [10,15,3,5,2,25,2,15,30,50,1,1,2,25,5];
			__I$ = ["SWORD","2-H-SWORD","DAGGER","MACE","SPEAR","BOW","ARROWS","LEATHER MAIL","CHAIN MAIL","TLTE MAIL","ROPE","SPIKES","FLASK OF OIL","SILVER CROSS","SPARE FOOD"];
			__B = new Array(100); //(100,6)  //Monster stats
			__B$ = new Array(100);  //Monster names
			__E = new Array(100);  //unused
			__F = new Array(100);  //unused
			__X5 = new Array(100);  //clerical spell costs
			__X6 = new Array(100);  //wizard spell costs
			__X2 = new Array(100);  //clerical spell slots
			__X4 = new Array(100);  //wizard spell slots
			//__G = Math.random()*24 +2; //INT(RND(0)*24+2; //player row, y
			//__H = Math.random()*24 +2; //INT(RND(0)*24+2); //player col, x
			*/
			
			__itemTypes = new DdItems();
			__spellTypesCleric = new DdSpells(DdSpells.CLERIC_TYPE);
			__spellTypesWizard = new DdSpells(DdSpells.WIZARD_TYPE);
			__map = new DdMap();
			__player = new DdPlayer();
			__state = new DdGameState();
			__state.difficulty = 1; //__J4 = 1; //difficulty
			__state.resetOnLevelComplete = 1;
						
			__commands = new Array("PASS", "MOVE", "OPEN DOOR", "SEARCH FOR TRAPS AND SECRET DOORS", "SWITCH WEAPON HN HAND", "FIGHT", "LOOK AROUND", "SAVE GAME", "USE MAGIC", "BUY MAGIC", "PASS", "BUY H.P.", "SAVE", "MAP", "STATS", "EQUIPMENT", "CLERICAL SPELLS", "SPELLS");

			__cheatCount = 0;
			
			__monsterDB = new DdMonsters();
			__monster = __monsterDB.getMonsterByID(0);  //no monster
			
			__player.inventory.addItem(__itemTypes.item(0));
			__player.equip(0);
			
			DD1_Run();
			
			//DEBUG
			/*
			__player.name = "SHAVS";
			__player.rollStats();
			__player.classification = "FIGHTER";
			__player.inventory.addItem(__itemTypes.item(2));
			__player.inventory.addItem(__itemTypes.item(10));
			__player.inventory.addItem(__itemTypes.item(11));
			__player.inventory.addItem(__itemTypes.item(12));
			__player.inventory.addItem(__itemTypes.item(13));
			__player.inventory.addItem(__itemTypes.item(14));
			__player.inventory.addItem(__itemTypes.item(15));
			
			nextAction(setupDungeon, "SETUP");
			*/
		}
		
		private function onMapClick(e:Event):void
		{
			if (__map.generated)
			{
				__txtMap.removeEventListener(MouseEvent.MOUSE_DOWN, onMapClick);
				__showHUD = true;
				__player.HP = 100;
				showHUD();
			}
		}
		
		private function nextAction(func:Function, label:String="na"):void //, args:Array=null, callback:Function=null, label:String=""):void
		{
			__pendingAction = new DdPendingAction(label, func, 1);
			
			/*
			__debug.msg("nextFunction: " + label + ": " + func);
			__pendingFunction = func;
			__pendingArgs = args;
			__pendingCallback = callback;
			*/
		}
			
		private function input(input_handler:Function):void
		{
			__input.read(input_handler);
		}
		
		private function print(msg:String="", carriage_return:Boolean=true):void
		{
			__output.print(msg, carriage_return);
			__debug.msg(msg, "3");
		}
		
		private function DD1_Run():void
		{
			//00320 PRINT "     DUNGEONS AND DRAGONS #1"
			//00330 PRINT
			print("     DUNGEONS AND DRAGONS #1");
			print();
						
			//00340 PRINT "DO YOU NEED INSTUCTIONS ";
			//00350 INPUT Q$
			print("DO YOU NEED INSTRUCTIONS:", false);
			input(onQueryInstructions);
		}
		
		private function onQueryInstructions(args:Array):void
		{
			//__debug.msg(" onQueryInstructions: " + args);
			__Q$ = args[0];
			//00360 IF Q$="YES" THEN 01730
			if (__Q$ == "YES")
			{
				whoSaidYouCouldPlay();
			}
			//00370 IF Q$="Y" THEN 00720
			//BUG 720 is not the right place to go
			else if (__Q$ == "Y")
			{
				nextAction(whoSaidYouCouldPlay, "whoSaidYouCouldPlay");
			}
			else
			{
				//00380 PRINT "OLD OR NEW GAME";
				//00390 INPUT Q$
				print("OLD OR NEW GAME:", false);
				input(onQueryOldOrNewGame);
				
			}
		}
		
		private function whoSaidYouCouldPlay():void
		{
			//01730 REM INSTRUCTIONS
			//01740 PRINT "WHO SAID YOU COULD PLAY"
			//01750 STOP
			//01760 GO TO 00380
			print("WHO SAID YOU COULD PLAY");
			print("");
			print("NAME?", false);
			
			input(onQueryPlayersName);
		}
		
		private function onQueryOldOrNewGame(args:Array):void
		{
			//__debug.msg(" onQueryOldOrNewGame: " + args);
			__Q$ = args[0];
			//00400 IF Q$="OLD" THEN 01770
			if (__Q$ == "OLD")
			{
				print("DEBUG: READING OLD GAME");
				__map.load(__state.dungeon);

			}
			else
			{
				//00410 PRINT "DUNGEON #";
				//00420 INPUT D
				print("DUNGEON #:", false);
				input(onQueryDungeonNumber);
			}
		}
		
		private function onQueryDungeonNumber(args:Array):void
		{
			//00421 PRINT "CONTINUES RESET 1=YES,2=NO ";
			//00422 INPUT J6
			__state.dungeon = args[0];
			print("CONTINUES RESET 1=YES,2=NO:", false);
			input(onQueryContinues);
		}
		
		private function onQueryContinues(args:Array):void
		{
			__state.resetOnLevelComplete = int(args[0]);
			//__debug.msg(" onQueryContinues: " + __J6_reset);
			//00430 REM ROLLING CHARICTERISTICS
			//00440 PRINT "PLAYERS NME ";
			//00450 INPUT N$
			print("PLAYER'S NAME:", false);
			input(onQueryPlayersName);
		}
		
		private function onQueryPlayersName(args:Array):void
		{
			var _input:String = args[0];
			//__debug.msg(" onQueryPlayersName: " + args + ", " + _input);
			
			//00460 IF N$<>"SHAVS" THEN 01730
			if (_input == "SHAVS")
			{
				__player.name = _input;
				//00465 FOR M=1 TO 7
				//00466 READ C$(M)
				//00467 NEXT M
				
				
				//00470 FOR M=1 TO 7
				//00490 FOR N=1 TO 3
				//00500 LET R=INT(RND(0)*6+1)
				//00510 LET C(M)=C(M)+R
				//00520 NEXT N
				//00530 IF M<>7 THEN 00550
				//00540 LET C(M)=C(M)*15
				//00550 REM
				//00560 PRINT C$(M);"=";C(M)
				//00570 NEXT M
				
				//ROLL STATS
				//print();
				//print(__player.statsList());
				//00580 PRINT
				print("");
			}
			else
			{
				nextAction(whoSaidYouCouldPlay, "whoSaidYouCouldPlay");
				return;
			}
			
			nextAction(chooseClassification, "chooseClassification");
		}
		
		private function chooseClassification():void
		{
			//00590 PRINT "CLASSIFICATION"
			//00600 PRINT "WHICH DO YOU WANT TO BE"
			//00610 PRINT "FIGHTER ,CLERIC ,OR WIZARD";
			//00620 INPUT C$(0)
			
			print("CLASSIFICATION");
			print("WHICH DO YOU WANT TO BE");
			print("FIGHTER ,CLERIC ,OR WIZARD:", false);
			input(onQueryClassification);
		}
		
		private function onQueryClassification(args:Array):void
		{
			var _class:String = args[0];
			/*
			00625 IF C$(0)<>"NONE" THEN 0630
			00626 FOR M7=0 TO 7
			00627 LET C(M7)=0
			00628 NEXT M7
			00629 GO TO 00470
			*/
			

			if (_class == "NONE")
			{
				__player.rollStats();
				print(__player.statsList());
				nextAction(chooseClassification, "chooseClassification");
			}
			else
			{
				//00630 IF C$(0)="FIGHTER" THEN 00770
				//00640 IF C$(0)="CLERIC" THEN 00810
				//00650 IF C$(0)="WIZARD" THEN 00790
				//00660 GO TO 00620
				
				switch(_class)
				{
					case "FIGHTER":
					{
						__player.classification = "FIGHTER";
						break;
					}
					case "CLERIC":
					{
						__player.classification = "CLERIC";
						break;
					}
					case "WIZARD":
					{
						__player.classification = "WIZARD";
						break;
					}
						
					default:
					{
						__player.classification = "FIGHTER";
						break;
					}
				}

				//00670 PRINT "BUYING WEAPONS"
				//00680 PRINT "FAST OR NORM"
				//00690 INPUT Q3$
				print("BUYING WEAPONS");
				print("FAST OR NORM:", false);
				input(onQueryBuyingWeapons);
			}
		}
		
		private function onQueryBuyingWeapons(args:Array):void
		{
			var _input:String = args[0];
			//00700 PRINT "NUMBER","ITEM","PRICE"
			//00705 PRINT"-1-STOP"
			
			print();
			print("NUMBER\tITEM\tPRICE");
			print("-1-STOP");
			print("");
			
			//00710 FOR M=1 TO 15
			//00720 READ I$(M),P(M)
			//00725 IF Q3$="FAST" THEN 00740
			//00730 PRINT M,I$(M),P(M)
			//00740 NEXT M
			
			if (_input == "NORM")
			{
				print(__itemTypes.itemList());
			}
			
					
			//00750 GOSUB 01150 //SET UP MONSTER TYPES
			//__monsterDB = new DdMonsters();
			//__monster = __monsterDB.getMonsterByID(0);  //no monster
			
			//00760 GO TO 00830
			nextAction(Dd0830, "Dd0830 BUY");
		}
			
			
		private function Dd0830():void
		{	
			//00830 REM
			//00850 LET X=X+1
			//00860 INPUT Y
			print ("ITEM TO BUY:", false);
			input(onQueryStorePurhase);
		}
		
		private function onQueryStorePurhase(args:Array):void
		{
			var _input:int = args[0];
			//__inventoryCount++;
			/*
			00870 REM
			00880 IF Y<0 THEN 01000
			00885 IF Y>15 THEN 01000
			00890 IF C(7)-P(Y)<0 THEN 00970
			00900 IF C$(0)="CLERIC" THEN 01290
			00910 IF C$(0)="WIZARD" THEN 01350
			
			00920 REM
			00930 LET C(7)=C(7)-P(Y)
			00940 PRINT "GP= ";C(7)
			00950 LET W(X)=Y
			00960 GO TO 00830
			00970 PRINT "COSTS TOO MUCH"
			00980 PRINT "TRY AGAIN ";
			00990 GO TO 00860
			01000 PRINT "GP= ";C(7)
			*/
			
			if ((_input >= 1) && (_input <= 15))
			{
				var item:DdItem = __itemTypes.item(_input);
				print(item.name + ": ", false); //DEBUG
				
				if ((__player.GOLD - item.price) < 0)
				{
					print("COSTS TOO MUCH");
					print("TRY AGAIN:", false);
					input(onQueryStorePurhase);
				}
				else if (__player.classification == "CLERIC")
				{
					//01290 IF Y=4 THEN 00920
					//01300 IF Y=8 THEN 00920
					//01310 IF Y=9 THEN 00920
					//01320 IF Y>10 THEN 00920
					//01330 PRIT "YOUR A CLERIC YOU CANT USE THAT "
					//01340 GO TO 00860
					
					if ((_input == 4) || (_input == 8) || (_input == 9) || (_input > 10))
					{
						//00920 REM
						//00930 LET C(7)=C(7)-P(Y)
						//00940 PRINT "GP= ";C(7)
						//00950 LET W(X)=Y
						//00960 GO TO 00830
						
						__player.GOLD = __player.GOLD - item.price;
						print("GP= " + __player.GOLD, false);
						//__W[__inventoryCount++] = _input -1;
						__player.inventory.addItem(item);
						input(onQueryStorePurhase);
					}
					else
					{
						print("YOU'RE A CLERIC YOU CANT USE THAT ", false);
						input(onQueryStorePurhase);
					}
				}
				else if (__player.classification == "WIZARD")
				{
					//01350 IF Y=3 THEN 00920
					//01360 IF Y=8 THEN 00920
					//01370 IF Y>10 THEN 00920
					//01380 PRINT "YOUR A WIZARD YOU CANT USE THAT "
					//01390 GO TO 00860
					
					if ((_input == 3) || (_input == 8) || (_input > 10))
					{
						//00920 REM
						//00930 LET C(7)=C(7)-P(Y)
						//00940 PRINT "GP= ";C(7)
						//00950 LET W(X)=Y
						//00960 GO TO 00830
						
						__player.GOLD = __player.GOLD - item.price;
						print("GP= " + __player.GOLD, false);
						//__W[__inventoryCount++] = _input -1;
						__player.inventory.addItem(item);
						input(onQueryStorePurhase);
					}
					else
					{
						print("YOU'RE A WIZARD YOU CANT USE THAT ", false);
						input(onQueryStorePurhase);
					}
				}
				else
				{
					__player.GOLD = __player.GOLD - item.price;
					print("GP= " + __player.GOLD, false);
					print("");
					print("ITEM TO BUY:", false)
					//__W[__inventoryCount++] = _input -1;
					__player.inventory.addItem(item);
					input(onQueryStorePurhase);
				}
			}
			else
			{
				print();
				nextAction(exitStore, "exitStore");
			}
		}
		
		private function exitStore():void
		{
			//01010 REM
			//01020 PRINT "EQ LIST ";
			//01030 INPUT Q$
			print("EQ LIST:", false);
			input(onQueryEQList);
		}
		
		private function onQueryEQList(args:Array):void
		{
			var _input:String = args[0];
			/*
			01040 IF Q$="NO" THEN 01090
			01050 FOR M=1 TO X
			01060 IF W(M)=0 THEN 01080
			01070 PRINT W(M),I$(W(M))
			01080 NEXT M
			01090 PRINT "YOUR CHARACTERISTICS ARE;"
			01100 PRINT C$(0)
			01101 IF C(0)<>1 THEN 01110
			01102 C(0)=2
			01110 PRINT "HIT POINTS",C(0)
			01120 PRINT
			01130 PRINT
			01140 GO TO 01400
			*/
			
			if (_input == "NO")
			{
				
			}
			else
			{
				print();
				print(__player.inventory.inventoryList());
			}
			
			print();
			print();
			print("YOUR CHARACTERISTICS ARE:");
			if (__player.HP == 1) __player.HP = 2;
			//print("HIT POINTS " + __player.HP);
			print(__player.statsList()); //DEBUG
			print();
			
			nextAction(setupDungeon, "setupDungeon");
		}
		
		private function setupDungeon():void
		{
			//__debug.msg("setupDungeon");
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
			
			__map.generate(__state.dungeon);
			var player_coords:Point = __map.getRandomFreeTile();
			__player.x = player_coords.x;
			__player.y = player_coords.y;
			
			//print(__map.map(__state));
			//print();
			
			//01470 REM YEA START
			//01480 PRINT
			//01490 PRINT
			//01500 PRINT
			//01510 PRINT "WELCOME TO DUNGEON #";D
			//01520 PRINT "YOU ARE AT (";G;",";H;")"
			//01530 PRINT
			//01540 PRINT "COMANDS LIST",
			//01541 INPUT Q$
			
			input(start);
		}
		
		private function start(args:Array):void
		{
			print();
			print();
			print("WELCOME TO DUNGEON #" + __state.dungeon);
			print("YOU ARE AT (" + __player.x + "," + __player.y + ")");
			print();
			
			nextAction(Dd1542, "Dd1542");
			
		}
		
		private function Dd1542():void
		{
			
			//__debug.msg("Dd1542: Command List:");
			
			//01542 IF Q$<>"YES" THEN 01590
			//01550 PRINT
			//01560 PRINT "1=MOVE  2=OPEN DOOR  3=SEARCH FOR TRAPS AND SECRET DOORS"
			//01570 PRINT "4=SWITCH WEAPON HN HAND  5=FIGHT"
			//01580 PRINT "6=LOOK AROUND  7=SAVE GAME  8=USE MAGIC  9=BUY MAGIC"
			//01585 PRINT"0=PASS  11=BUY H.P."
			
			
			print("1=MOVE  2=OPEN DOOR  3=SEARCH FOR TRAPS AND SECRET DOORS");
			print("4=SWITCH WEAPON HN HAND  5=FIGHT");
			print("6=LOOK AROUND  7=SAVE GAME  8=USE MAGIC  9=BUY MAGIC");
			print("0=PASS  11=BUY H.P.  13-FULL MAP (CHEAT)");
			print("COMMAND:");
			input(onCommand);
			
			__map.revealTile(__player.x, __player.y);
			showHUD();
						
		}
		
		private function Dd1590():void
		{
			//01590 PRINT "COMMAND=";
			//01600 INPUT T

			//__debug.msg("Dd1590: Command prompt:");
			print("COMMAND:");
			input(onCommand);
			
			__map.revealTile(__player.x, __player.y);
			showHUD();
		}
		
		private function onCommand(args:Array):void
		{
			__debug.clear();
			//__debug.msg("onCommand: " + args);
			var _input:int = args[0];
			
			/*
			01605 IF T=11 THEN 10830
			01606 IF T=12 THEN 11000
			01610 IF T=1 THEN 02170
			01620 IF T=2 THEN 03130
			01630 IF T=3 THEN 03430
			01640 IF T=4 THEN 03640
			01650 IF T=5 THEN 03750
			01660 IF T=6 THEN 06390
			01670 IF T=7 THEN 06610
			01680 IF T=8 THEN 08680
			01690 IF T=9 THEN 09980
			01700 IF T=10 THEN 10730
			01705 IF T=0 THEN 07000
			01710 PRINT "COME ON ";
			01720 GO TO 01590
			*/
			
			//DEBUG
			if (_input >= 0 && _input <=12)
			{
				print();
				print(__commands[_input]);
				print();
			}
			
			switch(_input)
			{
				case 0: //PASS
				{
					nextAction(Dd7000, "Dd7000");
					break;
				}
				case 1: //MOVE
				{
					nextAction(Dd2170, "Dd2170 query move");
					break;
				}
				case 2: //OPEN DOOR
				{
					nextAction(openDoor, "openDoor");
					break;
				}
				case 3: //SEARCH FOR TRAPS AND SECRET DOORS
				{
					nextAction(search, "search");
					break;
				}
				case 4://SWITCH WEAPON HN HAND
				{
					nextAction(chooseWeapon, "chooseWeapon");
					break;
				}
				case 5: //FIGHT
				{
					nextAction(Dd3750, "Dd3750");
					break;
				}
				case 6: //LOOK AROUND
				{
					print(__map.map(__player, __monster));
					nextAction(Dd1590, "Dd1590");
					break;
				}
				case 7: //SAVE GAME
				{
					nextAction(Dd1590, "Dd1590");
					break;
				}
				case 8: //USE MAGIC
				{
					nextAction(useSpells, "useSpells");
					break;
				}
				case 9: //BUY MAGIC
				{
					nextAction(Dd9980, "Dd9980");
					break;
				}
				case 10: //PASS
				{
					nextAction(Dd7000, "Dd7000");
					break;
				}
				case 11: //BUY H.P.
				{
					nextAction(buyHP, "buyHP");
					break;
				}
				case 12: //SAVE DUNGEON
				{
					nextAction(Dd1590, "Dd1590");
					break;
				}
				case 13: //CHEAT: View full map
				{
					__cheatCount++;
					print(__map.map(__player, __monster, true));
					nextAction(Dd1590, "Dd1590");
					break;
				}
				case 14: //CHEAT: Stats
				{
					__cheatCount++;
					print(__player.statsList()); //DEBUG
					nextAction(Dd1590, "Dd1590");
					break;
				}
				case 15: //CHEAT: Equipment
				{
					__cheatCount++;
					print(__player.inventory.inventoryList()); //DEBUG
					nextAction(Dd1542);
					break;
				}
				case 16: //CHEAT: Clerical Spells
				{
					__cheatCount++;
					print();
					print(__player.clericSpells.inventoryList()); //DEBUG
					print();
					nextAction(Dd1542);
					break;
				}
				case 17: //CHEAT: Spells
				{
					__cheatCount++;
					print();
					print(__player.spells.inventoryList()); //DEBUG
					print();
					nextAction(Dd1542);
					break;
				}
					
				default:
				{
					print();
					print("COME ON ");
					print();
					nextAction(Dd1590, "Dd1590");
					break;
				}
			}
		}
		
		private function Dd2170():void
		{
			//02170 REM MOVE
			//02175 PRINT "YOU ARE AT ";G;" , ";H
			//02180 PRINT "  DOWN  RIGHT  LEFT  OR  UP"
			//02190 INPUT Q$
			print("YOU ARE AT (" + __player.x + "," + __player.y + ")");
			print("  DOWN  RIGHT  LEFT  OR  UP:", false);
			input(onMoveDirection);
		}
		
		private function onMoveDirection(args:Array):void
		{
			var _input:String = args[0];
			
			//02200 IF Q$="RIGHT" THEN 02260
			//02205 IF Q$="R" THEN 02260
			//02210 IF Q$="LEFT" THEN 02290
			//02215 IF Q$="L" THEN 02290
			//02220 IF Q$="UP" THEN 02320
			//02225 IF Q$="U" THEN 02320
			//02230 IF Q$="DOWN" THEN 02350
			//02235 IF Q$="D" THEN 02350
			//02240 GO TO 02180

			
			switch(_input.charAt(0))
			{
				case "D":
				{
					nextAction(Dd7000, "Dd7000 after move");
					move(0,1);
					break;
				}
				case "R":
				{
					nextAction(Dd7000, "Dd7000 after move");
					move(1,0);
					break;
				}
				case "L":
				{
					nextAction(Dd7000, "Dd7000 after move");
					move(-1,0);
					break;
				}
				case "U":
				{
					nextAction(Dd7000, "Dd7000 after move");
					move(0,-1);
					break;
				}
				case "M":
				{
					__cheatCount++;
					print(__map.map(__player, __monster));
					nextAction(Dd2170, "Dd2170 query move");
					break;
				}
				case "S":
				{
					__cheatCount++;
					print(__player.statsList()); //DEBUG
					nextAction(Dd2170, "Dd2170 query move");
					break;
				}
					
				default:
				{
					nextAction(Dd1590, "Dd1590");
					break;
				}
			}
			
			showHUD();
			
		}
		
		public function showHUD():void
		{
			//DEBUG
			if (__showHUD)
			{
				__txtMap.text = __map.map(__player, __monster, true, false);
				__txtStats.text = __player.statsList();
				__txtStats.text += "\n" + __monster.statsList();
			}
		}
		
		public function move(x:int, y:int):void
		{
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
			8 potion CON + 1, then poison check: IF RND(0)>.2 then C(0)=C(0)-INT(RND(0)*4+1)
			print HP
			finish move
			
			*/
			var pendingTileType:int = __map.getTileType(__player.x + x, __player.y + y, __monster);
			
			//__debug.msg("  pendingTileType: " + pendingTileType);
			
			
			switch(pendingTileType)
			{
				case 0: //OPEN
				{
					//MOVE
					//02430 LET G=G+S
					//02440 LET H=H+T
					//02450 PRINT "DONE"
					//02460 GO TO 07000
					
					__player.x += x;
					__player.y += y;
					print("DONE");
					break;
				}
				case 1: //WALL
				{
					/*
					02470 REM
					02480 PRINT "YOU RAN INTO A WALL"
					02490 IF RND(0)*12+1>9 THEN 02520
					02500 PRINT "BUT NO DAMAGE WAS INFLICTED"
					02510 GO TO 07000
					02520 PRINT "AND LOOSE 1 HIT POINT"
					02530 LET C(0)=C(0)-1
					02540 GO TO 07000
					*/
					print("YOU RAN INTO A WALL");
					if ((DdRoll.D(12)+1) > 9)
					{
						print("AND LOOSE 1 HIT POINT");
						__player.HP -= 1;
					}
					else
					{
						print("BUT NO DAMAGE WAS INFLICTED");
					}
					nextAction(Dd7000, "Dd7000 ran into a wall");
					break;
				}
				case 2: //TRAP
				{
					__player.x += x;
					__player.y += y;
					//__map.clearTile(__player.x, __player.y);
					nextAction(Dd2550, "Dd2550");
					break;
				}
				case 3: //SECRET DOOR
				{
					/*
					SECRET DOOR
					02990 IF INT(RND(0)*6)+1>4 THEN 0300
					03000 GO TO 02480
					03010 PRINT "YOU JUST RAN INTO A SECRET DOOR"
					03020 PRINT "AND OPENED IT"
					03030 LET G=G+S
					03040 LET H=H+T
					03050 GO TO 02450
					*/
					if ((DdRoll.D(6)+1) > 4)
					{
						print("YOU JUST RAN INTO A SECRET DOOR");
						print("AND OPENED IT");
						__player.x += x;
						__player.y += y;
					}
					print("DONE");
					break;
				}
				case 4: //DOOR
				{
					print("DOOR");
					break;
				}
				case DdMap.TILE_ID_MONSTER: //MONSTER
				{
					//03060 PRINT "YOU RAN INTO THE MONSTER "
					//03070 PRINT "HE SHOVES YOU BACK"
					//03080 PRINT
					//03090 IF INT(RND(0)*2)+1=2 THEN 03120
					//03100 PRINT "YOU LOOSE 6 HIT POINT "
					//03110 LET C(0)=C(0)-6
					//03120 GO TO 07000
					
					print("YOU RAN INTO THE MONSTER ");
					print("HE SHOVES YOU BACK");
					print();
					
					if ((DdRoll.D(2) + 1) == 2)
					{
						//nothing
					}
					else
					{
						print("YOU LOOSE 6 HIT POINT ");
						__player.HP -= 6;
					}
					nextAction(Dd7000, "Dd7000 ran into monster");
					break;
				}
				case 6: //GOLD
				{
					/*
					02413 PRINT "AH......GOLD......."
					02414 G9=INT(RND(0)*500+10)
					02415 PRINT G9;"PIECES"
					02416 C(7)=C(7)+G9
					02417 PRIT "GP= ";C(7)
					*/
					print("AH......GOLD.......");
					var gp:int = DdRoll.D(500) + 10;
					print(gp + " PIECES");
					__player.GOLD += gp;
					print("GP= " + __player.GOLD);
					poisonCheck();
					__player.x += x;
					__player.y += y;
					__map.clearTile(__player.x, __player.y);
					print("DONE");
					break;
				}
				case 7: //POTION STR +1
				{
					//POTION STR +1 then poison check
					//02424 LET C(1)=C(1)+1
					//02425 GO TO 02418
					
					print("POTION STR +1"); //DEBUG
					__player.STR += 1;
					poisonCheck();
					__player.x += x;
					__player.y += y;
					__map.clearTile(__player.x, __player.y);
					print("DONE");
					break;
				}
				case 8: //POTION CON +1
				{
					//POTION CON +1 then poison check
					//02426 LET C(3)=C(3)+1
					//02429 GO TO 02418
					
					print("POTION CON +1"); //DEBUG
					__player.CON += 1;
					poisonCheck();
					__player.x += x;
					__player.y += y;
					__map.clearTile(__player.x, __player.y);
					print("DONE");
					break;
				}
					
				default:
				{
					break;
				}
			}
			
			//GO TO 07000
			//__debug.msg("  nextFunction: Dd7000");
			//nextAction(Dd7000, "Dd7000 after move");
			
			
			/*
			02250 REM
			02260 LET S=0
			02270 LET T=1
			02280 GO TO 02370
			02290 LET S=0
			02300 LET T=-1
			02310 GO TO 02370
			02320 LET S=-1
			02330 LET T=0
			02340 GO TO 02370
			02350 LET S=1
			02360 LET T=0
			02370 IF D(G+S,H+T)=0 THEN 02430
			02380 IF D(G+S,H+T)=1 THEN 02480
			02390 IF D(G+S,H+T)=2 THEN 02550
			02400 IF D(G+S,H+T)=3 THEN 02990
			02401 IF D(G+S,H+T)=7 THEN 02424
			02402 IF D(G+S,H+T)=8 THEN 02426
			02410 IF D(G+S,H+T)=5 THEN 03060
			02411 IF D(G+S,H+T)=6 THEN 02413
			02412 GO TO 02480
			*/
		}
		
		private function Dd2550():void
		{
			/*
			TRAP
			02550 PRINT "OOOOPS A TRAP AND YOU FELL IN "
			02560 IF RND(0)*3>2 THEN 02580
			02570 GO TO 02600
			02580 PRINT "AND HIT POINTS LOOSE 1"
			02590 LET C(0)=C(0)-1
			02600 PRINT "I HOPE YOU HAVE SOME SPIKES AND PREFERABLY ROPE"
			02610 PRINT "LET ME SEE"
			02620 FOR M=1 TO X
			02630 IF W(M)<>12 THEN 02660
			02640 LET W(M)=0
			02650 GO TO 02680
			02660 NEXT M
			02670 GO TO 02740
			02680 FOR M=1 TO X
			02690 IF W(M)<>11 THEN 02720
			02700 LET W(M)=0
			02710 GO TO 02760
			02720 NEXT M
			02730 GO TO 02890
			02740 PRINT "NO SPIKES AH THATS TOO BAD CAUSE YOUR DEAD "
			02750 STOP
			02760 PRINT "GOOD BOTH"
			02770 PRINT "YOU MANAGE TO GET OUT EASY"
			02775 GO TO 02870
			02780 FOR M=1 TO X
			02790 IF W(M)=12 THEN 02820
			02800 NEXT M
			02810 IF B9>1 THEN 02830
			02820 LET W(M)=0
			02830 GO TO 02870
			02840 LET W(M)=0
			02850 LET W(M)=0
			02860 GO TO 02820
			02870 PRINT "YOUR STANDING NEXT TO THE EDGE THOUGH I'D MOVE"
			02880 GO TO 02170
			02890 PRINT "NO ROPE BUT AT LEAS SPIKES"
			02900 IF INT(RND(0)*3)+1=2 THEN 02960
			02910 GO TO 02770
			02920 PRINT "YOU FALL HALF WAY UP"
			02930 IF INT(RND(0)*6)>C(1)/3 THEN 02960
			02940 PRINT "TRY AGAIN "
			02950 GO TO 02900
			02960 PRINT "OOPS H.P. LOOSE 1"
			02970 LET C(0)=C(0)-1
			02980 GO TO 02940
			*/
			
			print("OOOOPS A TRAP AND YOU FELL IN");
			if (DdRoll.D(3) > 2)
			{
				print("AND HIT POINTS LOOSE 1");
				__player.HP -= 1;
			}
			
			print("I HOPE YOU HAVE SOME SPIKES AND PREFERABLY ROPE");
			print("LET ME SEE");
			
			if (__player.inventory.hasItem(12))
			{
				if (__player.inventory.hasItem(13))
				{
					print("GOOD, YOU HAVE BOTH");
					print("YOU MANAGE TO GET OUT EASY");
				}
				else
				{
					print("NO ROPE, BUT YOU HAVE SPIKES");
					
					if (DdRoll.D(6) > (__player.STR /3))
					{
						print("OOPS! YOU LOSE 1 HP, BUT...");
						__player.HP -=1;
					}
				}
					
				print("YOU ARE NOW STANDING PRECARIOUSLY ON THE EDGE");
				print("YOU SHOULD MOVE CAREFULLY");
				nextAction(Dd2170, "Dd2170");				
			}
			else
			{
				print("NO SPIKES! AH, THATS TOO BAD 'CAUSE YOU'RE DEAD");
				nextAction(stop, "stop");
			}
		}
		
		public function poisonCheck():void
		{
			//POISON CHECK
			//02418 D(G+S,H+T)=0
			//02419 IF RND(0)>.2 THEN 02430
			//02420 PRINT "       POISON      "
			//02421 LET C(0)=C(0)-INT(RND(0)*4+1)
			//02422 PRINT "HP= ";C(0)
			//02423 GO TO 02430
			
			__map.clearTile(__player.x, __player.y);
			var poison_roll:Number = Math.random();
			__debug.msg(" poison_roll: " + poison_roll);
			if (poison_roll <= DdRoll.POISON_ROLL_THRESHOLD)
			{
				print("       POISON      ");
				var con_deduction:int = (Math.random()*4)+1;
				__debug.msg("  con_deduction: " + con_deduction);
				__player.CON -= con_deduction;
			}
		}
		
		//MOVE
		private function openDoor():void
		{
			/*
			03130 PRINT "DOOR LEFT RIGHT UP OR DOWN"
			03140 INPUT Q$
			*/
			
			print("DOOR LEFT RIGHT UP OR DOWN");
			input(onQueryDoorDirection);
		}
		
		private function onQueryDoorDirection(args:Array):void
		{
			var q:String = args[0];
			
			/*
			03150 IF Q$="LEFT" THEN 03200
			03155 IF Q$="L" THEN 03200
			03160 IF Q$="RIGHT" THEN 03230
			03165 IF Q$="R" THEN 03230
			03170 IF Q$="UP" THEN 03260
			03175 IF Q$="U" THEN 03260
			03180 IF Q$="DOWN" THEN 03290
			03185 IF Q$="D" THEN 03290
			03190 GO TO 03130
			03200 LET S=0
			03210 LET T=-1
			03220 GO TO 03310
			03230 LET S=0
			03240 LET T=1
			03250 GO TO 03310
			03260 LET S=-1
			03270 LET T=0
			03280 GO TO 03310
			03290 LET S=1
			03300 LET T=0
			03310 IF D(G+S,H+T)=4 THEN 03350
			03320 IF D(G+S,H+T)=3 THEN 03350
			03330 PRINT "THERE IS NOT A DOOR THERE"
			03340 GO TO 01590
			03350 PRINT "PUSH"
			03360 IF INT(RND(0)*20)+1<C(1) THEN 03390
			03370 PRINT "DIDNT BUDGE"
			03380 GO TO 07000
			03390 PRINT "ITS OPEN"
			03400 LET G=G+S
			03410 LET H=H+T
			03420 GO TO 02450

			*/
			
			nextAction(Dd7000, "Dd7000");
			
			switch(q)
			{
				case "LEFT":
				{
					if ((__map.getTileType(__player.x -1, __player.y) == 3) ||(__map.getTileType(__player.x -1, __player.y) == 4))
					{
						print("DOOR OPENED!");
						__map.clearTile(__player.x -1, __player.y);
					}
					break;
				}
				case "RIGHT":
				{
					if ((__map.getTileType(__player.x +1, __player.y) == 3) ||(__map.getTileType(__player.x +1, __player.y) == 4))
					{
						print("DOOR OPENED!");
						__map.clearTile(__player.x +1, __player.y);
					}
					break;
				}
				case "UP":
				{
					if ((__map.getTileType(__player.x, __player.y -1) == 3) ||(__map.getTileType(__player.x, __player.y -1) == 4))
					{
						print("DOOR OPENED!");
						__map.clearTile(__player.x, __player.y -1);
					}
					break;
				}
				case "DOWN":
				{
					if ((__map.getTileType(__player.x, __player.y +1) == 3) ||(__map.getTileType(__player.x, __player.y +1) == 4))
					{
						print("DOOR OPENED!");
						__map.clearTile(__player.x, __player.y +1);
					}
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
		
		private function search():void
		{
			/*
			03430 PRINT "SEARCH.........SEARCH...........SEARCH..........."
			03440 IF INT(RND(0)*40)<C(5)+C(6) THEN 03470
			03450 PRINT "NO NOT THAT YOU CAN TELL"
			03460 GO TO 07000
			03470 FOR M=-1 TO 1
			03480 FOR N=-1 TO 1
			03490 IF D(G+M,H+N)=2 THEN 03550
			03500 IF D(G+M,H+N)=3 THEN 03590
			03510 NEXT N
			03520 NEXT M
			
			03530 REM
			03540 GO TO 03450
			03550 PRINT "YES THERE IS A TRAP"
			03560 PRINT "IT IS ";M;"VERTICALY  ";N;"HORAZONTALY FROM YOU"
			03570 LET Z=1
			03580 GO TO 03500
			03590 PRINT "YES A DOOR"
			03600 PRINT "IT IS AT ";M;"VERTICALY  ";N;"HORAZANTALY"
			03610 LET Z=1
			03620 GO TO 03510
			*/
			
			nextAction(Dd7000, "Dd7000");
			
			print("SEARCH.........SEARCH...........SEARCH...........");
			print("TRAPS?");
			print(__map.locate(2,__player));
			print("SECRET DOORS?");
			print(__map.locate(3,__player));
			print("DOORS?");
			print(__map.locate(4,__player));
			
		}
		
		private function chooseWeapon():void
		{
			/*
			03630 REM
			03640 PRINT "WHICH WEAPON WILL YOU HOLD, NUM OF WEAPON "
			03650 INPUT Y
			*/
			
			print("WHICH WEAPON WILL YOU HOLD, NUM OF WEAPON ");
			input(onQueryWhichWeapon);
		}
		
		private function onQueryWhichWeapon(args:Array):void
		{
			var q:String = args[0];
			var _input:int = int(q);
			
			/*
			03660 IF Y=0 THEN 03720
			03670 FOR M=1 TO X
			03680 IF W(M)=Y THEN 03720
			03690 NEXT M
			03700 PRINT "SORRY YOU DONT HAVE THAT ONE"
			03710 GO TO 03640
			03720 PRINT "O.K. YOU ARE NOW HOLDING A ";I$(Y)
			03730 LET J=Y
			03740 GO TO 07000
			*/
			
			nextAction(Dd7000, "Dd7000");
			
			if (__player.inventory.hasItem(_input))
			{
				__player.equip(_input);
				print("O.K. YOU ARE NOW HOLDING A " + __player.equippedItem.name);
			}
			else
			{
				print("SORRY YOU DONT HAVE THAT ONE");
			}
			
		}
		
		private function Dd3750():void
		{
			/*
			03750 REM FIGHTING BACK
			03760 PRINT "YOUR WEAPON IS ";I$(J)
			03770 IF K=0 THEN 01590  //goto command prompt
			03780 PRINT B$(K)
			03790 PRINT "HP=";B(K,3)
			03800 IF J=0 THEN 04460
			03810 IF J=1 THEN 04680
			03820 IF J=2 THEN 04860
			03830 IF J=3 THEN 05040
			03840 IF J=4 THEN 05270
			03850 IF J>4 THEN 03870
			03860 GO TO 03880
			03870 IF J<15 THEN 05450
			03880 PRINT "FOOD ???.... WELL O.K."
			03890 PRIN'T "IS IT TO HIT OR DISTRACT";
			03900 INPUT Q$
			*/
			
			
			
			print("YOUR WEAPON IS: " + __player.equippedItem.name);
			
			if (__monster.id == 0)
			{
				//NOTHING
				nextAction(Dd1590, "Dd1590");
			}
			else
			{
				print(__monster.name);
				
				switch(__player.equippedItemID)
				{
					case 0:
					{
						nextAction(Dd4460, "Dd4460");
						break;
					}
					case 1:
					{
						nextAction(Dd4680, "Dd4680");
						break;
					}
					case 2:
					{
						nextAction(Dd4860, "Dd4860");
						break;
					}
					case 3:
					{
						nextAction(Dd5040, "Dd5040");
						break;
					}
					case 4:
					{
						nextAction(Dd5270, "Dd5270");
						break;
					}
					case 5:
					case 6:
					case 7:
					case 8:
					case 9:
					case 10:
					case 11:
					case 12:
					case 13:
					case 14:
					{
						nextAction(Dd5440, "Dd5440");
						break;
					}
					case 15:
					{
						print("FOOD ???.... WELL O.K.");
						print("IS IT TO HIT OR DISTRACT");
						input(onQueryHitOrDistract);
						break;
					}
						
					default:
					{
						nextAction(Dd1590, "Dd1590");
						break;
					}
				}
			}
		}
		
		private function onQueryHitOrDistract(args:Array):void
		{
			var q:String = args[0];
			
			/*
			03910 IF Q$="HIT" THEN 04330
			03920 PRINT "THROW A-A=VE,B-BELOW,L-LEFT,OR R-RIGHT OF THE MONSTER";
			03930 LET Z5=0
			03940 INPUT Q$
			*/
			
			if (q == "HIT" || q == "H")
			{
				nextAction(Dd4330, "Dd4330")
			}
			else
			{
				print("THROW A-ABOVE, B-BELOW, L-LEFT, OR R-RIGHT OF THE MONSTER");
				input(onQueryThrowDirection); //3950
			}
			
			
		}
		
		//3950
		private function onQueryThrowDirection(args:Array):void
		{
			var q:String = args[0];
			
			/*
			03950 IF Q$="B" THEN 04010
			03960 IF Q$="A" THEN 04040
			03970 IF Q$="L" THEN 04070
			03980 LET S=0
			03990 LET T=1
			04000 GO TO 04120
			04010 LET S=-1
			04020 LET T=0
			04030 GO TO 04120
			04040 LET S=1
			04050 LET T=0
			04060 GO TO 04120
			04070 LET S=0
			04080 LET T=-1
			04090 GO TO 04120
			04100 IF Z5=1 THEN 04120
			04110 IF RND(0)>.5 THEN 04140
			04120 IF D(F1+S,F2+T)=0 THEN 04220
			04130 IF D(F1+S,F2+T)=2 THEN 04280
			04140 PRINT "DIDN'T WORK"
			04150 FOR M=1 TO X
			04160 IF Z5=Q THEN 07000
			04170 IF W(M)=15 THEN 04190
			04180 NEXT M
			04190 LET W(M)=0
			04200 LET J=0
			04210 GO TO 07000
			04220 PRINT "MONSTER MOVED BACK"
			04230 LET D(F1,F2)=0
			04240 LET F1=F1+S
			04250 LET F2=F2+T
			04260 LET D(F1,F2)=5
			04270 GO TO 04150
			04280 PRINT "GOOD WORK THE MONSTER FELL INTO A TRAP AND IS DEAD"
			04290 LET K1=-1
			04300 LET B(K,6)=0
			04310 GO TO 07000
			04320 GO TO 04150
			*/
			
			var target_x:int = 0;
			var target_y:int = 0;
			
			switch(q)
			{
				case "B":
				{
					target_x = 0;
					target_y = -1;
					break;
				}
				case "A":
				{
					target_x = 0;
					target_y = 1;
					break;
				}
				case "L":
				{
					target_x = -1;
					target_y = 0;
					break;
				}
				case "R":
				{
					target_x = 1;
					target_y = 0;
					break;
				}
				default:
				{
					break;
				}
			}
			
			if (__map.getTileType(__monster.x + target_x, __monster.y + target_x) == 0)
			{
				print("MONSTER MOVED BACK");
				__monster.x += target_x;
				__monster.y += target_y;
				__player.dropEquippedItem();
			}
			else if (__map.getTileType(__monster.x + target_x, __monster.y + target_x) == 2)
			{
				print("GOOD WORK THE MONSTER FELL INTO A TRAP AND IS DEAD");
				__monster.alive = false;
				__monster.HP = 0;
			}
			
			nextAction(Dd7000, "Dd7000");
				
		}

		private function Dd4460():void
		{
			/*
			04460 REM FISTS
			04470 PRINT "DO YOU REALIZE YOU ARE BARE HANDED"
			04480 PRINT "DO YOU WANT TO MAKE ANOTHER CHOICE";
			04490 INPUT Q$
			*/
			
			print("DO YOU REALIZE YOU ARE BARE HANDED");
			print("DO YOU WANT TO MAKE ANOTHER CHOICE");
			input(onQueryChooseAnotherWeapon);
			
		}
		
		private function Dd4330():void
		{
			/*
			04330 IF INT(RND(0)*20)+1=20 THEN 04380
			04340 IF INT(RND(0)*20)+1>B(K,2)-C(2)/3 THEN 04410
			04350 IF INT(RND(0)*20)+1>10-C(2)/3 THEN 04440
			
			04360 PRINT "TOTAL MISS"
			04370 GO TO 04150
			04380 PRINT "DIRECT HIT"
			04390 LET B(K,3)=B(K,3)-INT(C(1)/6)
			
			04400 REM
			04410 PRINT "HIT"
			04420 LET B(K,3)=B(K,3)-INT(C(1)/8)
			04430 GO TO 04150
			04440 PRINT "YOU HIT HIM BUT NOT GOOD ENOUGH"
			04450 GO TO 04150
			*/
			var roll:int = DdRoll.D(20) + 1;
			
			if (roll == 20)
			{
				print("DIRECT HIT");
				__monster.HP -= __player.STR/6;
			}
			else if (roll > (__monster.stat2 - (__player.DEX/3)))
			{
				print("HIT");
				__monster.HP -= __player.STR/8;
			}
			else if (roll > (10 - __player.DEX/3))
			{
				print("YOU HIT HIM BUT NOT GOOD ENOUGH");
			}
			else
			{
				print("TOTAL MISS");
			}
			
			__player.dropEquippedItem();
			nextAction(Dd7000, "Dd7000");
		}
		
		private function onQueryChooseAnotherWeapon(args:Array):void
		{
			var q:String = args[0];
			
			/*
			04500 IF Q$="NO" THEN 04520
			04510 GO TO 01590
			04520 PRINT"O.K. PUNCH BITE SCRATCH HIT ........"
			04530 FOR M=-1 TO 1
			04540 FOR N=-1 TO 1
			04550 IF D(G+M,H+N)=5 THEN 04610
			04560 NEXT N
			04570 NEXT M
			04580 PRINT "NO GOOD ONE"
			04590 GO TO 01590
			
			04600 REM
			04610 IF INT(RND(0)*20)+1>B(K,2) THEN 04640
			04620 PRINT "TERRIBLE NO GOOD"
			04630 GO TO 07000
			04640 PRINT "GOOD A HIT"
			04650 LET B(K,3)=B(K,3)-INT(C(1)/6)
			04660 GO TO 01590
			*/
			
			nextAction(Dd1590, "Dd1590");
			
			if (q == "NO")
			{
				print("O.K. PUNCH BITE SCRATCH HIT ........");
				if (__map.isMonsterAdjacent(__player, __monster))
				{
					if (DdRoll.D(20)+1 > __monster.stat2)
					{
						print("GOOD A HIT");
						__monster.HP -= __player.STR/6;
					}
					else
					{
						print("TERRIBLE NO GOOD");
						nextAction(Dd7000);
					}
				}
				else
				{
					print("NO GOOD ONE");
				}
			}
			else
			{
				//OK
			}
		}
		
		private function Dd4680():void
		{
			/*
			04670 REM
			04680 PRINT "SWING"
			
			04690 GOSUB 08410
			
			04700 IF R1<2 THEN 04730
			04710 PRINT "HE IS OUT OF RANGE"
			04720 GO TO 07000
			04730 IF R2=0 THEN 04840
			04740 IF R2=1 THEN 04820
			04750 IF R2=2 THEN 04790
			04760 PRINT "CRITICAL HIT"
			04770 LET B(K,3)=B(K,3)-INT(C(1)/2)
			04780 GO TO 01590
			04790 PRINT "GOOD HIT"
			04800 LET B(K,3)=B(K,3)-INT(C(1)*4/5)
			04810 GO TO 01590
			04820 PRINT "NOT GOOD ENOUGH"
			04830 GO TO 01590
			04840 PRINT "MISSED TOTALY"
			04850 GO TO 07000
			*/
			
			nextAction(Dd1590, "Dd1590");
			
			print("SWING");
			Dd8410();
			if (__monster.distance < 2)
			{
				if (__player.attackEffectiveness == 0)
				{
					print("MISSED TOTALLY");
					nextAction(Dd7000, "Dd7000");
				}
				else if (__player.attackEffectiveness == 1)
				{
					print("NOT GOOD ENOUGH");
				}
				else if (__player.attackEffectiveness == 2)
				{
					print("GOOD HIT");
					__monster.HP -= __player.STR * 4/5;
				}
				else if (__player.attackEffectiveness == 3)
				{
					print("CRITICAL HIT");
					__monster.HP -= __player.STR/2;
				}
			}
			else
			{
				print("HE IS OUT OF RANGE");
				nextAction(Dd7000, "Dd7000");
			}
		}
		
		private function Dd4860():void
		{
			/*
			04860 PRINT "SWHNG"
			04870 GOCUB 08410
			04880 IF R1<2.1 THAN 04910
			04890 PRINT "HE IS OUT OF RANGE"
			04900 GO TO 07000
			04910 IF R2=0 THEN 05020
			04920 IF R2=1 THEN 05000
			04930 IF R2=2 THEN 04970
			04940 PRINT "CRITICAL HIT"
			04950 LET B(K,3)=B(K,3)-C(1)
			04960 GO TO 01590
			04970 PRINT "HIT"
			04980 LET B(K,3)=B(K,3)-INT(C(1)*5/7)
			04990 GO TO 01590
			05000 PRINT "HIT BUT ` WELL ENOUGH"
			05010 GO TO 01590
			05020 PRINT "MISSED TOTALY"
			05030 GO TO 07000
			*/
			
			nextAction(Dd1590, "Dd1590");
			
			print("SWING");
			Dd8410();
			if (__monster.distance < 2.1)
			{
				if (__player.attackEffectiveness == 0)
				{
					print("MISSED TOTALLY");
					nextAction(Dd7000, "Dd7000");
				}
				else if (__player.attackEffectiveness == 1)
				{
					print("HIT BUT NOT WELL ENOUGH");
				}
				else if (__player.attackEffectiveness == 2)
				{
					print("HIT");
					__monster.HP -= __player.STR * 5/7;
				}
				else if (__player.attackEffectiveness == 3)
				{
					print("CRITICAL HIT");
					__monster.HP -= __player.STR;
				}
			}
			else
			{
				print("HE IS OUT OF RANGE");
				nextAction(Dd7000, "Dd7000");
			}
		}
		
		private function Dd5040():void
		{
			
			/*
			05040 FOR M=1 TO X
			05050 IF W(M)=3 THEN 05090		// CALL DD1_08410();
			05060 NEXT M
			05070 PRINT"YOU DONT HAVE A DGGER"
			05080 GO TO 07000
			
			05090 GOSUB 08410
						
			05100 IF R1>5 THEN 04710
			05110 IF R2=0 THEN 05200
			05120 IF R2=1 THEN 05220
			05130 IF R2=2 THEN 05240
			05140 PRINT "CRITICAL HIT"
			05150 LET B(K,3)=B(K,3)-INT(C(1)*3/10)
			05160 IF R1<2 THEN 05190
			05170LET W(J)=0
			05180 LET J=0
			05190 GO TO 07000
			05200 PRINT "MISSED TOTALY"
			05210 GO TO 05160
			05220 PRINT "HIT BUT NO DAMAGE"
			05230 GO TO 05160
			05240 PRINT "HIT"
			05250 LET B(K,3)=B(K,3)-INT(C(1)/4)
			05260 GO TO 05160
			*/
			
			nextAction(Dd1590, "Dd1590");
			
			if (__player.inventory.hasItem(3))
			{
				Dd8410();
				if (__monster.distance <= 5)
				{
					if (__player.attackEffectiveness == 0)
					{
						print("MISSED TOTALLY");
						nextAction(Dd7000, "Dd7000");
					}
					else if (__player.attackEffectiveness == 1)
					{
						print("HIT BUT NO DAMAGE");
					}
					else if (__player.attackEffectiveness == 2)
					{
						print("HIT");
						__monster.HP -= __player.STR/4;
					}
					else if (__player.attackEffectiveness == 3)
					{
						print("CRITICAL HIT");
						__monster.HP -= __player.STR * 3/10;
						if (__monster.distance >= 2)
						{
							__player.dropEquippedItem();
						}
					}
				}
				else
				{
					print("HE IS OUT OF RANGE");
					nextAction(Dd7000, "Dd7000");
				}
			}
			else
			{
				print("YOU DONT HAVE A DAGGER");
				nextAction(Dd7000, "Dd7000");
			}
		}
		
		private function Dd5270():void
		{			
			/*
			05270 PRINT "SWING"
			
			05280 GOSUB 08410
			
			05290 IF P0<2 THEN 04720
			05300 GO TO 04710
			05310 IF R2=0 THEN 05420
			05320 IF R2=1 THEN 05400
			05330 IF R2=2 THEN 05370
			05340 PRINT "CRITICAL HIT"
			05350 LET B(K,3)=B(K,3)-INT(C(1)*4/9)
			05360 GO TO 01590
			05370 PRINT "HIT"
			05380 LET B(K,3)=B(K,3)-INT(C(0)*5/11)
			05390 GO TO 01590
			05400 PRINT "HIT BUT NO DAMAGE"
			05410 GO TO 01590
			05420 PRINT "MISS"
			05430 GO TO 07000
			*/
			
			nextAction(Dd1590, "Dd1590");
			
			print("SWING");
			Dd8410();
			if (__monster.distance < 2)
			{
				if (__player.attackEffectiveness == 0)
				{
					print("MISS");
					nextAction(Dd7000, "Dd7000");
				}
				else if (__player.attackEffectiveness == 1)
				{
					print("HIT BUT NO DAMAGE");
				}
				else if (__player.attackEffectiveness == 2)
				{
					print("HIT");
					__monster.HP -= __player.STR * 5/11;
				}
				else if (__player.attackEffectiveness == 3)
				{
					print("CRITICAL HIT");
					__monster.HP -= __player.STR * 4/9;
				}
			}
			else
			{
				print("HE IS OUT OF RANGE");
				nextAction(Dd7000, "Dd7000");
			}
		}
		
		private function Dd5440():void  //use weapon
		{
			/*
			05440 REM
			05450 FOR M=1 TO X
			05460 IF W(M)=J THEN 05500		// CALL DD1_08410();
			05470 NEXT M
			05480 PRINT "NO WEAPON FOUND"
			05490 GO TO 01590
			05500 GOSUB 08410
			05510 IF J=5 THEN 05760
			05520 IF J=6 THEN 05800
			05530 IF J=7 THEN 05840
			05540 IF J=8 THEN 05880
			05550 IF J=9 THEN 05920
			05560 IF J=10 THEN 05960
			05570 IF J=11 THEN 06000
			05580 IF J=12 THEN 06040
			05590 IF J=13 THEN 06080
			05600 PRINT "AS A CLUB OR SIGHT";
			05610 INPUT Q$
			*/
			
			Dd8410();
			
			if (__player.equippedItemID == 0)
			{
				print("NO WEAPON FOUND");
				nextAction(Dd1590, "Dd1590");
			}
			else if (__player.equippedItemID == 14) //silver cross
			{
				print("AS A CLUB OR SIGHT");
				input(onQueryClubOrSight);
			} 
			else
			{
				
				if (__monster.distance > __player.equippedItem.range)
				{
					print("HE IS OUT OF RANGE");
					nextAction(Dd7000, "Dd7000");
				}
				else
				{
					if (__player.attackEffectiveness == 0)
					{
						print("MISS");
						nextAction(Dd7000, "Dd7000");
					}
					else if (__player.attackEffectiveness == 1)
					{
						print("HIT BUT NO DAMAGE");
					}
					else if (__player.attackEffectiveness == 2)
					{
						print("HIT");
						__monster.HP -= __player.STR * __player.equippedItem.hitMultiplier;
					}
					else if (__player.attackEffectiveness == 3)
					{
						print("CRITICAL HIT");
						__monster.HP -= __player.STR * __player.equippedItem.criticalHitMultiplier;
					}
					
					if (__player.equippedItemID == 14)
					{
						nextAction(Dd7000, "Dd7000");
					}
					else
					{
						__player.dropEquippedItem();
						if (__monster.distance >0)
						{
							nextAction(Dd1590, "Dd1590");
						}
						else
						{
							nextAction(Dd7000, "Dd7000");
						}
					}
				}
			}
				
			
			
		}
		
		private function onQueryClubOrSight(args:Array):void
		{
			var q:String = args[0];
			
			/*
			05620 IF Q$="SIGHT" THEN 05650
			05630 IF J=14 THEN 06120
			05640 GO TO 05480
			05650 IF R1<10 THEN 05680
			05660 PRINT "FAILED"
			05670 GO TO 07000
			05680 PRINT "THE MONSTER IS HURT"
			*/
			
			
			/*
			06160 IF R1>R3 THEN 04710
			06170 IF R2=0 THEN 06280
			06180 IF R2=1 THEN 06260
			06190 IF R2=2 THEN 06230
			06200 PRINT "CRITICAL HIT"
			06210 LET B(K,3)=B(K,3)-INT(C(1)*R5)
			06220 GO TO 06300
			06230 PRINT "HIT"
			06240 LET B(K,3)=B(K,3)-INT(C(1)*R4)
			06250 GO TO 06300
			06260 PRINT "HIT BUT NO DAMAGE"
			06270 GO TO 06300
			06280 PRINT "MISS"
			06290 GO TO 06300
			06300 IF W(J)=14 THEN 07000
			06310 FOR M=1 TO X
			06320 IF W(M)=J THEN 06340
			06330 NEXT M
			06340 LET W(M)=0
			06350 IF J<>7 THEN 06360
			06355 GO TO 06370
			06360 LET J=0
			06370 IF R2>0 THEN 01590
			06380 GO TO 07000
			*/
			
			if (q == "SIGHT")
			{
				if (__monster.distance < 10)
				{
					print("THE MONSTER IS HURT");
					if ((__monster.id == 2) || (__monster.id == 10) || (__monster.id == 4))
					{
						print("CRITICAL HIT");
						__monster.HP -= __player.STR * __player.equippedItem.criticalHitMultiplier;
						__player.dropEquippedItem();
						if (__monster.distance >0)
						{
							nextAction(Dd1590, "Dd1590");
						}
						else
						{
							nextAction(Dd7000, "Dd7000");
						}
					}
					else
					{
						print("HIT BUT NO DAMAGE");
					}
				}
				else
				{
					print("FAILED");
					nextAction(Dd7000, "Dd7000");
				}
			}
			else
			{
				if (__monster.distance > __player.equippedItem.range)
				{
					print("HE IS OUT OF RANGE");
					nextAction(Dd7000, "Dd7000");
				}
				else
				{
					if (__player.attackEffectiveness == 0)
					{
						print("MISS");
						nextAction(Dd7000, "Dd7000");
					}
					else if (__player.attackEffectiveness == 1)
					{
						print("HIT BUT NO DAMAGE");
					}
					else if (__player.attackEffectiveness == 2)
					{
						print("HIT");
						__monster.HP -= __player.STR * __player.equippedItem.hitMultiplier;
					}
					else if (__player.attackEffectiveness == 3)
					{
						print("CRITICAL HIT");
						__monster.HP -= __player.STR * __player.equippedItem.criticalHitMultiplier;
					}
					
					__player.dropEquippedItem();
					if (__monster.distance >0)
					{
						nextAction(Dd1590, "Dd1590");
					}
					else
					{
						nextAction(Dd7000, "Dd7000");
					}
				}
			}
		}
		
		private function drawMap():void
		{
			/*
			06390 REM LOOKING
			06400 FOR M=-5 TO 5
			06410 FOR N=-5 TO 5
			06420 IF M+G>25 THEN 06510
			06430 IF M+G<0 THEN 06510
			06440 IF H+N>25 THEN 06510
			06450 IF H+N<0 THEN 06510
			06460 IF M<>0 THEN 06480
			06470 IF N=0 THEN 06590
			06480 IF D(M+G,N+H)=2 THEN 06550
			06485 IF D(M+G,N+H)=7 OR D(M+G,N+H)=8 THEN 06550
			06490 IF D(M+G,N+H)=3 THEN 06570
			06500 PRINT D(M+G,N+H);
			06510 NEXT N
			06520 PRINT
			06530 NEXT M
			06540 GO TO 07000
			06550 PRINT 0;
			06560 GO TO 06510
			06570 PRINT 1;
			06580 GO TO 06510
			06590 PRINT 9;
			06600 GO TO 06510
			*/
		}
		
		/*  Item stats table - now properties of DdItems
		05690 LET R5=1/6
		05700 IF K=2 THEN 06200
		05710 IF K=10 THEN 06200
		05720 IF K=4 THEN 06200
		05730 GOTO 06260
		05740 IF INT(RND(0)*0)>0 THEN 06260
		05750 GO TO 06200
		05760 LET R3=10
		05770 LET R4=3/7
		05780 LET R5=5/11
		05790 GO TO 06160
		05800 LET R3=15
		05810 LET R4=3/7
		05820 LET R5=5/11
		05821 FOR Z=1 TO 100
		05822 IF W(Z)=7 THEN 5825
		05823 NEXT Z
		05824 GO TO 6280
		05825 J=7
		05826 W(Z)=0
		05830 GO TO 06160
		05840 LET R3=1.5
		05850 LET R4=1/7
		05860 LET R5=1/5
		05870 GO TO 06160
		05880 LET R3=4
		05890 LET R4=1/10
		05900 LET R5=1/8
		05910 GO TO 06160
		05920 LET R3=4
		05930 LET R4=1/7
		05940 LET R5=1/6
		05950 GO TO 06160
		05960 LET R3=3
		05970 LET R4=1/8
		05980 LET R5=1/5
		05990 GO TO 06160
		06000 LET R3=5
		06010 LETR4=1/9
		06020 LET R5=1/6
		06030 GO TO 06160
		06040 LET R3=8
		06050 LET R4=1/9
		06060 LET R5=1/4
		06070 GO TO 06160
		06080 LET R3=6
		06090 LET R4=1/3
		06100 LET R5=2/3
		06110 GO TO 06160
		06120 LET R3=1.5
		06130 LET R4=1/3
		06140 LET R5=1/2
		06150 GO TO 06160
		*/
		
		private function saveDungeon():void
		{
			/*
			06610 REM SAVE GAME
			06615 RESTORE #7
			06620 WRITE #7,D
			06630 WRITE #7,X
			06640 WRITE #7,J
			06650 WRITE #7,G
			06660 WRITE #7,H
			06670 WRITE #7,K
			06680 FOR M=0 TO 25
			06690 FOR N=0 TO 25
			06700 WRITE #7,D(M,N)
			06710 NEXT N
			06720 NEXT M
			06730 FOR M=1 TO X
			06740 WRITE #7,W(M)
			06750 NEXT M
			06760 FOR M=1 TO 10
			06770 WRITE #7,B$(M)
			06780 FOR N=1 TO 6
			06790 WRITE #7,B(M,N)
			06800 NEXT N
			06810 NEXT M
			06820 FOR M=0 TO 7
			06830 WRITE #7,C$(M)
			06840 WRITE #7,C(M)
			06850 NEXT M
			06860 WRITE #7,N$
			06870 WRITE #7,F1
			06880 FOR M=1 TO 15
			06890 WRITE #7,I$(M)
			06900 NEXT M
			06910 WRITE #7,X3
			06920 FOR M=1 TO X3
			06930 WRITE #7,X4(M)
			06940 NEXT M
			06950 WRITE #7,X1
			06960 FOR M=1 TO X1
			06970 WRITE #7,X2(M)
			06971 NEXT M
			06972 WRITE #7,F2
			06980 WRITE #7,F1
			06985 GO TO 01590
			06990 STOP
			*/
		}
		
		private function Dd7000():void
		{
			//__debug.msg("Dd7000: ");
			/*
			/*
			07000 IF K1=-1 THEN 08290 //If monster flag is < 0, current monsters is dead
			07010 IF C(0)<2 THEN 08160
			07020 IF K>0 THEN 07160		//CALL DD1_08410();
			07030 IF G<>1 THEN 07110
			07040 IF H<>12 THEN 07110

			*/
			
			__monster.alive = __monster.HP > 0;
			
			if (__monster.id > 0 && !__monster.alive)
			{
				__debug.msg(" monsterKilled: ");
				nextAction(Dd8290, "Dd8290");
			}
			else if (__player.HP < 2)
			{
				__debug.msg(" HP < 2:");
				nextAction(Dd8160, "Dd8160");
			}
			else
			{
				nextAction(Dd7020, "Dd7020 after Dd7000");
			}
		}
		
		private function Dd7020():void
		{
			//__debug.msg("Dd7020: ");
		
			
			if (__monster.id > 0) //monster type
			{
				//__debug.msg(" Monster type > 0: " + __monster.id);
				nextAction(Dd7160, "Dd7160");
			}
			else if ((__player.x == 1) && (__player.y == 12)) //MAGIC NUMBER - in-dungeon store??
			{
				__debug.msg("  At dungeon store: ");
				nextAction(Dd7050, "Dd7050");
			}
			else
			{
				nextAction(Dd7110, "Dd7110");
			}
		}
		
		private function Dd7110():void
		{
			//__debug.msg("  Dd7110: ");
			//07110 IF RND(0)*20>10 THEN 07830
			//07120 GO TO 01590
			
			if (DdRoll.R(20) > 10)
			{
				nextAction(Dd7830, "Dd7830");  //spawn monster
			}
			else
			{
				nextAction(Dd1590, "Dd1590");  //command prompt
			}
		}
		
		private function Dd7050():void
		{
			
			/*
			07050 PRINT "SO YOU HAVE RETURNED"
			07060 IF C(7)<100 THEN 07110
			07070 LET C(7)=C(7)-100
			07080 PRINT "WANT TO BUY MORE EQUIPMENT"
			07090 INPUT Q$
			07100 IF Q$="YES" THEN 07130
			
			07130 PRINT "YOUR H.P. ARE RESTORED 2 POINTS"
			07140 LET C(0)=C(0)+2
			07150 GO TO 00830
			
			*/
			
			print("SO YOU HAVE RETURNED");
			if (__player.GOLD >= 100)
			{
				__player.GOLD -= 100;
				print("WANT TO BUY MORE EQUIPMENT:");
				input(onQueryBuyMoreEquipment);
			}
			else
			{
				nextAction(Dd7110, "Dd7110");
			}
		}
		
		private function onQueryBuyMoreEquipment(args:Array):void
		{
			
			if (args[0] == "YES")
			{
				print("YOUR H.P. ARE RESTORED 2 POINTS");
				__player.HP += 2;
				
				//00830 REM
				//00850 LET X=X+1
				//00860 INPUT Y
				print ("ITEM TO BUY:", false);
				input(onQueryStorePurhase);
			}
			else
			{
				if (Math.random()*20 > 10)
				{
					
				}
			}
		}
		
		private function Dd7160():void //Check Move Monster
		{
			/*
			07160 GOSUB 08410
			
			07170 IF B(K,3)<1 THEN 08290  //BUG? gold?
			07180 IF R1<2.0 THEN 07600
			07190 IF P0>10 THEN 01590  //BUG? should be R1
			
			*/
			
			Dd8410();
			
			if (__monster.gold < 1) //BUG? gold?
			{
				nextAction(Dd8290, "Dd8290");
			}
			else if (__monster.distance < 2.0)
			{
				nextAction(Dd7600, "Dd7600");
			}
			else if (__monster.distance > 10.0)
			{
				nextAction(Dd1590, "Dd1590");
			}
			else
			{
				nextAction(Dd7200, "Dd7200");
			}
		}
		
		private function Dd7200():void //Move Monster
		{
			
			/*
			07200 REM HE IS COMMING
			07210 IF ABS(R8)>ABS(R9) THEN 07260
			07220 LET F5=0
			07230 IF M=1 THEN 07270
			07240 LET F6=-(R9/ABS(R9))
			07250 GO TO 07280
			07260 LET F5=-(R8/ABS(R8))
			07270 LET F6=0
			07280 FOR Q=0 TO 8
			07290 IF Q=1 OR Q=5 THEN 07320
			07300 IF F1+F5<0 OR F1+F5>25 OR F2+F6<0 OR F2+F6>25 THEN 07320
			07310 IF D(F1+F5,F2+F6)=Q THEN 07340
			07320 NEXT Q
			07330 GO TO 07510
			07340 IF Q=0 THEN 07430
			07345 IF Q=6 OR Q=7 OR Q=8 THEN 07430
			07350 IF Q=2 THEN 07530
			07360 IF Q=3 OR Q=4 THEN 07380
			07370 GO TO 07510
			
			07380 REM "THROUGH THE DOOR"
			07390 IF D(F1+2*F5,F2+2*F6)<>0 THEN 07510
			07400 LET F5=F5*2
			07410 LET F6=F6*2
			07420 GO TO 07440
			
			07430 REM "CLOSER"
			07440 LET D(F1,F2)=0
			07450 LET F1=F1+F5
			07460 LET F2=F2+F6
			07470 LET D(F1,F2)=5
			
			07490 REM
			07500 GO TO 01590
			
			07510 REM "NOWHERE"
			07520 GO TO 07490
			*/
			
			var x_move:int = 0;
			var y_move:int = 0;
			var new_x_loc:int = 0;
			var new_y_loc:int = 0;
			
			if (Math.abs(__monster.xOffset) > Math.abs(__monster.yOffset))
			{
				x_move = -1 * __monster.xOffset/Math.abs(__monster.xOffset);
			}
			else
			{
				y_move = -1 * __monster.yOffset/Math.abs(__monster.yOffset);
			}
			
			new_x_loc = __monster.x + x_move;
			new_y_loc = __monster.y + y_move;
			
			nextAction(Dd1590, "Dd1590");
			
			__debug.msg("  x_move: " + x_move + ", y_move: " + y_move);
			__debug.msg("  monster is at: " + __monster.x + ", " + __monster.y);
			__debug.msg("  checking new monster loc: " + new_x_loc + ", " + new_y_loc);
			
			if (__map.isOnMap(new_x_loc, new_y_loc))
			{
				var new_tile_type:int = __map.getTileType(new_x_loc, new_y_loc);
				__debug.msg("    new tile type: " + new_tile_type);
				
				switch(new_tile_type)
				{
					case 0:
					case 6:
					case 7:
					case 8:
					{
						__debug.msg("    new loc OK");
						break;
					}
					case 2:  //Trap
					{
						nextAction(Dd7530, "Dd7530");  //Handle trap
						break;
					}
					case 3,4: //Door
					{
						//move two spaces - through door
						new_x_loc += x_move;
						new_y_loc += y_move;
						if (__map.isOnMap(new_x_loc, new_y_loc) && (__map.getTileType(new_x_loc, new_y_loc) == 0))
						{
							//cool
							__debug.msg("  moving through door");
						}
						else //No move
						{
							new_x_loc = __monster.x;
							new_y_loc = __monster.y;
						}
						
						break;
					}
					default: //No move
					{
						__debug.msg("    staying put");
						new_x_loc = __monster.x;
						new_y_loc = __monster.y;
						break;
					}
				}
				
				__debug.msg("    moving monster to: " + new_x_loc + ", " + new_y_loc);
				__map.clearTile(__monster.x, __monster.y);
				__monster.x = new_x_loc;
				__monster.y = new_y_loc;
				__debug.msg("      monster is now at: " + __monster.x + ", " + __monster.y);
			}
		}
		
		private function Dd7530():void
		{
			/*
			07530 PRINT "GOOD WORK  YOU LED HIM INTO A TRAP"
			07540 LET K1=-1
			07550 LET B(K,6)=0  //BUG? should be B(K,5)?
			07560 GO TO 07000
			*/
			print("GOOD WORK  YOU LED HIM INTO A TRAP");
			__monster.kill();
			nextAction(Dd7000, "Dd7000");
		}
		
		/*  ORPHAN?
		07570 LET R8=-.5*R8
		07580 LET R9=-.5*R9
		07590 GO TO 07420
		*/
			
		private function Dd7600():void //Check if monster scores a hit
		{
			/*
			07600 PRINT B$(K);"WATCH IT"
			07610 FOR M=1 TO X
			07620 IF W(M)=10 THEN 07720
			07630 IF W(M)=9 THEN 07700
			07640 IF W(M)=8 THEN 07680
			07650 NEXT M
			07651 A1=6+C(2)
			07652 GO TO 07730
			07660 LET A1=8+C(2)  //orphan
			07670 GO TO 07730
			07680 LET A1=12+C(2)
			07690 GO TO 07730
			07700 LET A1=16+C(2)
			07710 GO TO 07730
			07720 LET A1=20+C(2)
			07730 IF RND(0)*40>A1 THEN 07790
			07740 IF RND(0)*2>1 THEN 07770
			07750 PRINT "HE MISSED"
			07760 GO TO 01590
			07770 PRINT "HE HIT YOU BUT NOT GOOD ENOUGH"
			07780 GO TO 07000
			07790 PRINT "MONSTER SCORES A HIT"
			07800 LET C(0)=C(0)-INT(RND(0)*B(K,2)+1)
			07810 PRINT "H.P.=";C(0)
			07820 GO TO 07000
			*/
			
			print(__monster.name + " WATCH IT!");
			
			//set player armor class
			if (__player.inventory.hasItem(DdItems.ITEM_ID_PLATE_MAIL))
			{			
				__player.armorClass = 20 + __player.DEX;
				__debug.msg("  wearing PLATE MAIL: AC: " + __player.armorClass);
			}
			else if (__player.inventory.hasItem(DdItems.ITEM_ID_CHAIN_MAIL))
			{
				__player.armorClass = 16 + __player.DEX;
				__debug.msg("  wearing CHAIN MAIL: AC: " + __player.armorClass);
			}
			else if (__player.inventory.hasItem(DdItems.ITEM_ID_LEATHER_MAIL))
			{
				__player.armorClass = 12 + __player.DEX;
				__debug.msg("  wearing LEATHER MAIL: AC: " + __player.armorClass);
			}
			else
			{
				__player.armorClass = 6 + __player.DEX;
				__debug.msg("  wearing no armor: AC: " + __player.armorClass);
			}
			
			//If the monster hits, he gets to attack again!
			var _rollR40:Number = DdRoll.R(40);
			var _rollR2:Number = DdRoll.R(2);
			
			__debug.msg("    _rollR40: " + _rollR40);
			__debug.msg("    _rollR2: " + _rollR2);
				
			if (_rollR40 >__player.armorClass)
			{
				print("MONSTER SCORES A HIT");
				__player.HP -= DdRoll.D(__monster.stat2) + 1;
				print("YOUR HP=" + __player.HP);
				nextAction(Dd7000, "Dd7000");
			}
			else if (_rollR2 > 1)
			{
				print("HE HIT YOU BUT NOT GOOD ENOUGH");
				nextAction(Dd7000, "Dd7000");
			}
			else
			{
				print("HE MISSED");
				nextAction(Dd1590, "Dd1590");
			}
		}
		
		private function Dd7830():void  //Spawn monster
		{
			/*
			07830 FOR Z7=1 TO 50
			07840 FOR M=1 TO 10
			07850 IF B(M,5)>=1 AND RND(0)>.925 THEN 08000
			07860 NEXT M
			07870 NEXT Z7
			07880 PRINT "ALL MONSTERS DEAD"
			07890 PRINT "RESET";
			07900 INPUT Q$
			*/
			
			__monster = __monsterDB.getMonsterByID(0);
			__monster = __monsterDB.spawnMonster();
			
			if (__monster.id > 0)
			{
				__debug.msg("monster spawned: " + __monster.name);
				nextAction(Dd8000, "Dd8000");
			}
			else
			{
				
				print("ALL MONSTERS DEAD");
				print("RESET?:");
				input(onQueryReset);
			}
		}
		
		private function onQueryReset(args:Array):void
		{
			
			/*
			07910 IF Q$="YES" THEN 07930
			07920 STOP
			
			07930 REM
			07931 LET J4=J4+1
			07932 FOR M=1 TO 10
			07950 LET B(M,3)=B(M,4)*J4  //transposed??  should be B(M,4)=B(M,3)*J4 ?
			07960 LET B(M,6)=B(M,5)*J4
			07970 NEXT M
			07980 LET C(0)=C(0)+5
			07990 GO TO 01590
			*/
			
			if (args[0] == "YES")
			{
				__state.difficulty += 1;
				__monsterDB.reset(__state.difficulty);
				__player.HP += 5;
				nextAction(Dd1590, "Dd1590");
			}
			else
			{
				nextAction(stop, "stop");
			}
		}
		
		private function Dd8000():void  //init new monster
		{
			/*
			08000 LET K=M
			08010 M1=INT(RND(0)*7+1)
			08015 FOR M=-M1 TO M1
			08020 FOR N=-M1 TO M1
			08025 IF ABS(M)<=2 OR ABS(N)<=2 THEN 08080
			08030 IF G+M<1 THEN 08080
			08040 IF H+N<1 THEN 08080
			08050 IF G+M>25 THEN 08080
			08060 IF H+N>25 THEN 08080
			08065 IF RND(0)>.7 THEN 08080
			08070 IF D(G+M,H+N)=0 THEN 08110
			08080 NEXT N
			08090 NEXT M
			08100 GO TO 08010
			08110 REM
			08120 LET D(G+M,H+N)=5
			08130 LET F1=G+M
			08140 LET F2=H+N
			08150 GO TO 07000
			*/
			
			var _distanceFromPlayer:int = DdRoll.D(4)+3;
			var monster_x:int = 0;
			var monster_y:int = 0;
			var monster_placed:Boolean = false;
			
			__debug.msg(" attempting to place monster: " + _distanceFromPlayer);
			for (var _m:int= -_distanceFromPlayer; _m < _distanceFromPlayer; _m++)
			{
				for (var _n:int= -_distanceFromPlayer; _n < _distanceFromPlayer; _n++)
				{
					if (!monster_placed && (Math.abs(_m) > 2) && (Math.abs(_n) > 2))
					{
						monster_x = __player.x + _n;
						monster_y = __player.y + _m;
						var _roll:Number = DdRoll.R(1);
						
						__debug.msg("   checking: " + _m + ", " + _n + ", " + _roll);
						
						if (__map.isOnMap(monster_x, monster_y) && (__map.getTileType(monster_x, monster_y) == 0) && (_roll <= 0.7))
						{
							__debug.msg("  placing monster at: " + monster_x  + ", " + monster_y);
							__monster.x = monster_x;
							__monster.y = monster_y;
							monster_placed = true;
						}
					}
				}
			}

			nextAction(Dd7000, "Dd7000");
		}
		
		private function Dd8160():void  //health alert
		{
			/*
			08160 IF C(0)<1  THEN 08190
			08170 PRINT "WATCH IT H.P.=";C(0)
			08180 GO TO 07020
			08190 IF C(0)<0 THEN 08250
			08200 IF C(3)<9 THEN 08230
			08210 PRINT "H.P.=0 BUT CONST. HOLDS"
			08220 GO TO 07020
			08230 PRINT "SORRY YOUR DEAD"
			08240 STOP
			08250 IF C(3)<9 THEN 08230
			08260 LET C(3)=C(3)-2
			08270 LET C(0)=C(0)+1
			08280 GO TO 08190
			*/
			
			if (__player.HP == 1)
			{
				print("WATCH IT H.P.=" + __player.HP)
				nextAction(Dd7020, "Dd7020");
			}
			else if ((__player.HP == 0) && (__player.CON >= 9))
			{
				print("H.P.=0 BUT CONST. HOLDS");
				nextAction(Dd7020, "Dd7020");
			}
			else if ((__player.HP <= 0) && (__player.CON >= 9))
			{
				var hp_deficit:int = 0 - __player.HP;
				var con_cost:int = hp_deficit * 2;
				__player.CON -= con_cost;
				
				if (__player.CON < 9)
				{
					print("SORRY YOU'RE DEAD");
					nextAction(stop, "stop");
				}
				else
				{
					__player.HP += hp_deficit;
					print("H.P.=" + __player.HP + " AFTER CONST. DEDUCTION. CON=" + __player.CON);
					nextAction(Dd7020, "Dd7020");
				}
			}
			else
			{
				print("SORRY YOU'RE DEAD");
				nextAction(stop, "stop");
			}
		}
		
		private function Dd8290():void
		{
			/*
			MONSTER KILLED
			08290 K1=0
			08300 LET C(7)=C(7)+B(K,6)
			08310 LET D(F1,F2)=0
			08320 LET F1=0
			08330 LET F2=0
			08340 PRINT "GOOD WORK YOU JUST KILLED A ";B$(K)
			08350 PRINT "AND GET ";B(K,6);"GOLD PIECES"
			08355 IF J6=1 GO TO 08370
			08360 LET B(K,5)=0
			08370 PRINT "YOU HAVE";C(7);" GOLD "
			08380 LET B(K,6)=0
			08381 IF J6<>1 GO TO 08390
			08382 B(K,3)=B(K,4)*B(K,1)/1
			08383 B(K,6)=B(K,5)*B(K,1)
			08390 LET K=0
			08400 GO TO 07000
			*/
			
			__debug.msg("Dd8290: Monster killed");
			__monster.alive = false;
			__player.GOLD += __monster.maxHP;
			__monster.x = 10;
			__monster.y = 10;
			print("GOOD WORK YOU JUST KILLED A " + __monster.name);
			print("AND GET " + __monster.maxHP + " GOLD PIECES");
			
			if (__state.resetOnLevelComplete == 1)
			{
				__monster.gold = __monster.maxGold * __monster.level;
				__monster.HP = __monster.maxHP * __monster.level;  //BUG? this is transposed in the original baseic
			}
			else
			{
				__monster.HP = 0;
			}
			
			print("YOU HAVE " + __player.GOLD + " GOLD ");
			__monster = __monsterDB.getMonsterByID(0);
			
			nextAction(Dd7000, "Dd7000");
		}
		
		public function Dd8410():void  //update monster subroutine
		{
			/*
			08410 REM RANGE AND HIT CHECK"
			08420 FOR M=-25 TO 25
			08430 FOR N=-25 TO 25
			08440 IF G+M>25 THEN 08490
			08450 IF G+M<0 THEN 08490
			08460 IF H+N>25 THEN 08490
			08470 IF H+N<0 THEN 08490
			08480 IF D(G+M,H+N)=5 THEN 08520
			08490 NEXT N
			08500 NEXT M
			08510 LET R1=1000
			08520 LET R8=M
			08530 LET R9=N
			08540 IF R1=1000 THEN 08570
			08550 LET R1=SQR(M*M+N*N)
			08570 IF INT(RND(0)*20 +1)>18 THEN 08620
			08580 IF RND(0)*20>B(K,2)-C(2)/3 THEN 08640
			08590 IF RND(0)*2>1.7 THEN 08660
			08600 LET R2=0
			08610 RETURN
			08620 LET R2=3
			08630 RETURN
			08640 LET R2=2
			08650 RETURN
			08660 LET R2=1
			08670 RETURN
			*/
			
			var found_monster:Boolean = false;
			__monster.distance = 1000;
			
			for (var y_offset:int=-25; y_offset<25; y_offset++)
			{
				//scan for monster
				for (var x_offset:int=-25; x_offset<25; x_offset++)
				{
					var _x:int = __player.x + x_offset;
					var _y:int = __player.y + y_offset;
					
					if (!found_monster && __map.isOnMap(_x, _y))
					{
						//found monster
						if ((__monster.x == _x) && (__monster.y == _y))
						{
							found_monster = true;
							__monster.yOffset = y_offset;
							__monster.xOffset = x_offset;
							__monster.distance = Math.sqrt(y_offset*y_offset + x_offset*x_offset);
						}
					}
				}
				
				__player.attackEffectiveness = 0;
				
				if ((DdRoll.D(20) + 1) > 18)
				{
					__player.attackEffectiveness = 3;
				}
				else if (DdRoll.R(20) > (__monster.stat2 - (__player.DEX / 3)))
				{
					__player.attackEffectiveness = 2;
				}
				else if (DdRoll.R(2) > 1.7)
				{
					__player.attackEffectiveness = 1;
				}
			}
			
			__debug.msg("8410: Monster at: " + __monster.x + ", " + __monster.y + " Range: " + __monster.distance + ", Attack: " + __player.attackEffectiveness);
		}
		
		private function useSpells():void
		{
			/*
			08680 PRINT "MAGIC"
			08690 IF J<>0 THEN 08740
			08700 IF C$(0)="CLERIC" THEN 08760
			08710 IF C$(0)="WIZARD" THEN 09310
			08720 PRINT "YOU CANT TSE MAGIC YOUR NOT A M.U."
			08730 GO TO 07000
			08740 PRINT "YOU CANT USE MAGIC WITH WEAPON IN HAND"
			08750 GO TO 07000
			08760 PRINT "CLERICAL SPELL #";
			08770 INPUT Q
			*/
			
			print("MAGIC");
			if (__player.equippedItemID != 0)
			{
				print("YOU CAN'T USE MAGIC WITH A WEAPON IN HAND");
				nextAction(Dd7000, "Dd7000");
			}
			else
			{
				switch(__player.classification)
				{
					case "FIGHTER":
					{
						print("YOU CAN'T USE MAGIC. YOU'RE NOT A M.U.");
						nextAction(Dd7000, "Dd7000");
						break;
					}
					case "CLERIC":
					{
						print("CLERICAL SPELL #:");
						input(onQuerySpellNumCleric);
						break;
					}
					case "WIZARD":
					{
						print("SPELL #:");
						input(onQuerySpellNumWizard);
						break;
					}	
					default:
					{
						nextAction(Dd1590, "Dd1590");
						break;
					}
				}
			}
			
			
		}
		
		private function onQuerySpellNumCleric(args:Array):void
		{
			var q:String = args[0];
			var _input:int = int(q);
			
			/*
			08780 FOR M=1 TO X1
			08790 IF Q=X2(M) THEN 08830
			08800 NEXT M
			08810 PRINT "YOU DONT HAVE THAT SPELL"
			08820 GO TO 07000
			08830 X3=X2(M)
			08835 X2(M)=0
			08839 IF X3=1 THEN 08950
			08840 IF X3=2 THEN 09030
			08850 IF X3=3 THEN 09060
			08860 LET Q=2
			08870 IF X3=4 THEN 09090
			08880 LET Q=3
			08890 IF X3=5 THEN 09200
			08900 IF X3=6 THEN 09240
			08910 IF X3=7 THEN 09280
			08920 IF X3=8 THEN 09090
			08930 IF X3=9 THEN 09720
			08940 GO TO 08810
			08950 IF RND(0)*3 > 1 THEN 09000
			08960 PRINT "DONE"
			08970 LET X2(M)=0
			08980 LET K1=-1
			08990 GO TO 07000
			09000 PRINT "FAILED"
			09010 LET X2(M)=0
			09020 GO TO 07000
			09030 PRINT "DONE"
			09040 LET B(K,3)=B(K,3)-4
			09050 GO TO 09010
			09060 LET C(3)=C(3)+3
			09070 LET X2(M)=0
			09080 GOTO 07000
			09090 LET X2(M)=0
			09100 FOR M=-3 TO 3
			09110 FOR N=-3 TO 3
			09120 IF G+M <0 OR G+M >25 OR H+N<0 OR H+N > 25 THEN 09140
			09130 IF D(G+M,H+N)=Q THEN 09180
			09140 NEXT N
			09150 NEXT M
			09160 PRINT "NO MORE"
			09170 GO TO 09010
			09180 PRINT "THERE IS ONE AT ";M;"LAT.";N;"LONG."
			09190 GO TO 09140
			09200 PRINT "DONE"
			09210 LET X2(M)=0
			09220 LET B(K,3)=B(K,3)-2
			09230 GO TO 09010
			09240 PRINT "DONE"
			09250 LET X2(M)=0
			09260 LET B(K,3)=B(K,3)-6
			09270 GO TO 09010
			09280 PRINT "DONE"
			09290 LET C(3)=C(3)+3
			09300 GO TO 09010
			09310 PRINT "SPELL #";
			09320 INPUT Q
			*/
			
			nextAction(Dd7000, "Dd7000");
			
			if (__player.clericSpells.hasItem(_input))
			{
				switch(_input)
				{
					case 1:
					{
						if (DdRoll.D(3) > 1)
						{
							print("FAILED");
						}
						else
						{
							print("DONE");
							__monster.kill();
						}
						break;
					}
					case 2:
					{
						print("DONE");
						__monster.HP -= 4;
						break;
					}
					case 3:
					{
						print("DONE");
						__player.CON +=3;
						break;
					}
					case 4:
					{
						print(__map.locate(2, __player));
						break;
					}
					case 5:
					{
						print("DONE");
						__monster.HP -= 2;
						break;
					}
					case 6:
					{
						print("DONE");
						__monster.HP -= 6;
						break;
					}
					case 7:
					{
						print("DONE");
						__player.CON +=3;
						break;
					}
					case 8:
					{
						print(__map.locate(3, __player));
						break;
					}
					case 9:
					{
						print("WHOA!");
						break;
					}
						
					default:
					{
						break;
					}
				}
				__player.dropEquippedClericalSpell();
			}
			else
			{
				print("YOU DONT HAVE THAT SPELL");
			}
		}
		
		private function onQuerySpellNumWizard(args:Array):void
		{
			var q:String = args[0];
			var _input:int = int(q);
			
			/*
			09330 FOR M=1 TO X3
			09340 IF Q=X4(M) THEN 09390
			09350 NEXT M
			09360 PRINT "DO NOT HAVE THAT ONE"
			09370 GO TO 01590
			09380 IF F1-G=0 THEN 09410
			09390 IF X4(M)<>1 THEN 09480
			09400 GO TO 09420
			09410 LET S=0
			09420 IF F2-H=0 THEN 09450
			09430 PRINT "ARE YOU ABOVE,BELOW,RIGHT, OR LEFT OF IT";
			09440 GO TO 09470
			09450 LET T=0
			09460 LET Z5=1
			09470 GOTO 03940
			09480 IF X4(M)=2 THEN 09660
			09490 LET R=5
			09500 LET Q=2
			09510 IF X4(M)=3 THEN 09090
			09520 IF X4(M)=4 THEN 09800
			09530 LET Q=0
			09540 IF X4(M)=5 THEN 09860
			09550 LET Q=3
			09560 IF X4(M)=6 THEN 09950
			09570 LET Q=6
			09580 IF X4(M)=7 THEN 09950
			09590 LET Q=9
			09600 IF X4(M)=8 THEN 09950
			09610 LET Q=3
			09620 IF X4(M)=9 THEN 09090
			09630 LET Q=1
			09640 IF X4(M)=10  THEN 09860
			09650 GO TO 09360
			09660 IF RND(0)*3>1 THEN 09690
			09670 PRINT "FAILED"
			09680 GO TO 07000
			09690 PRINT "DONE"
			09700 K1=-1
			09710 GO TO 07000
			09720 IF K=4 THEN 09760
			09730 IF K=10 THEN 09760
			09740 PRINT "FAILED"
			09750 GO TO 07000
			09760 PRINT "DONE"
			09770 GOTO 09390
			09780 LET T=(F2-H)/ABS(F2-H)
			09790 GO TO 04220
			09800 PRINT "INPUT CO-ORDINATES";
			09810 INPUT M,N
			*/
			
			nextAction(Dd7000, "Dd7000");
			
			if (__player.spells.hasItem(_input))
			{
				switch(_input)
				{
					case 1:
					{
						print("FIZZLE!");  //should get a throw direction...
						__monster.HP -= 1;
						break;
					}
					case 2:
					{
						if (DdRoll.D(3) > 1)
						{
							print("DONE");
							__monster.kill();
						}
						else
						{
							print("FAILED");
						}
						break;
					}
					case 3:
					{
						print(__map.locate(2, __player));
						break;
					}
					case 4:
					{
						print(__map.locate(2, __player))
						break;
					}
					case 5:
					{
						print("ZINGG!");
						__monster.HP -= 2;  //should ask for coords, etc.
						break;
					}
					case 6:
					{
						print("DONE");
						__monster.HP -= 6;
						break;
					}
					case 7:
					{
						__monster.HP -= (6 + DdRoll.D(11));
						print("MONSTER HP= " +__monster.HP);
						break;
					}
					case 8:
					{
						__monster.HP -= (9 + DdRoll.D(11));
						print("MONSTER HP= " +__monster.HP);
						break;
					}
					case 9:
					{
						print(__map.locate(3, __player));
						break;
					}
						
					default:
					{
						break;
					}
				}
				__player.dropEquippedClericalSpell();
			}
			else
			{
				print("YOU DONT HAVE THAT SPELL");
			}
			
			input(onQuerySpellCoordinates1);
		}
		
		private function onQuerySpellCoordinates1(args:Array):void
		{
			/*
			
			09820 PRINT "DONE"
			09830 LET G=M
			09840 LET H=N
			09850 GO TO 07000
			09860 PRINT "INPUT CO-ORDINATES";
			09870 INPUT M,N
			*/
			input(onQuerySpellCoordinates2);
		}
				
		private function onQuerySpellCoordinates2(args:Array):void
		{
			/*
			09880 IF D(M,N)=0 THEN 09920
			09890 IF D(M,N)=1 THEN 09920
			09900 PRINT "FAILED"
			09910 GO TO 07000
			09920 LET D(M,N)=Q
			09930 PRINT "DONE"
			09940 GO TO 07000
			09950 PRIT "DONE"
			09960 LET B(K,3)=B(K,3)-Q-INT(RND(0)*11)
			09965 PRINT "M-HP=";B(K,3)
			09970 GO TO 07000
			*/
		}
		
		private function Dd9980():void
		{
			
			/*
			09980 IF C$(0)="CLERIC" THEN 10020
			09990 IF C$(0)="WIZARD" THEN 10360
			10000 PRINT "YOU CANT BUY ANY"
			10010 GO TO 01590
			10020 PRINT "DO YOU KNOW THE CHOICES";
			10030 INPUT Q$
			*/
			
			
			
			if (__player.classification == "CLERIC")
			{
				print("DO YOU KNOW THE CHOICES?");
				input(onQueryDoYouKnowTheChoicesCleric);
				
			} else if (__player.classification == "WIZARD")
			{
				print("DO YOU KNOW THE SPELLS?");
				input(onQueryDoYouKnowTheChoicesWizard);
			}
			else
			{
				print("YOU CANT BUY ANY");
				nextAction(Dd1590, "Dd1590");
			}
		}
		
		private function onQueryDoYouKnowTheChoicesCleric(args:Array):void
		{
			var q:String = args[0];
			var _input:int = int(q);
			
			/*
			10040 IF Q$="YES" THEN 10100
			10050 PRINT "1-KILL-500  5-MAG. MISS. #1-100"
			10060 PRINT "2-MAG. MISS. #2-200  6-MAG. MISS. #3-300"
			10070 PRINT "3-CURE LHGHT #1-200  7-CURE LIGHT #2-1000"
			10080 PRINT "4-FIND ALL TRAPS-200  8-FIND ALL S.DOORS-200"
			10090 PRINT "INPUT # WANTED   NEG.NUM.TO STOP";
			10100 INPUT Q
			*/
			print("1-KILL-500  5-MAG. MISS. #1-100");
			print("2-MAG. MISS. #2-200  6-MAG. MISS. #3-300");
			print("3-CURE LHGHT #1-200  7-CURE LIGHT #2-1000");
			print("4-FIND ALL TRAPS-200  8-FIND ALL S.DOORS-200");
			print("INPUT # WANTED   NEG.NUM.TO STOP");
			
			input(onQueryChooseSpellCleric);
		}
		
		private function onQueryChooseSpellCleric(args:Array):void
		{
			var q:String = args[0];
			var _input:int = int(q);
			
			/*
			10110 LET X5(1)=500
			10120 LET X5(2)=200
			10130 LET X5(3)=200
			10140 LET X5(4)=200
			10150 LET X5(5)=100
			10160 LET X5(6)=300
			10170 LET X5(7)=1000
			10180 LET X5(8)=200
			10190 IF Q<1 THEN 10290
			10200 IF Q>10 THEN 10100
			10210 IF C(7)-X5(INT(Q))<0 THEN 10270
			10220 LET C(7)=C(7)-X5(INT(Q))
			10230 PRINT "IT IS YOURS"
			10240 LET X1=X1+1
			10250 LET X2(X1)=INT(Q)
			10260 GO TO 10100
			10270 PRINT "COSTS TOO MUCH"
			10280 GO TO 10100
			10290 PRINT "YOUR SPELLS ARE"
			10300 FOR M=1 TO X1
			10310 IF X2(M)=0 THEN 10330
			10320 PRINT "#";X2(M)
			10330 NEXT M
			10340 PRINT "DONE"
			10350 GO TO 01590
			10360 PRINT "DO YOU KNOW THE SPELLS";
			10370 INPUT Q$
			*/
			
			if ((_input >= 1) && (_input <= 8))
			{
				var spell:DdSpell = __spellTypesCleric.item(_input);
				if (__player.GOLD - spell.cost >= 0)
				{
					print("IT IS YOURS");
					__player.clericSpells.addItem(spell);
					__player.GOLD -= spell.cost;
				}
				
				input(onQueryDoYouKnowTheChoicesCleric);
			}
			else
			{
				print(__player.clericSpells.inventoryList());
				nextAction(Dd1590, "Dd1590");
			}
			
		}
		
		private function onQueryDoYouKnowTheChoicesWizard(args:Array):void
		{
			var q:String = args[0];
			var _input:int = int(q);
			
			/*
			10380 IF Q$="YES" THEN 10450
			10390 PRINT "1-PUSH-75   6-M. M. #1-100"
			10400 PRINT "2-KIHL-500  7-M. M. #2-200"
			10410 PRINT "3-FIND TRAPS-200  8-M. M. #3-300"
			10420 PRINT "4-TELEPORT-750  9-FIND S.DOORS-200"
			10430 PRINT "5-CHANGE 1+0-600  10-CHANGE 0+1-600"
			10440 PRINT "#OF ONE YOU WANT  NEG.NUM.TO STOP";
			10450 INPUT Q
			*/
			
			print("1-PUSH-75   6-M. M. #1-100");
			print("2-KIHL-500  7-M. M. #2-200");
			print("3-FIND TRAPS-200  8-M. M. #3-300");
			print("4-TELEPORT-750  9-FIND S.DOORS-200");
			print("5-CHANGE 1+0-600  10-CHANGE 0+1-600");
			print("#OF ONE YOU WANT  NEG.NUM.TO STOP");
			input(onQueryChooseSpellWizard);
		}
		
		private function onQueryChooseSpellWizard(args:Array):void
		{
			var q:String = args[0];
			var _input:int = int(q);
			
			/*
			10460 LET X6(1)=75
			10470 LET X6(2)=500
			10480 LET X6(3)=200
			10490 LET X6(4)=750
			10500 LET X6(5)=600
			10510 LET X6(6)=100
			10520 LET X6(7)=200
			10530 LET X6(8)=300
			10540 LET X6(9)=200
			10550 LET X6(10)=600
			10560 IF Q<1 THEN 10660
			10570 IF Q>8 THEN 10450
			10580 IF C(7)-X6(INT(Q))<0 THEN 10640
			10590 LET C(7)=C(7)-X6(INT(Q))
			10600 PRINT "IT IS YOURS"
			10610 LET X3=X3+1
			10620 LET X4(X3)=INT(Q)
			10630 GO TO 10450
			10640 PRINT "COSTS TOO MUCH"
			10650 GO TO 10450
			10660 PRINT "YOU NOW HAVE"
			10670 FOR M=1 TO X3
			10680 IF X4(M)=0 THEN 00700
			10690 PRINT "#";X4(M)
			10700 NEXT M
			10710 GO TO 01590
			*/
			
			if ((_input >= 1) && (_input <= 10))
			{
				var spell:DdSpell = __spellTypesWizard.item(_input);
				if (__player.GOLD - spell.cost >= 0)
				{
					print("IT IS YOURS");
					__player.spells.addItem(spell);
					__player.GOLD -= spell.cost;
				}
				
				input(onQueryDoYouKnowTheChoicesWizard);
			}
			else
			{
				print(__player.spells.inventoryList());
				nextAction(Dd1590, "Dd1590");
			}
		}
		
		private function printFullMap():void
		{
			/*
			10720 REM
			10730 REM CHEATING
			10740 FOR M=0 TO 25
			10750 FOR N=0 TO 25
			10760 PRINT D(M,N);
			10770 NEXT N
			10780 PRINT
			10790 NEXT M
			10800 GO TO 01590
			*/
		}
		
		private function buyHP():void
		{
			/*
			10810 REM
			10820 GO TO 00380
			10830 PRINT "HOW MANY 200 GP. EACH ";
			10840 INPUT Q
			*/
			
			print("HOW MANY 200 GP. EACH ");
			input(onQueryHowManyHitPointsToBuy);
		}
		
		private function onQueryHowManyHitPointsToBuy(args:Array):void
		{
			var q:String = args[0];
			var _input:int = int(q);
			
			/*
			10850 IF C(7)-200*Q<0 THEN 10900
			10860 LET C(0)=C(0)+INT(Q)
			10870 LET C(7)=C(7)-INT(Q*200)
			10880 PRINT "OK DONE"
			10885 PRINT "HP= ";C(0)
			10886 FOR M=1 TO 7
			10887 PRINT C$(M);" = ";C(M)
			10888 NEXT M
			10890 GO TO 07000
			10900 PRINT "NO"
			10910 GO TO 10830
			*/
			
			if ((__player.GOLD - 200*_input) >= 0)
			{
				__player.GOLD -= 200*_input;
				__player.HP += _input;
				
				print("OK DONE");
				print("HP= " + __player.HP);
				nextAction(Dd7000, "Dd7000");
			}
			else
			{
				print("NO");
				nextAction(Dd1590, "Dd1590");
			}
		}
		
		private function save():void
		{
			/*
			11000 PRINT "DNG";
			11010 INPUT D2
			*/
			input(onQuerySaveDungeonNumber);
		}
		
		private function onQuerySaveDungeonNumber(args:Array):void
		{
			/*
			11020 PRINT "X,Y,C";
			11030 INPUT X9,Y9,C9
			*/
			
			input(onQuerySaveXYC);
		}
		
		private function onQuerySaveXYC(args:Array):void
		{
			/*
			11035 IF C9<0 THEN 11060
			11040 LET D(X9,Y9)=C9
			11050 GO TO 11020
			11060 PRINT "SAVE"
			11061 INPUT Q
			*/
			
			input(onQueryConfirmSave);
		}
		
		private function onQueryConfirmSave(args:Array):void
		{
			/*
			11062 IF Q<>1 THEN 7000
			11063 FOR M=0 TO 25
			11070 FOR N=0 TO 25
			11080 WRITE #D2,D(M,N)
			11090 NEXT N
			11100 NEXT M
			11110 GO TO 7000
			11120 END
			*/
		}
		
		private function stop():void
		{
			print()
			print("GAME OVER");
			print();
		}
					
/*
REM TRANSCRIBED IN 2014 BY DEJAY CLAYTON, FROM A SCAN OF THE ORIGINAL PDP11
REM TELETYPE PROGRAM LISTING MADE AVAILBLE BY RICHARD GARRIOTT.
REM
REM NOTE: THIS TRANSCRIPTION CONTAINS ALL TYPOS AND ERRORS THAT WERE PRESENT
REM IN THE ORIGINAL SCANNED PROGRAM LISTING.
REM ------------------------------------------------------------------------
REM
REM VERSION 1.3
REM
REM VERSION HISTORY:
REM ----------------
REM VERSION 1.3  2014-04-20: FIXED TRANSCRIPTION ERRORS IN LINES 00300, 00430,
REM                          01090, 01240, 01920, 02940, 03920, 04750, 05980,
REM                          07290, 07300, 07931, 08290, 08470, 08720, 09080
REM
REM VERSION 1.2  2014-04-19: FIXED TRANSCRIPTION ERROR IN LINE 06450
REM
REM VERSION 1.1C 2014-04-17: CREATED CONTINUOUS VERSION FOR EASIER READING
REM 
REM VERSION 1.1  2014-04-17: ADDED NOTICES AND VERSION HISTORY
REM
REM VERSION 1.0  2014-04-17: INITIAL VERSION

*/
		

		
		public override function accelerometerUpdateHandler(event:AccelerometerEvent):void
		{
		}
		
		public override function animCallback(anim_state:String):void
		{
			super.animCallback(anim_state);
			switch (anim_state)
			{
				case "EOS":
					//DdAppStateManager.instance.gotoState(DdAppStateManager.STATE_MAIN);
					break;
				default:
					break;
			}
		}
		
		public override function dispose():void
		{
			super.dispose();
			removeChild(__UI_Main);
			__UI_Main = null;
		}
		
	}
}