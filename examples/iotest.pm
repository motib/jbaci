program IOTest;
{
	Test non-blocking read.
	Input initial values in main program.
	Print out initial values until new character and integer values are input.
	Then print the new values indefinitely.
}	
#include 'iodefs.pm'

var C: char;
    N: integer;

procedure input;
begin
  C := getChar;
  N := getNum;
end;

procedure output;
begin
  while true do
    begin
      write(C);
      write(N);
      writeln;
    end;
end;

begin
  writeln('Enter initial character value: ');
  readln(C);
  writeln('Enter initial integer value: ');
  readln(N);
  writeln('Initial values are: ', C, '  ', N);
  cobegin
    input;
    output;
  coend;
end.
