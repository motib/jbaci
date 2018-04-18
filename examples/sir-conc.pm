program Sirpinska;
{ Demonstration of jBACI graphics commands - concurrent Sirpinska space-filling. }
{ Written by Shmuel Schwartz. }

#include "gdefs.pm"
const w=450; h=450;
var rec_num: integer;
s:semaphore:=1;

procedure subrec(x,y,l,i,color:integer);
begin
if i>0 then
begin

wait(s);
create(rec_num,RECTANGLE,color,x-(l div 2),y-(l div 2),l,l);  
rec_num:=rec_num+1;
signal(s);
  subrec(x - l,y - l,l div 3,i-1,color);
  subrec(x,y - l,l div 3,i-1,color);
  subrec(x + l,y - l,l div 3,i-1,color);
  subrec(x - l,y,l div 3,i-1,color);
  subrec(x + l,y,l div 3,i-1,color);
  subrec(x - l,y + l,l div 3,i-1,color);
  subrec(x,y + l,l div 3,i-1,color);
  subrec(x + l,y + l,l div 3,i-1,color);
end;
writeln(i);
end;

procedure carpet(x,y,l,i,color:integer);
begin
	subrec(x,y,l,i,color);
	writeln(i,' ended ');
end;


begin {main}
rec_num:=1;
	create(0,RECTANGLE,white,0,0,600,600);
	create(1000,RECTANGLE,black,450,0,150,450);
 	create(rec_num,RECTANGLE,2,w div 3,h div 3,h div 3,h div 3);  
	rec_num:=rec_num+1;
cobegin
	carpet(w div 2 - h div 3,h div 2 - h div 3,(h div 3) div 3,2,5);
	carpet(w div 2,h div 2 - h div 3,(h div 3) div 3,2,1);
	carpet(w div 2 + h div 3,h div 2 - h div 3,(h div 3) div 3,2,3);
	carpet(w div 2 - h div 3,h div 2,(h div 3) div 3,2,4);
	carpet(w div 2 + h div 3,h div 2 ,(h div 3) div 3,2,5);
	carpet(w div 2 - h div 3,h div 2 + h div 3,(h div 3) div 3,2,6);
	carpet(w div 2,h div 2 + h div 3,(h div 3) div 3,2,1);
	carpet(w div 2 + h div 3,h div 2 + h div 3,(h div 3) div 3,2,6);
coend;
	writeln('main ended ');
end.
