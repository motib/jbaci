program DivMod;
{ Take a number apart and put it back together reversed. }

var Num, NewNum, Digit: integer;
    DigitFull:  binarysem := 0;
    DigitEmpty: binarysem := 1;
    NumFull:    binarysem := 0;
    NumEmpty:   binarysem := 1;

procedure TakeApart;
begin
  while Num > 0 do
    begin
      Wait(DigitEmpty);
      Digit := Num mod 10;
      Signal(DigitFull);
      Wait(NumEmpty);
      Num   := Num div 10;
      Signal(NumFull);
    end;
end;

procedure BuildUp;
var Finished: boolean;
begin
  Finished := False;
  Wait(DigitFull);
  while not Finished do
    begin
      NewNum := NewNum*10 + Digit;
      Signal(DigitEmpty);
      Wait(NumFull);
      Finished := Num = 0;
      if not Finished then
        begin
          Signal(NumEmpty);
          Wait(DigitFull);
        end;
    end;
end;

begin
  Num    := 567;
  NewNum := 0;
  cobegin
    TakeApart;
    BuildUp;
  coend;
  writeln(NewNum);
end.

