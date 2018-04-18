program LindaTest;

process p1;
var	i1, i2: integer; 
begin
  postnote('x', 11, 22);
{
  i1 := 111; i2 := 222;
  readnote('x', i1, i2);
  writeln(i1, ' ', i2);

  i1 := 111; i2 := 222;
  readnote('x', i1=, i2=);
  writeln(i1, ' ', i2);

  i1 := 111; i2 := 22;
  readnote('x', i1=, i2);  
  writeln(i1, ' ', i2);
}
  i1 := 111; i2 := 22;
  readnote('x', i1, i2=);  
  writeln(i1, ' ', i2);
end;

begin
  cobegin p1; coend;
end.
