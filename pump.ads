package pump is
  task type PumpO is 
    entry start;
    entry tank(vol : in out Integer);
	entry FillTanks(fuel : in out Integer); --uzupełnianie paliwa w zbiornikach
    entry getCapacity(cap : out Integer);
    entry stop;
  end ;
end pump;