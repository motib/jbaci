program AddSem;
{ Add 10 to a variable in each of two processes. }
{ With a semaphore ensuring mutual exclusion, the answer is 20. }
var sum: integer := 0;
    s : binarysem := 1;

procedure add10;
var i: integer;
    local: integer;
begin
	for i := 1 to 10 do
		begin
		wait(s);
		local := sum;
		sum := local + 1;
		signal(s)
		end
end;

begin
	cobegin
		add10;
		add10;
	coend;
	writeln('Sum = ', sum);
end.

