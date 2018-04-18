program Hello;

procedure English;
begin
  write('Hello ');
  writeln('World ');
end;

procedure Hebrew;
begin
  write('Shalom ');
  writeln('Olam   ');
end;

procedure French;
begin
  write('Bonjour ');
  writeln('Monde   ');
end;

begin
  cobegin
    English;
    Hebrew;
    French;
  coend;
end.
