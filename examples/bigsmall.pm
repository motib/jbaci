program Bigsmall;
{ Dijkstra's algorithm for exchanging big/small elements of a set. }

const Last = 20;
type List = array[1..Last] of integer;

var BigInSmall, SmallInBig: integer;
    BinSFree,  SinBFree:    binarysem := 1;
    BinSReady, SinBReady:   binarysem := 0;
    Display:                binarysem := 1;

procedure SmallSet;
const NS = 5;
var S: List;
    Index: integer;
	procedure GetMax(var A: List; Len: integer; var Max: integer);
	var I: integer;
	begin
		Max := 1; 
		for I := 2 to Len do if A[I] > A[Max] then Max := I;
	end;
begin
  S[1] := 4; S[2] := 1; S[3] := 7; S[4] := 5; S[5] := 0;
  Wait(Display);
  write('Small set (before): '); for Index := 1 to NS do write(S[Index], ' '); writeln;
  Signal(Display);
  while BigInSmall > SmallInBig do
    begin
      GetMax(S, NS, Index);
      Wait(BinSFree);
      BigInSmall := S[Index];
      Signal(BinSReady);
      Wait(SinBReady);
      if BigInSmall > SmallInBig then
        S[Index] := SmallInBig;
      Signal(SinBFree);
    end;
  Signal(BinSReady);
  Wait(Display);
  write('Small set (after): '); for Index := 1 to NS do write(S[Index], ' '); writeln;
  Signal(Display);
end;

procedure BigSet;
const NB = 4;
var B: List;
    Index: integer;
	procedure GetMin(var A: List; Len: integer; var Min: integer);
	var I: integer;
	begin
		Min := 1; for I := 2 to Len do if A[I] < A[Min] then Min := I;
	end;
begin
  B[1] := 1; B[2] := 3; B[3] := 2; B[4] := 8;
  Wait(Display);
  write('Big set (before):   '); for Index := 1 to NB do write(B[Index], ' '); writeln;
  Signal(Display);
  while BigInSmall > SmallInBig do
    begin
      GetMin(B, NB, Index);
      Wait(SinBFree);
      SmallInBig := B[Index];
      Signal(SinBReady);
      Wait(BinSReady);
      if BigInSmall > SmallInBig then
        B[Index] := BigInSmall;
      Signal(BinSFree);
    end;
  Signal(SinBReady);
  Wait(Display);
  write('Big set (after):   '); for Index := 1 to NB do write(B[Index], ' '); writeln;
  Signal(Display);
end;

begin
  BigInSmall := 20000; SmallInBig := -20000;
  cobegin
    SmallSet;
    BigSet;
  coend;
end.

