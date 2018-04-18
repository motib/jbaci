program Fair;
{ Example for demonstrating fairness. }

var   N: integer := 0;
      B: boolean; 

      procedure P1 ;
      begin
             while B do 
                     N := N+1;
      end ;

      procedure P2 ; 
      begin
             B := false ;
      end ;

begin
        B := true;
        cobegin
               P1 ; 
               P2 ; 
        coend ;  
        write('N='); writeln(N ); 
end.

