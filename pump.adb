  with Ada.Text_IO, Ada.Numerics.Discrete_Random;
  use Ada.Text_IO;
  
  
  package body pump is
  
  task body PumpO is
    capacity : Integer := 500;
    isBusy : Boolean  := False;
  begin
    accept start do
      put_line("dupa");
    end start;
    loop
      select
        --when capacity > 0 and isBusy = False =>
          accept tank(vol : in out Integer) do
		    isBusy := True;
            put_line("tank");
            delay Duration(2.0);
            if capacity < vol then
              vol := capacity;
              capacity := 0;
            else
              capacity := capacity - vol;
            end if;
			isBusy := False;
          end tank;
      or
        accept getCapacity(cap : out Integer) do
          cap := capacity;
        end getCapacity;
      or
        accept stop;
        exit;
		
      end select;
    end loop;
  end PumpO;
  
  end pump;