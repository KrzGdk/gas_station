  with Ada.Text_IO, Ada.Numerics.Discrete_Random, Tanker;
  use Ada.Text_IO, Tanker;
  
  
  package body pump is
  
  task body PumpO is
  begin
   accept tank(queue : in out Integer;EndTank :  out Time) do
      EndTank := Clock;
      delay Duration(5.0);
      queue:=queue-1; --dzieją się dziwne rzeczy po odkomentowaniu
    end tank;    
    loop
	    select
	      accept tank(queue : in out Integer;EndTank :  out Time) do
			    EndTank := Clock;
			    delay Duration(5.0);
			    queue:=queue-1; --dzieją się dziwne rzeczy po odkomentowaniu
        end tank;
		  or
        accept stop;
        exit;
      end select;
    end loop;
  end PumpO;
  
  end pump;