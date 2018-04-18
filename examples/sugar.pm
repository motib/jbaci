program Sugar;
var sugar: integer := 0;
    s: binarysem := 1;

procedure Kid(k: integer);
begin
  wait(s);
  if sugar < 1 then
      begin
      write('Kid '); write(k); writeln(' is getting a cube');
      sugar := sugar + 1;
    end;
  signal(s);
end;

begin
  cobegin
    Kid(1);
    Kid(2);
  coend;
  write('Total cubes is: ');
  writeln(sugar);
end.

