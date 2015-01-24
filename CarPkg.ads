with pump;
use pump;

package CarPkg is
  task type Car is 
    entry start(id : Integer;p : aliased  in out PumpO);
    entry stop;
  end;
end CarPkg;