program Philosophers;
{ Dining philosophers: demonstrate array of semaphores. }

const 	M = 5;
	MMINUSONE = 4;
	
var	Fork: array[0 .. MMINUSONE] of binarysem;
	K: integer;

procedure Phil(N: integer);
var I: Integer;
begin
  for I := 1 to 10 do
    begin
    wait(Fork[N]);
    wait(Fork[(N+1) mod M]);
    writeln('P', N, ' is eating');
    signal(Fork[(N+1) mod M]);
    signal(Fork[N]);
    end;
end;

begin
  for K := 0 to MMINUSONE do initialsem(Fork[K], 1);
  cobegin
    Phil(0); Phil(1); Phil(2); Phil(3); Phil(4);  
  coend;
end.

