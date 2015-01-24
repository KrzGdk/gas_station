with Ada.Text_IO, Ada.Numerics.Discrete_Random, GasStation, Ada.Real_Time;
use Ada.Text_IO,GasStation,Ada.Real_Time;

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
  StartTank : Time;
  elapsed : Time_Span;
  EndTank : Time;
  fuel : Fuel_Range;
  fuelInt : Integer := Integer'Value(fuel'Img);
  gasTankCapacity : Gas_Tank_Range;
  carId : Integer := 0;
  ToTank : Integer;
  type GasStation_ptr is access all Gas_Station;
  pp : GasStation_ptr;
  begin
    accept start(id : Integer;p : aliased  in out Gas_Station) do
      carId := id;
	  put_line("car" & carId'Img & " is trying to tank");
	  pp :=  p'Access;
    end start;
    Rand_Int_Time.Reset(timeSeed);
    startTime := Rand_Int_Time.Random(timeSeed);
    Rand_Int_Fuel.Reset(fuelSeed);
    fuel := Rand_Int_Fuel.Random(fuelSeed);
    Rand_Int_Gas_Tank.Reset(gasTankSeed);
    gasTankCapacity := Rand_Int_Gas_Tank.Random(gasTankSeed);
    ToTank := Integer'Value(gasTankCapacity'Img) - Integer'Value(fuel'Img); -- żeby zatankować do pełna
	
	put_line(carId'Img & ". car will start at" & startTime'Img & "s and has" & fuel'Img & "l of fuel, max fuel:" & gasTankCapacity'Img & "l");
  
    delay Duration(startTime);
    put_line("car" & carId'Img & " started");
	--put_line("Car" & carId'Img & " arrived at Gas Stations");
	StartTank := Clock;
	pp.tank(ToTank,EndTank);
	elapsed := EndTank - StartTank;-- - Duration(2.0);
	put_line("Car " & carId'Img & " has been waiting " &  To_Duration(elapsed)'Img & " minutes");
	
    loop
      select
        accept stop;
        put_line("car" & carId'Img & " stopped");
        exit;
      end select;
    end loop;
  end Car;

end CarPkg;