--STATYSTYKI:
--max kolejka
--dzienne wpływy
--liczba samochodów nie obsłużonych
--kilka pomp
--opróżnianie kasy


with Ada.Text_IO, CarPkg, pump,Tanker,GasStation;
use Ada.Text_IO, CarPkg, pump,Tanker,GasStation;

procedure Main is

  CAR_NUM : constant Integer := 10;
  gasStation : aliased Gas_Station;
  cars : array (1..CAR_NUM) of Car;
begin
  for i in Integer range 1..CAR_NUM loop
    cars(i).start(i,gasStation);
  end loop;
  for i in Integer range 1..CAR_NUM loop
    cars(i).stop;
  end loop;
  gasStation.stop;
end Main;
