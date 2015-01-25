with Ada.Real_Time, pump;
use Ada.Real_Time, pump;

package  GasStation is
type Pump_ptr is access all PumpO;
type Distributor is
    record
        pump : aliased PumpO;
        queue : Integer :=0;                --kolejka do dystrybutora
    end record;
type Distributor_ptr is access all Distributor;
task type Gas_Station is
    entry selectDistributor(vol : in out Integer; selectedPump : out Distributor_ptr);
	entry EndOfDay;
	entry stop;
end Gas_Station;
end GasStation;

