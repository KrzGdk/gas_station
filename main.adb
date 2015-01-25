--STATYSTYKI:
--dzienne wpływy
--opróżnianie kasy


with Ada.Text_IO, CarPkg, pump,Tanker,GasStation,Days,Ada.Integer_Text_io;
use Ada.Text_IO, CarPkg, pump,Tanker,GasStation,Days,Ada.Integer_Text_io;

procedure Main is
  days : Day;
  CAR_NUM :  Integer := 20;
  gasStation : aliased Gas_Station;
   type cars is array(Integer range <>) of Car;
begin
	put_line("Number of cars: ");
	get(CAR_NUM);
	declare
       cars : array (1..CAR_NUM) of Car;
   begin
   
  for i in Integer range 1..CAR_NUM loop
    cars(i).start(i,gasStation);
  end loop;
  days.start(gasStation);
  for i in Integer range 1..CAR_NUM loop
    cars(i).stop;
  end loop;
  days.stop;
  gasStation.stop;
  end;
end Main;
