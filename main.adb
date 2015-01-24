with Ada.Text_IO, CarPkg, pump,Tanker;
use Ada.Text_IO, CarPkg, pump,Tanker;

procedure Main is

  CAR_NUM : constant Integer := 10;
  fuelPump : aliased  PumpO;
  maxCapacity : Integer := 100000;
  currentCapacity : Integer := 100000;
  cars : array (1..CAR_NUM) of Car;
  toTank : Integer := 200;
begin
fuelPump.start;
  for i in Integer range 1..CAR_NUM loop
    cars(i).start(i,fuelPump);
  end loop;

  --fuelPump.tank(toTank);
  --fuelPump.tank(toTank);
  --fuelPump.tank(toTank);
  --put_line(toTank'Img);
  --fuelPump.getCapacity(currentCapacity);
  --put_line(currentCapacity'Img);
  --fuelPump.stop;

  for i in Integer range 1..CAR_NUM loop
    cars(i).stop;
  end loop;
  fuelPump.stop;
end Main;
