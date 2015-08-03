with Ada.Text_Io;
with Game_Of_Life;
with Ada.Strings.Unbounded;

use Ada.Text_Io;
use Game_Of_Life;
use Ada.Strings.Unbounded;

procedure Play is
	subtype Iter is Integer range 0..1024;

	Delay_Time : Duration := 0.05;
	Message    : Unbounded_String;
	Board_Main : Board;
begin
	Board_Main := New_Board;
	Init_Board (Board_Main);
	for i in Iter loop
		Message := To_Unbounded_String("Iteration: " &
				   		               Integer'Image(i));
		Print_Board  (Board_Main, To_String(Message));
		Update_Board (Board_Main);
		delay Delay_Time;
	end loop;
end Play;
