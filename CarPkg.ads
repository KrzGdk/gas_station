with GasStation;
use GasStation;

package CarPkg is
  task type Car is 
    entry start(id : Integer;p : aliased  in out Gas_Station);
    entry stop;
  end;
end CarPkg;