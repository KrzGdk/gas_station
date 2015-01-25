with Ada.Text_IO,Ada.Integer_Text_IO,Ada.IO_Exceptions;

package body GasStationInput is

function get_car_number return Integer is
  carNumber : Integer := 0;
begin
    loop
      Ada.Text_IO.Put_Line("Enter the number of cars: (1-200)");
      begin
        Ada.Integer_Text_Io.get(carNumber);
        if carNumber < 1 or carNumber > 200 then
          raise Constraint_Error;
        end if;
        return carNumber;
      exception
        when Ada.IO_Exceptions.Data_Error | Constraint_Error  =>
          Ada.Text_IO.Put_Line("Invalid number");
          Ada.Text_IO.Skip_Line;
      end;
    end loop;
end get_car_number;

end GasStationInput;