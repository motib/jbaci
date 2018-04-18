program Sem3;
{ Critical section with three processes. }
{ Demonstrate starvation with weak semaphores. }

var s: binarysem := 1;

procedure p1;
begin
  wait(s);
  writeln('P1 is in critical section');
  signal(s);
end;

procedure p2;
begin
  wait(s);
  writeln('P2 is in critical section');
  signal(s);
end;

procedure p3;
begin
  wait(s);
  writeln('P3 is in critical section');
  signal(s);
end;

begin
  cobegin
    p1;
    p2;
    p3;
  coend;
end.

