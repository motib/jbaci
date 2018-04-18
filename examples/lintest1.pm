program LindaTest1;
{ Test of Linda primitives }
{ Follow instructions carefully! }
{ Start by stepping p1 }
{ Comments describe observable results }

process p1;
var	c: char; 
	i1, i2: integer; 
begin
  { 1. Step process p1 until **** }

  { Check post-, read- and remove-note }
  postnote('m', 10, 20);    { Posts note }
  readnote('m', i1, i2);
  writeln(i1, ' ', i2);     { Prints 10 20 }
  removenote('m', i1, i2);  { Removes note }
  writeln(i1, ' ', i2);     { Prints 10 20 }

  { Check different size notes }
  postnote('a');          { Posts note }
  readnote('a');
  readnote('a', i1, i2);  { (OK, parameters are not counted) }
  writeln(i1, ' ', i2);   { Prints -32767 -32767 }
  removenote('a');        { Removes note ('a') }
  postnote('b', 7);       { Posts note }
  removenote('b', i1);    { Removes note ('b',7) }
  writeln(i1);            { Prints 7 }
  
  { Check values vs. variables }
  
  postnote('c', 1, 2);    { Posts note }
  c := 'd'; i1 := 8; i2 := 9;
  postnote(c, i1, i2);    { Posts note }
  readnote('c', i1, i2);
  writeln(i1, ' ', i2);   { Prints 1 2 }
  readnote(c, i1, i2);
  writeln(i1, ' ', i2);   { Prints 8 9 }
  removenote('c', i1, i2);{ Removes note ('c',1,2) }
  writeln(i1, ' ', i2);   { Prints 1 2 }
  removenote(c, i1, i2);  { Removes note ('d',8,9) }
  writeln(i1, ' ', i2);   { Prints 8 9 }
  
  { Check blocking/unblocking }
  readnote('a', i1, i2);  { Blocks p1 }
  { **** , step process p2 }

  { Step p1 until ++++ }
  writeln(i1, ' ', i2);     { Prints 77 88 }
  removenote('a', i1, i2);  { Removes note ('a',77,88) }
  writeln(i1, ' ', i2);     { Prints 77 88 }
  removenote('b', i1, i2);  { Removes note ('b',55,66) }
  writeln(i1, ' ', i2);     { Prints 55 66 }
end;

process p2;
begin
  { Step this instruction after p1 blocks } 
  postnote('b', 55, 66);  { Posts note }
  { Step p1 again to make sure that it blocks again }
  { Step this instruction to unblock p1 }
  postnote('a', 77, 88);  { Posts note }
end;

begin
  cobegin p1; p2; coend;
end.
