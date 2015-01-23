with pump;
use pump;

package CarPkg is
  task type Car is 
    entry start(id : Integer;p : in out PumpO);
    entry stop;
  end;
end CarPkg;