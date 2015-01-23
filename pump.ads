package pump is
  task type PumpO is 
    entry start;
    entry tank(vol : in out Integer);
    entry getCapacity(cap : out Integer);
    entry stop;
  end ;
end pump;