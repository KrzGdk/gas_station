with Ada.Real_Time;
use Ada.Real_Time;

package  GasStation is
task type Gas_Station is
	entry tank(vol : in out Integer;EndTank : out Time);
	entry EndOfDay;
	entry stop;
end Gas_Station;
end GasStation;

