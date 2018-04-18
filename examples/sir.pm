program Sirpinska;
{ Demonstration of jBACI graphics commands - Sirpinska space-filling. }
{ Written by Shmuel Schwartz. }

#include "gdefs.pm"
const w=450; h=450;
var rec_num: integer;
s:semaphore:=1;

procedure subrec(x,y,l,i:integer);
begin
if i>0 then
begin
  create(rec_num,RECTANGLE,1,x-(l div 2),y-(l div 2),l,l);
  rec_num:=rec_num+1;
  subrec(x - l,y - l,l div 3,i-1);
  subrec(x,y - l,l div 3,i-1);
  subrec(x + l,y - l,l div 3,i-1);
  subrec(x - l,y,l div 3,i-1);
  subrec(x + l,y,l div 3,i-1);
  subrec(x - l,y + l,l div 3,i-1);
  subrec(x,y + l,l div 3,i-1);
  subrec(x + l,y + l,l div 3,i-1);
end;
writeln(i);
end;

begin
rec_num:=1;
	create(0,RECTANGLE,white,0,0,600,600);
	create(1000,RECTANGLE,black,450,0,150,450);
	subrec(w div 2,h div 2,h div 3,3);
	writeln('ended ');
end.
