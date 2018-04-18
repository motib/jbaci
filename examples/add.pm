program Add;
{ Add 10 to a variable in each of two processes. }
{ The answer can be between 2 and 20. }
{ Local variable enables bad scenario with source-level interleaving. }
var sum: integer := 0;

procedure add10;
var i: integer;
    local: integer;
begin
	for i := 1 to 10 do
		begin
		local := sum;
		sum := local + 1
		end
end;

begin
	cobegin
		add10;
		add10;
	coend;
	writeln('Sum = ', sum);
end.
