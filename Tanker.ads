with pump;
use pump;

package Tanker is
  task type tankerO is 
	entry FillTanks(c : in out Integer; MaxC : in Integer);
    entry stop;
  end ;
end Tanker;