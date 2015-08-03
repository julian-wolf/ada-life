with Ada.Numerics.Discrete_Random;
with Ada.Text_Io;
with Ada.Strings.Unbounded;

package body Game_Of_Life is
    function New_Board return Board is
        Board_New : Board;
    begin
        for i in Height_Range loop
            for j in Width_Range loop
                Board_New (i, j) := False;
            end loop;
        end loop;

        return Board_New;
    end New_Board;

    procedure Init_Board (Board_Crt : out Board; Fill : in Percent) is
        package Random_Percent is new Ada.Numerics.Discrete_Random (Percent);

        Generator      : Random_Percent.Generator;
        Random_Integer : Integer;
        Random_Boolean : Boolean;
    begin
        Random_Percent.Reset (Generator);

        for i in Height_Range loop
            for j in Width_Range loop
                Random_Integer := Random_Percent.Random (Generator);

                if Random_Integer < Fill then
                    Random_Boolean := True;
                else
                    Random_Boolean := False;
                end if;

                Board_Crt (i, j) := Random_Boolean;
            end loop;
        end loop;
    end Init_Board;

    procedure Update_Board (Board_Crt : in out Board) is
        type Neighbors is range 0..9;

        subtype Neighbor_Ind_Height is Height_Index range 0..2;
        subtype Neighbor_Ind_Width  is Width_Index  range 0..2;

        Board_Temp     : Board;
        Neighbor_Count : Neighbors;
    begin
        Board_Temp := New_Board;
        for i in Height_Range loop
            for j in Width_Range loop
                Neighbor_Count := 0;

                for a in Neighbor_Ind_Height loop
                    for b in Neighbor_Ind_Width loop
                        if Board_Crt (i+a-1, j+b-1) then
                            Neighbor_Count := Neighbor_Count + 1;
                        end if;
                    end loop;
                end loop;

                if Board_Crt (i, j) then
                    Neighbor_Count := Neighbor_Count - 1;
                end if;

                case Neighbor_Count is
                    when 2 =>
                        Board_Temp(i, j) := Board_Crt(i, j);
                    when 3 =>
                        Board_Temp(i, j) := True;
                    when others =>
                        Board_Temp(i, j) := False;
                end case;
            end loop;
        end loop;
        Board_Crt := Board_Temp;
    end Update_Board;

    procedure Clear_Screen is
        use Ada.Text_Io;
    begin
        Put(ASCII.ESC & "[2J");
    end Clear_Screen;

    procedure Print_Board (Board_Crt : in Board;
                           Message   : in String) is
        use Ada.Text_Io;
    begin
        Clear_Screen;
        Put_Line (Message);
        New_Line;

        Put ("-");
        for i in Width_Range loop
            Put ("-");
        end loop;
        Put_Line ("-");

        for i in Height_Range loop
            Put ("|");
            for j in Width_Range loop
                if Board_Crt (i, j) then
                    Put ("X");
                else
                    Put (" ");
                end if;
            end loop;
            Put_Line ("|");
        end loop;

        Put ("-");
        for i in Width_Range loop
            Put ("-");
        end loop;
        Put_Line ("-");
    end Print_Board;

    procedure Loop_To_Print (Board_Crt  : in out Board;
                             Delay_TIme : in     Duration) is
    use Ada.Strings.Unbounded;

    Message : Unbounded_String;

    subtype Iter is Integer range 0..1024;
    begin
        for i in Iter loop
            Message := To_Unbounded_String ("Iteration: " &
                                            Integer'Image(i));
            Print_Board  (Board_Crt, To_String(Message));
            Update_Board (Board_Crt);
            delay Delay_Time;
        end loop;
    end Loop_To_Print;
end Game_Of_Life;
