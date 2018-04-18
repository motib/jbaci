program MonitorSemaphore;
{ Monitor implementation of semaphore. }

MONITOR monSemaphore;
VAR
	semvalue : INTEGER;
	notbusy : CONDITION;
PROCEDURE monP;
BEGIN
	IF (semvalue = 0) THEN
		WAITC(notbusy)
	ELSE
		semvalue := semvalue - 1;
END;

PROCEDURE monV;
BEGIN
	IF (EMPTY(notbusy)) THEN
		semvalue := semvalue + 1
	ELSE
		SIGNALC(notbusy);
END;

BEGIN { initialization code }
	semvalue := 1;
END; // of monSemaphore monitor

var n: integer;

procedure inc(i: Integer);
begin
  monP;
  n := n + 1;
  monV;
end;

begin
  cobegin 
  	inc(1); inc(2);
  coend;
  writeln(n);
end.
