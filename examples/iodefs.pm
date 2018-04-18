{ Function for non-blocking input of character value }  
function getChar: char;
const flag = '\r';
var D: char := flag;
begin
  while D = flag do nbread(D);
  getChar := D;
end;

{ Function for non-blocking input of integer value }  
function getNum: integer;
const flag = -32767;
var I: integer := flag;
begin
  while I = flag do nbread(I);
  getNum := I;
end;

