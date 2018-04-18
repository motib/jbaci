program Grades;
{ Concurrent input and calculation of grades. }
{ Program needs synchronization for both critical section and order of execution. }
{ Written by Yifat Ben-David Kolikant. }

var GradeA, GradeB: integer;
    Final: integer;

procedure Max(X,Y,Z: integer; var M: integer);
begin
  if (X>Y) and (X>Z) then
    M:= X
  else
    if (Z>Y) and (Z>X) then
      M:= Z
    else
      M:= Y;
end {Max};

process First;
var A, B, C: integer;
begin
  writeln('Enter grade of first semester:');
  write(A);
  read(A);
  read(B);
  read(C);
  Max(A, B, C, GradeA);
  writeln('the grades were: ',A,' ',B,' ',C);
end {First};

process Second;
var D, E, F: integer;
begin
  writeln('Enter grade of second semester:');
  read(D);
  read(E);
  read(F);
  Max(D, E, F, GradeB);
  writeln('the grades were: ',D,' ',E,' ',F);
end {Second};

process Average;
begin
  Final := (GradeA + GradeB) div 2;
  write('The final grade is :');
  writeln(Final);
end {Average};

begin
  parbegin
    First;
    Second;
    Average;
  parend;
end.
