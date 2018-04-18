program AlienGame;
{ Shoot down a red alien spacecraft with a green or blue missile. }
{ Uses graphics and non-blocking read. }

#include "gdefs.pm"
#include "iodefs.pm"
const
        AlienHead	= 1;	{ Graphics handles }
        AlienBody	= 2;
        Missile1Head	= 3;
        Missile1Body	= 4;
        Missile2Head    = 5;
        Missile2Body    = 6;

        MaxX            = 500;	{ Size of screen }

        AlienStartX	= 30;	{ Initial positions of graphics objects }
        MissileStartY	= 400;
        Missile1StartX	= 400; 
        Missile2StartX  = 300; 

        AlienDelta	= 20;	{ Deltas for moving graphics objects }
        MissileDelta	= -20; 
        AlienRowSize	= 40;	{ Step for initial location of alien }


var 
	S:        binarysem := 1;	{ Protect variables and screen }
	Shoot1:   binarysem := 0; 	{ Shoot first missile }
        Shoot2:   binarysem := 0;       { Shoot second missile }
	Exploded: binarysem := 0;	{ Missile has exploded }
	
	AlienX, AlienY: integer;
					{ Current position of alien }
	HitAlien: boolean;		{ Has alien been hit ? }
	Hits:     integer := 0;		{ Number of aliens hit }

function abs(I: integer) : integer;
begin
  if I < 0 then abs := -I else abs := I
end;

procedure Alien;
begin
  AlienX := AlienStartX; AlienY := random(8) * AlienRowSize;
  wait(S);
  Create(AlienBody,   RECTANGLE, RED, AlienX, AlienY,  30, 30);
  Create(AlienHead,   CIRCLE,    RED, AlienX+30, AlienY,  30, 30);
  signal(S);
  while true do  
    begin
    HitAlien := false;
    while (AlienX < MaxX) and not HitAlien do
      begin
        wait(S);
        MoveBy(AlienHead, AlienDelta, 0);
        MoveBy(AlienBody, AlienDelta, 0);
        AlienX := AlienX + AlienDelta;
        signal(S);
      end;
    AlienX := AlienStartX; AlienY := random(8) * AlienRowSize;
    wait(S);
    MoveTo(AlienBody, AlienX, AlienY);
    MoveTo(AlienHead, AlienX+30, AlienY);
    signal(S);
  end;
end;

procedure Missile1;
var MissileX, MissileY: integer;
begin
  MissileX := Missile1StartX; MissileY := MissileStartY;
  wait(S);
  Create(Missile1Body, RECTANGLE, BLUE, MissileX, MissileY, 30, 50);
  Create(Missile1Head, TRIANGLE,  BLUE, MissileX+15, MissileY-30, 30, 30);
  signal(S);
  while true do
    begin
      wait(Shoot1);
      while (MissileY > 0) and not HitAlien do
        begin
          wait(S);
          HitAlien := (abs(MissileY - AlienY) < 50) and
	              (abs(AlienX - MissileX) < 50);
	  moveby(Missile1Head, 0, MissileDelta);
	  moveby(Missile1Body, 0, MissileDelta);
          signal(S);
	  MissileY := MissileY + MissileDelta;
          if HitAlien then 
		begin 
		hits := hits + 1; 
		writeln('Hits = ', hits); 
		MakeVisible(Missile1Head, 0);
		MakeVisible(Missile1Body, 0);
		end
        end;
      signal(Exploded);
      MissileX := Missile1StartX; MissileY := MissileStartY;
      wait(S);
      MoveTo(Missile1Body, MissileX, MissileY);
      MoveTo(Missile1Head, MissileX+15, MissileY-30);
      signal(S);
      end;
end;

procedure Missile2;
var MissileX, MissileY: integer;
begin
  MissileX := Missile2StartX; MissileY := MissileStartY;
  wait(S);
  Create(Missile2Body, RECTANGLE, GREEN, MissileX, MissileY, 30, 50);
  Create(Missile2Head, TRIANGLE,  GREEN, MissileX+15, MissileY-30, 30, 30);
  signal(S);
  while true do
    begin
      wait(Shoot2);
      while (MissileY > 0) and not HitAlien do
        begin
          wait(S);
          HitAlien := (abs(MissileY - AlienY) < 50) and
	              (abs(AlienX - MissileX) < 50);
          moveby(Missile2Head, 0, MissileDelta);
          moveby(Missile2Body, 0, MissileDelta);
          signal(S);
	  MissileY := MissileY + MissileDelta;
          if HitAlien then 
		begin 
		hits := hits + 1; 
		writeln('Hits = ', hits); 
                MakeVisible(Missile2Head, 0);
                MakeVisible(Missile2Body, 0);
		end
        end;
      signal(Exploded);
      MissileX := Missile2StartX; MissileY := MissileStartY;
      wait(S);
      MoveTo(Missile2Body, MissileX, MissileY);
      MoveTo(Missile2Head, MissileX+15, MissileY-30);
      signal(S);
      end;
end;

procedure Launcher;
var C: char;
    Missiles: integer;
begin
  Missiles := 0;
  while true do
    begin
      C := GetChar;
      if C <= 'm' then signal(Shoot1) else signal(Shoot2);
      Missiles := Missiles + 1;
      writeln('Missiles shot = ', Missiles);
      wait(Exploded);
    end;
end;

begin
	cobegin
                Missile1; Missile2; Launcher;  Alien;
	coend;
end.
