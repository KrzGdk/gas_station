with Ada.Text_IO, CarPkg, pump,Tanker,GasStation;
use Ada.Text_IO, CarPkg, pump,Tanker,GasStation;
package body Days is
task body Day is
DayTime : Integer :=25;
DayNumber : Integer :=3;
begin
accept start(gasS : in out Gas_Station) do
	for i in Integer range 1..DayNumber loop
		for i in Integer range 1..DayTime loop
			delay(1.0);
		end loop;
		gasS.EndOfDay;
	end loop;
	end start;
	loop 
		select 
		accept stop;
			exit;
		end select;
	end loop;
end Day;
end Days;