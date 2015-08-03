with Ada.Text_Io;
with Game_Of_Life;

use Ada.Text_Io;
use Game_Of_Life;

procedure Play is
	Delay_Time : Duration := 0.05;
	Board_Main : Board;
begin
	Board_Main := New_Board;
	Init_Board (Board_Main);
	Loop_To_Print (Board_Main, Delay_Time);
end Play;
