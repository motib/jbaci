program Conway;

var B1, B2, B3: integer;
    Empty1: binarysem := 1;
    Empty2: binarysem := 1;
    Empty3: binarysem := 1;
    Full1:  binarysem := 0;
    Full2:  binarysem := 0;
    Full3:  binarysem := 0;

procedure Producer;
var R, I: integer;
begin
  for I := 1 to 20 do
    begin
      R := random(100);
      wait(Empty1);
      B1 := R;
      signal(Full1);
    end;
end { Producer };

procedure CheckEven;
var N: integer;
begin
  while true do
    begin
      wait(Full1);
      N := B1;
      signal(Empty1);
      wait(Empty2);
      B2 := N;
      signal(Full2);
      if N mod 2 = 0 then
        begin
          wait(Empty2);
          B2 := 0;
          signal(Full2);
        end;
    end;
end { CheckEven };

procedure CheckLine;
var N, Count: integer;
begin
  Count := 1;
  while true do
    begin
      wait(Full2);
      N := B2;
      signal(Empty2);
      wait(Empty3);
      B3 := N;
      signal(Full3);
      if Count mod 5 = 0 then
        begin
          wait(Empty3);
          B3 := -1;
          signal(Full3);
        end;
      Count := Count + 1;
    end;
end { CheckLine };

procedure Consumer;
var K: integer;
begin
  while true do
    begin
      wait(Full3);
      K := B3;
      signal(Empty3);
      if K < 0 then writeln 
      else begin write(K); write(' ') end;
    end;    
end { Consumer };

begin
  cobegin
    Producer; CheckEven; CheckLine; Consumer;
  coend;
end { Conway }.

