program Philosophers;
{ Dining philosophers with Room semaphore. }

const M = 5;

var Fork1: binarysem := 1;
    Fork2: binarysem := 1;
    Fork3: binarysem := 1;
    Fork4: binarysem := 1;
    Fork5: binarysem := 1;
    Room:  semaphore := 4;

procedure Phil1;
var I: Integer;
begin
  for I := 1 to M do
    begin
    wait(Room);
    wait(Fork1);
    wait(Fork2);
    writeln('P1 is eating');
    signal(Fork2);
    signal(Fork1);
    signal(Room);
    end;
end;

procedure Phil2;
var I: Integer;
begin
  for I := 1 to M do
    begin
    wait(Room);
    wait(Fork2);
    wait(Fork3);
    writeln('P2 is eating');
    signal(Fork3);
    signal(Fork2);
    signal(Room);
    end;
end;

procedure Phil3;
var I: Integer;
begin
  for I := 1 to M do
    begin
    wait(Room);
    wait(Fork3);
    wait(Fork4);
    writeln('P3 is eating');
    signal(Fork4);
    signal(Fork3);
    signal(Room);
    end;
end;

procedure Phil4;
var I: Integer;
begin
  for I := 1 to M do
    begin
    wait(Room);
    wait(Fork4);
    wait(Fork5);
    writeln('P4 is eating');
    signal(Fork5);
    signal(Fork4);
    signal(Room);
    end;
end;

procedure Phil5;
var I: Integer;
begin
  for I := 1 to M do
    begin
    wait(Room);
    wait(Fork5);
    wait(Fork1);
    writeln('P5 is eating');
    signal(Fork1);
    signal(Fork5);
    signal(Room);
    end;
end;

begin
  cobegin
    Phil1;
    Phil2;
    Phil3;
    Phil4;
    Phil5;
  coend;
end.

