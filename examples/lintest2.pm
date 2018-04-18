program LindaTest2;
{ Test of Linda primitives - actual vs. formal parameters }
{ Follow instructions carefully! }
{ Start by stepping p1 }
{ Comments describe observable results }

process p1;
var i1, i2: integer; 
begin
  postnote('x', 1, 2);		{ Posts note }

  i1 := 5; i2 := 6;
  readnote('x', i1, i2);
  writeln(i1, ' ', i2);		{ Prints 1 2 }
  i1 := 1; i2 := 2;
  readnote('x', i1=, i2=);	{ First syntax }
  writeln(i1, ' ', i2);		{ Prints 1 2 }
  i1 := 1; i2 := 2;
  readnoteeq('x', i1, i2);	{ Second syntax }
  writeln(i1, ' ', i2);		{ Prints 1 2 }

  i1 := 3; i2 := 4;
  readnote('x', i1=, i2=);	{ First syntax }
				{ Blocks - run a step from p2 }
  writeln(i1, ' ', i2);		{ Prints 3 4 }
  i1 := 5; i2 := 6;
  readnoteeq('x', i1, i2);	{ Second syntax }
				{ Blocks - run a step from p2 }
  writeln(i1, ' ', i2);		{ Prints 5 6 }
  
  i1 := 3; i2 := 5;
  removenote('x', i1=, i2);	{ Removes node ('x',3,4) }
  writeln(i1, ' ', i2);		{ Prints 3 4 }

  i1 := 7; i2 := 6;
  removenote('x', i1, i2=);	{ Removes node ('x',5,6) }
  writeln(i1, ' ', i2);		{ Prints 5 6 }

  i1 := 2; i2 := 2;
  removenote('x', i1=, i2);
				{ Blocks - run a step from p2 }
  writeln(i1, ' ', i2);		{ Prints 2 6 }
end;

process p2;
begin
  postnote('x', 3, 4);		{ Posts note }
  { Run a step from p1 }
  postnote('x', 5, 6);		{ Posts note }
  { Run a step from p1 }
  postnote('x', 2, 6);		{ Posts note }
  { Run a step from p1 }
end;

begin
  cobegin p1; p2; coend;
end.
