with Ada.Real_Time;
use Ada.Real_Time;

package pump is
  task type PumpO is 
    entry start;
    entry tank(vol : in out Integer;EndTank : in out Time);
    entry getCapacity(cap : out Integer);
    entry stop;
  end ;
end pump;