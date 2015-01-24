  with Ada.Text_IO, Ada.Numerics.Discrete_Random, pump;
  use Ada.Text_IO,pump;
  
package body Tanker is
task body tankerO is
	Capacity : Integer :=0;
	Fuel : Integer := 300;
	begin
	loop
	select
			accept FillTanks(c : in out Integer; MaxC : in Integer) do
				put_line("Fuel ran out, waiting for tanker");
				delay(2.0);
				put_line("tanker arrived");
				if(MaxC <= c + Fuel) then
					c := MaxC;
				else 
					c := c + Fuel;
				end if;
				
			end FillTanks;
		or
			accept stop;
			exit;
		end select;
	end loop;
	end tankerO;
end Tanker;