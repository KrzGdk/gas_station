with Ada.Real_Time,GasStation;
use Ada.Real_Time,GasStation;

package Days is
  task type Day is 
    entry start(gasS : in out Gas_Station);
	entry stop;
  end ;
end Days;