{
	BACI implementation of a Linda Tuple Space - V1.0 (Pascal).
	Author: Moti Ben-Ari, 2003.
	Tuples are called notes and the tuple space is called the board.
	See jBACI.pdf for more information.

******** Superseded by implementation of Linda within jBACI!!! *************

}	

const	num    = 5;         { Maximum number of notes on board } 
	procs  = 4;         { Maximum number of processes }
	formal = -32767;    { Indicator of empty or formal parameter }
	
type	note   = array[0..2] of integer;     	{ Type of a note - three fields }
var	board:	 array[0..num] of note;      	{ The board of notes }
	waiting: array[0..procs] of boolean;	{ Flags for processes waiting for notes } 

{
	Utilities
		writenote, writespace
		maketuple from three values
		findempty place on the board
		initboard to empty board and no waiting processes
}		
procedure writenote(var t: note);
var c: char;
begin
  if t[0] = formal then write('(empty)') 
  else 
    begin 
    c := t[0]; write (c, ' ');
    if t[1] <> formal then write (t[1], ' ');
    if t[2] <> formal then write (t[2], ' ');
    end;
  writeln
end;

procedure writeboard;
var i: integer;
begin
  writeln('Board is '); for i := 0 to num-1 do writenote(board[i]);
end;

procedure makenote(var t: note; c: char; i1,i2: integer);
var i0: integer;
begin
  i0 := c; t[0] := i0; t[1] := i1; t[2] := i2;
end;

function findempty: integer;
var i: integer;
begin
  i := 0; while (i < num) and not (board[i,0] = formal) do i := i + 1; findempty := i;
end;

procedure initboard;
var i: integer;
begin
  for i := 0 to num do board[i,0] := formal;
  for i := 0 to procs do waiting[i] := false;
end;

{
	Post - output a note, reviving any suspended processes.
	Interfaces: postnote, postnote1, postnote2.
}	
atomic procedure post(var t: note);
var i: integer;
begin
  i := findempty;
  if i = num then writeln('No more room for notes on board')
  else 
  	begin 
  	board[i] := t;
	for i := 0 to procs do
		if waiting[i] then begin revive(i); waiting[i] := false end
	end
end;

procedure postnote(c: char);
var	t: note;
begin
  makenote(t, c, formal, formal); post(t);
end;

procedure postnote1(c: char; i1: integer);
var	t: note;
begin
  makenote(t, c, i1, formal); post(t);
end;

procedure postnote2(c: char; i1: integer; i2: integer);
var	t: note;
begin
  makenote(t, c, i1, i2); post(t);
end;

{
	Read and input a note
		searchnote - the value formal matches anything
		getnote - call searchnote and return values, removing note for input
		readremove - call getnote and suspend if no note available
	Interfaces to read/remove a note with arbitrary parameters: 
		removenote, removenote1, removenote2, readnote, readnote1, readnote2
	Interfaces to read/remove a note that matches parameters (the formal value matches anything):
		removenote1eq, removenote2eq, readnote1eq, readnote2eq
}
function searchnote(var t: note): integer;
var i: integer;
    found: boolean;
begin
  i := 0; found := false;
  while not found and (i < num) do
    begin
    if board[i,0] = formal then found := false
    else found :=
          (t[0] = board[i,0]) and
          ((t[1] = formal) or (board[i,1] = formal) or (t[1] = board[i,1])) and
          ((t[2] = formal) or (board[i,2] = formal) or (t[2] = board[i,2]));
     if not found then i := i + 1
     end;
  searchnote := i;
end;

atomic procedure getnote(var t: note; remove: boolean; var success: boolean);
var i: integer;
begin
  success := false; i := searchnote(t);
  if i < num then 
  	begin t := board[i]; if remove then board[i,0] := formal; success := true end
end;

procedure readremove(var t: note; remove: boolean);
var success: boolean;
begin
  repeat
    getnote(t, remove, success);
    if not success then begin waiting[which_proc] := true; suspend end
  until success
end;

procedure removenote(c: char);
var	t: note;
begin
  makenote(t, c, formal, formal); readremove(t, true); 
end;

procedure removenote1(c: char; var i1: integer);
var	t: note;
begin
  makenote(t, c, formal, formal); readremove(t, true);  i1 := t[1];
end;

procedure removenote2(c: char; var i1: integer; var i2: integer);
var	t: note;
begin
  makenote(t, c, formal, formal); readremove(t, true);  i1 := t[1]; i2 := t[2];
end;

procedure readnote(c: char);
var	t: note;
begin
  makenote(t, c, formal, formal); readremove(t, false); 
end;

procedure readnote1(c: char; var i1: integer);
var	t: note;
begin
  makenote(t, c, formal, formal); readremove(t, false);  i1 := t[1];
end;

procedure readnote2(c: char; var i1: integer; var i2: integer);
var	t: note;
begin
  makenote(t, c, formal, formal); readremove(t, false);  i1 := t[1]; i2 := t[2];
end;

procedure removenote1eq(c: char; var i1: integer);
var	t: note;
begin
  makenote(t, c, i1, formal); readremove(t, true);  i1 := t[1];
end;

procedure removenote2eq(c: char; var i1: integer; var i2: integer);
var	t: note;
begin
  makenote(t, c, i1, i2); readremove(t, true);  i1 := t[1]; i2 := t[2];
end;

procedure readnote1eq(c: char; var i1: integer);
var	t: note;
begin
  makenote(t, c, i1, formal); readremove(t, false);  i1 := t[1];
end;

procedure readnote2eq(c: char; var i1: integer; var i2: integer);
var	t: note;
begin
  makenote(t, c, i1, i2); readremove(t, false);  i1 := t[1]; i2 := t[2];
end;

