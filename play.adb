with Ada.Command_Line;
with Ada.Text_Io;
with Game_Of_Life;

use Ada.Command_Line;
use Ada.Text_Io;
use Game_Of_Life;

procedure Play is
    Fill_Percent : Percent  := 40;
    Delay_Time   : Duration := 0.05;
    Board_Main   : Board;
    Inputs_Good  : Boolean  := True;
begin
    case Argument_Count is
        when 0 =>
            null;
        when 1 =>
            Fill_Percent := Integer'Value(Argument(1));
        when 2 =>
            Fill_Percent := Integer'Value(Argument(1));
            Delay_Time   := Duration'Value(Argument(2));
        when others =>
            Put_Line ("Usage: play initial_percent_of_cells delay_time");
            return;
    end case;

    if Fill_Percent = 0 or Fill_Percent = 100 then
        Put_Line ("Mid-range fill percentages give better results.");
        Inputs_Good := False;
    end if;

    if Delay_Time < 0.05 then
        Put_Line ("Delay times of less than 0.05s may cause rendering issues.");
        Inputs_Good := False;
    end if;

    if Inputs_Good then
        Board_Main := New_Board;
        Init_Board    (Board_Main, Fill_Percent);
        Loop_To_Print (Board_Main, Delay_Time);
    end if;
end Play;
