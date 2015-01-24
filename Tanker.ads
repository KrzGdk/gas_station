with pump;
use pump;

package Tanker is
  task type tanker is 
    entry start(p : in out PumpO);
    --entry stop;
  end ;
end Tanker;