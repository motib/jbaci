program Graph;
{ Demonstate jBACI graphics; fragment of alien program. }

#include "gdefs.pm"
const
	ALIENHEAD = 1;		ALIENBODY = 2;
	MISSILEHEAD = 3; 	MISSILEBODY = 4;
var	s: binarysem := 1;

	procedure MoveAlien;
	var I: integer;
	begin
		for I := 1 to 40 do
			begin
			wait(s);
			moveby(ALIENHEAD, 10, 0);
			moveby(ALIENBODY, 10, 0);
			signal(s);
			end
	end;

	procedure Shoot;
	var I: integer;
	begin
		for I := 1 to 40 do
			begin
			wait(s);
			moveby(MISSILEHEAD, 0, -11);
			moveby(MISSILEBODY, 0, -11);
			signal(s);
			end
	end;

begin
	create(ALIENBODY,   RECTANGLE, RED,   30, 50,  30, 30);
	create(ALIENHEAD,   CIRCLE,    RED,   60, 50,  30, 30);
	create(MISSILEBODY, RECTANGLE, BLUE, 400, 400, 30, 50);
	create(MISSILEHEAD, TRIANGLE,  BLUE, 415, 370, 30, 30);
	cobegin
		Shoot;
		MoveAlien;
	coend;
end.
