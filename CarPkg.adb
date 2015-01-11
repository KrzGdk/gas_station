with Ada.Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO;

package body CarPkg is
  task body Car is
  type Start_Time_Range is range 0..10;
  package Rand_Int is new Ada.Numerics.Discrete_Random(Start_Time_Range);
  seed : Rand_Int.Generator;
  startTime : Start_Time_Range;
  carId : Integer := 0;

  begin
    accept start(id : Integer) do
      Rand_Int.Reset(seed);
      startTime := Rand_Int.Random(seed);
      put_line(id'Img & ". car will start at" & startTime'Img & "s");
      carId := id;
    end start;
    delay Duration(startTime);
    put_line("car" & carId'Img & " started");
    loop
      select
        accept stop;
        put_line("car" & carId'Img & " stopped");
        exit;
      end select;
    end loop;
  end Car;

end CarPkg;