program LindaTest;
{ Test of Linda primitives }
{ Follow numbered instructions carefully! }

process p1;
var	c: char; 
	i1, i2: integer; 
begin
  { 1. Step process p1 until **** }

  { Check post-, read- and remove-note }
  postnote('m', 10, 20);
  readnote('m', i1, i2);
  writeln(i1, ' ', i2);
  removenote('m', i1, i2);
  writeln(i1, ' ', i2);

  { Check different size notes }
  postnote('a');
  readnote('a');
  readnote('a', i1, i2);  { OK, parameters are not counted }
  writeln(i1, ' ', i2);
  removenote('a');
  postnote('b', 7);
  removenote('b', i1);
  writeln(i1);
  
  { Check values vs. variables }
  
  postnote('c', 1, 2);
  c := 'd'; i1 := 8; i2 := 9;
  postnote(c, i1, i2);
  readnote('c', i1, i2);
  writeln(i1, ' ', i2);
  readnote(c, i1, i2);
  writeln(i1, ' ', i2);
  removenote('c', i1, i2);
  writeln(i1, ' ', i2);
  removenote(c, i1, i2);
  writeln(i1, ' ', i2);
  
  { Check blocking/unblocking }
  
  readnote('a', i1, i2);  { **** }

  { 5. Step p1 until ++++ }
  writeln(i1, ' ', i2);
  removenote('a', i1, i2);
  removenote('b', i1, i2);

  { Check read/remove with EQ }

  postnote('x', 11, 22);
  postnote('y', 33, 44);
  i1 := 111; i2 := 222;
  readnoteeq('x', i1, i2); { ++++ }

  { 7. Step p1 until ==== }
  writeln(i1, ' ', i2);
  removenoteeq('x', i1, i2);  
  writeln(i1, ' ', i2);
  removenote('x', i1, i2);

  i1 := 333; i2 := 444;
  removenoteeq('y', i1, i2); { ==== }
  writeln(i1, ' ', i2);
  removenote('y', i1, i2);
end;

process p2;
begin
  { 2. Step this instruction after p1 blocks } 
  postnote('b', 55, 66);
  
  { 3. Step p1 again to make sure that it blocks again }
  
  { 4. Step this instruction to unblock p1 }
  postnote('a', 77, 88);
  
  { 6. Step this instruction after p1 blocks }
  postnote('x', 111, 222);

  { 8. Step this instruction to unblock p1 }
  postnote('y', 333, 444);
end;

begin
  cobegin p1; p2; coend;
end.
