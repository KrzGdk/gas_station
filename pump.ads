with Ada.Real_Time;
use Ada.Real_Time;

package pump is
  task type PumpO is 
    entry tank(queue : in out Integer;EndTank : out Time);
    entry stop;
  end ;
end pump;