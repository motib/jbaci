program SortMerge;
{ Sort two halves of an array and then merge them. }

const Last = 20;

type List = array[1..Last] of integer;

var A1, A2, A: List;
    N1, N2: integer;
    I: integer;
    Sort1Finished, Sort2Finished: binarysem := 0;

procedure Sort1;
var I, J, Temp, IMin: integer;
begin
  for I := 1 to N1-1 do
    begin
      IMin := I;
      for J := I+1 to N1 do
        if A1[J] < A1[IMin] then
          IMin := J;
      begin Temp := A1[I]; A1[I] := A1[IMin]; A1[IMin] := Temp; end;
    end;
  Signal(Sort1Finished);
end;

procedure Sort2;
var I, J, Temp, IMin: integer;
begin
  for I := 1 to N2-1 do
    begin
      IMin := I;
      for J := I+1 to N2 do
        if A2[J] < A2[IMin] then
          IMin := J;
      begin Temp := A2[I]; A2[I] := A2[IMin]; A2[IMin] := Temp; end;
    end;
  Signal(Sort2Finished);
end;

procedure Merge;
var IA, IB, IC: integer;
begin
  wait(Sort1Finished);
  wait(Sort2Finished);
  IA := 1; IB := 1; IC := 1;
  while (IA <= N1) and (IB <= N2 ) do
    begin
      if A1[IA] < A2[IB] then
        begin A[IC] := A1[IA]; IA := IA + 1; end
      else
        begin A[IC] := A2[IB]; IB := IB + 1; end;
      IC := IC + 1
    end;
  while IA <= N1 do
    begin A[IC] := A1[IA]; IC := IC + 1; IA := IA + 1; end;
  while IB <= N2 do
    begin A[IC] := A2[IB]; IC := IC + 1; IB := IB + 1; end;
end;

begin
  A1[1] := 4; A1[2] := 1; A1[3] := 7; A1[4] := 5; A1[5] := 0;
  A2[1] := 8; A2[2] := 2; A2[3] := 6; A2[4] := -1;
  N1 := 5; N2 := 4;
  write('A1 = '); for I := 1 to N1 do write(A1[I], ' '); writeln;
  write('A2 = '); for I := 1 to N2 do write(A2[I], ' '); writeln;
  cobegin
    Sort1;
    Sort2;
    Merge;
  coend;
  write('A1 = '); for I := 1 to N1 do write(A1[I], ' '); writeln;
  write('A2 = '); for I := 1 to N2 do write(A2[I], ' '); writeln;
  write('A  = '); for I := 1 to N1+N2 do write(A[I], ' '); writeln;
end.

