with Ada.Text_IO, CarPkg;
use Ada.Text_IO, CarPkg;

procedure Main is
  task type Pump is 
    entry start;
    entry tank(V : Integer);
    entry getCapacity(cap : out Integer);
    entry stop;
  end Pump;

  task body Pump is
    capacity : Integer := 500;
    isBusy : Integer := 0;
  begin
    accept start do
      put_line("dupa");
    end start;
    loop
      select
        when capacity > 0 =>
          accept tank(V : Integer) do
            put_line("tank");
            capacity := capacity - V;
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

  FuelPump : Pump;
  currentCapacity : Integer := 500;
begin
  delay Duration(1.0);
  FuelPump.start;
  delay Duration(1.0);
  FuelPump.tank(200);
  delay Duration(1.0);
  FuelPump.getCapacity(currentCapacity);
  put_line(currentCapacity'Img);
  FuelPump.stop;
end Main;