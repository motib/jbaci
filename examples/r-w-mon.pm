program ReadersWriters;

monitor RW;
var	readercount: integer;
	busy: boolean;
	OKtoRead, OKtoWrite: condition;

procedure StartRead;
begin 
	if busy or not empty(OKtoWrite) then 
		waitc(OKtoRead);
	readercount := readercount + 1;
	writeln("Reader count is ", readercount);
	signalc(OKtoRead);
end;

procedure EndRead;
begin
	readercount := readercount - 1;
	if readercount = 0 then
		signalc(OKtoWrite);
end;

procedure StartWrite;
begin 
	if busy or (readercount <> 0) then 
		waitc(OKtoWrite);
	busy := true;
end;

procedure EndWrite;
begin
	busy := false;
	if empty(OKtoRead) then 
		signalc(OKtoWrite)
	else
		signalC(OKtoRead);
end;

begin
	readercount := 0;
	busy := false;
end;

procedure Reader(N: integer);
var	I: integer;
begin
	for I := 1 to 10 do
		begin
		StartRead;
		writeln(N, " is reading");
		EndRead;
		end;
end;

procedure Writer(N: integer);
var	I: integer;
begin
	for I := 1 to 10 do
		begin
		StartWrite;
		writeln(N, " is writing");
		EndWrite;
		end;
end;

begin
	cobegin
		Reader(1); Reader(2); Reader(3);
		Writer(1); Writer(2);
	coend;
end.

