with Ada.Text_IO, Ada.Numerics.Discrete_Random, pump;
use Ada.Text_IO,pump;

package body CarPkg is
  task body Car is
  type Start_Time_Range is range 0..10;
  type Fuel_Range is range 0..30;
  type Gas_Tank_Range is range 45..80;
  package Rand_Int_Time is new Ada.Numerics.Discrete_Random(Start_Time_Range);
  timeSeed : Rand_Int_Time.Generator;
  package Rand_Int_Fuel is new Ada.Numerics.Discrete_Random(Fuel_Range);
  fuelSeed : Rand_Int_Fuel.Generator;
  package Rand_Int_Gas_Tank is new Ada.Numerics.Discrete_Random(Gas_Tank_Range);
  gasTankSeed : Rand_Int_Gas_Tank.Generator;
  startTime : Start_Time_Range;
  fuel : Fuel_Range;
  fuelInt : Integer := Integer'Value(fuel'Img);
  gasTankCapacity : Gas_Tank_Range;
  carId : Integer := 0;
  type Pump_ptr is access all PumpO;
  pp : Pump_ptr;
  begin
    accept start(id : Integer;p : in out PumpO) do
      carId := id;
	  put_line("car" & carId'Img & " is trying to tank");
	 -- pp :=  p'Access;
    end start;
 --p.tank(fuelInt);
    Rand_Int_Time.Reset(timeSeed);
    startTime := Rand_Int_Time.Random(timeSeed);
    Rand_Int_Fuel.Reset(fuelSeed);
    fuel := Rand_Int_Fuel.Random(fuelSeed);
    Rand_Int_Gas_Tank.Reset(gasTankSeed);
    gasTankCapacity := Rand_Int_Gas_Tank.Random(gasTankSeed);
    put_line(carId'Img & ". car will start at" & startTime'Img & "s and has" & fuel'Img & "l of fuel, max fuel:" & gasTankCapacity'Img & "l");
  
    delay Duration(startTime);
    put_line("car" & carId'Img & " started");
	delay Duration(3);
	put_line("Car" & carId'Img & " arrived at Gas Stations");
	
    loop
      select
        accept stop;
        put_line("car" & carId'Img & " stopped");
        exit;
      end select;
    end loop;
  end Car;

end CarPkg;