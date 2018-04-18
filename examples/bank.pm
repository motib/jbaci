program Bank;
{ Concurrent access to a bank account. }
{ Written by Yifat Ben-David Kolikant. }

const
     MaxA = 4;

var 
    Col:      array[1..2] of integer;
    Accounts: array[1..MaxA] of integer;
    ASem:     array [1..MaxA] of semaphore;
    S:        semaphore := init(1);  {this semaphore is for the printing section}
    i:integer;

procedure DisplayBalance(Teller: integer; ANumber: integer; Balance: integer);  
begin
{  wait(S);}
    writeln('teller',Teller,' says that account number ',ANumber,' has the balance of: ',balance,' shkalim');
{  signal(S);}
end;

procedure DisplayError(Teller: integer; ANumber: integer; Amount: integer);  
begin
  wait(S);
    writeln('teller',Teller,' says that account number ',ANumber,' cannot withdraw ',Amount,' shkalim');
  signal(S);
end;

procedure Withdraw(ANumber: integer; Amount: integer; var Balance: integer; var OK: boolean);
  {this procedure withdraw the some if posible}
begin
  wait(ASem[ANumber]);
    OK := Amount <= Accounts[ANumber];
    if OK then
       Accounts[ANumber] := Accounts[ANumber] - Amount;
    Balance := Accounts[ANumber];
  signal(ASem[ANumber]);
end;

procedure AddSalary(ANumber: integer; Amount: integer);  
begin
  {wait(ASem[ANumber]);}
  Accounts[ANumber] := Accounts[ANumber] + Amount;
  {signal(ASem[ANumber]);}
end;

procedure GetBalance(ANumber: integer; var Balance: integer);
begin
  Balance := Accounts[ANumber];
end;

process Teller(me:integer); 
{this process is the teller, the "me" parameter is its place at the bank}
var Action, ANumber, Balance, Amount: integer; OK: boolean;
begin
    while true do
        begin
          ANumber:= (random(100) mod MaxA) + 1;
          Action:=random(1);
        if Action = 0 then
            begin
              GetBalance(ANumber, Balance);
              DisplayBalance(Me, ANumber, Balance);
            end
        else
            begin
              Amount:=random(100);
              Withdraw(ANumber, Amount, Balance, OK);
              if OK then
                 DisplayBalance(Me, ANumber, Balance)
              else
              DisplayError(Me, ANumber, Amount)
            end;
        end;
end;

process MainBranch;                               
var ANumber, Amount: integer;
begin
    while true do
        begin
          ANumber := (random(100) mod MaxA) + 1;
          Amount:=random(100);
          AddSalary(ANumber, Amount);
        end;
end;

begin  {main}
  for i := 1 to MaxA do initialsem(ASem[i], 1);
    parbegin
         Teller(1); Teller(2); MainBranch;
    parend;
end.
