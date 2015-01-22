with Ada.Text_IO, CarPkg;
use Ada.Text_IO, CarPkg;

procedure Main is

  CAR_NUM : constant Integer := 10;

  task type Pump is 
    entry start;
    entry tank(vol : in out Integer);
    entry getCapacity(cap : out Integer);
    entry stop;
  end Pump;

  task body Pump is
    capacity : Integer := 500;
    isBusy : Boolean  := False;
  begin
    accept start do
      put_line("dupa");
    end start;
    loop
      select
        when capacity > 0 and isBusy = False =>
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
  end Pump;

  fuelPump : Pump;
  maxCapacity : Integer := 100000;
  currentCapacity : Integer := 100000;
  cars : array (1..CAR_NUM) of Car;
  toTank : Integer := 200;
begin
  for i in Integer range 1..CAR_NUM loop
    cars(i).start(i);
  end loop;
  fuelPump.start;

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
