  with Ada.Text_IO, Ada.Numerics.Discrete_Random, Tanker;
  use Ada.Text_IO, Tanker;
  
  
  package body pump is
  
  task body PumpO is
    tanker  : tankerO; 
    capacity : Integer := 100;
	MaxCapacity : Integer :=capacity;
    isBusy : Boolean  := False;
	CashRegister : Integer :=0; --Piwowarczyk mówił o takich bajerach jak opróżnianie kasy każdego dnia, robimy to?
    income : Integer := 0;
	FuelPrice : Integer := 5;
	FuelPrice2 : Integer := 3;
  begin
    accept start do
	tanker.start;
      put_line("dupa");
    end start;
    loop
      select
        when capacity > 0 and isBusy = False =>
          accept tank(vol : in out Integer) do
		    isBusy := True;
            delay Duration(2.0);
            if capacity < vol then
              vol := capacity;
			  CashRegister := CashRegister + vol* FuelPrice;
			  income := income + vol* FuelPrice;
              capacity := 0;
			  tanker.FillTanks(capacity,MaxCapacity);
            else
              capacity := capacity - vol;
			  CashRegister := CashRegister + vol* FuelPrice;
			  income := income + vol* FuelPrice;
            end if;
			isBusy := False;
          end tank;
      or 
        accept getCapacity(cap : out Integer) do
          cap := capacity;
        end getCapacity;
      or  
		when capacity = 0 and isBusy = False =>
			accept FillTanks(fuel : in out Integer) do --Robimy cysterne jako osobnego taska? czy stacja sama się będzie uzupełniała?
				put_line("Tanker arrived");
				capacity := fuel;
				income := income - fuel * FuelPrice2;	
			
			end FillTanks;
	  or
        accept stop;
		tanker.stop;
		   put_line("cash = " & CashRegister 'Img & " income = "  & income'Img);
        exit;
		
      end select;
    end loop;
  end PumpO;
  
  end pump;