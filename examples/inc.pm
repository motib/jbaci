program Inc;
var N1, N2: integer;

procedure Incr1;
var Local: integer;
begin
  Local := N2;
  N1 := N1 + Local;
end;

procedure Incr2;
var Local: integer;
begin
  Local := N1;
  N2 := N2 + Local;
end;

begin
  N1 := 5;
  N2 := 10;
  cobegin
    Incr1;
    Incr2;
  coend;
  write('N1 = '); write(N1); 
  write(', N2 = '); writeln(N2);
end.

