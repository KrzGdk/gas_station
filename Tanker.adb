  with Ada.Text_IO, Ada.Numerics.Discrete_Random, pump;
  use Ada.Text_IO,pump;
  
package body Tanker is
task body tanker is
	Capacity : Integer :=0;
	Fuel : Integer := 300;
	begin
		accept start(p : in out PumpO) do
			loop
				 p.getCapacity(Capacity);
				 if(Capacity = 0) then
					delay(2.0); --czas dojazdu na stację
					p.FillTanks(Fuel);					
					end if;
				delay(1.0);
			end loop;
		end start;
	end tanker;
end Tanker;