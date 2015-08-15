package Game_Of_Life is
    Board_Height : constant Integer := 34;
    Board_Width  : constant Integer := 120;

    type Height_Index is mod Board_Height;
    type Width_Index  is mod Board_Width;

    subtype Percent      is Integer      range 0..100;

    subtype Height_Range is Height_Index range 0..Height_Index'Last;
    subtype Width_Range  is Width_Index  range 0..Width_Index'Last;

    type Board is array (Height_Index, Width_Index)
                  of Boolean;

    function New_Board return Board;

    procedure Init_Board    (Board_Crt  :    out Board;
                             Fill       : in     Percent);
    procedure Loop_To_Print (Board_Crt  : in out Board;
                             Delay_Time : in     Duration);
end Game_Of_Life;
