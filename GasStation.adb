with Ada.Text_IO, CarPkg, pump,Tanker,GasStation;
use Ada.Text_IO, CarPkg, pump,Tanker,GasStation;
package body GasStation is
task body Gas_Station is

   type Stats is
    record
       CashRegister : Integer;
	   income : Integer;
	   FuelSold : Integer;
	   FuelBought : Integer;
	   longestQueue : Integer;
	   notServisedCars : Integer;
	   loss : Integer;
    end record;
	
	
	
	tanker  : tankerO; 				   	--cysterna
	capacity : Integer := 10000; 		   	--ilość paliwa w zbiornikach
	MaxCapacity : Integer :=capacity;  	--pojemność zbiorników
	CashRegister : Integer :=0;		   	--pieniądze w kasie
	TotalCashRegister : Integer :=0;	--wszystkie pieniądze z kasy
    income : Integer := 0;    		   	-- zysk dzienny
	totalIncome : Integer :=0;			--zysk całkowity
	MaxDay	: Integer :=5;				--maksymalna ilość dni
	notServisedCars : Integer:=0;			--nieobsłużone samochody 
	loss : Integer:=0;						--straty poniesione z nieobsłużenia samochodów
	daysCount : Integer :=1;			--licznik dni
	MaxQueue : Integer :=5;				--najdłuższa dopuszczalna kolejka
	longestQueue : Integer :=0;			--najdłuższa zarejestrowana kolejka
	DistributorsNumber : Integer :=3;	--liczba dystrybutorów
	Distributors : array (1..DistributorsNumber) of aliased Distributor;
	AllStats : array (1..MaxDay) of Stats; --codzienne statystyki
	FuelPrice : Integer := 5; 		   	--cena sprzedaży paliwa
	FuelPrice2 : Integer := 3; 		   	--cena zakupu paliwa
	lowestQueue : Integer:=MaxQueue+1;	--najmniejsza kolejka do dystrybutora
	index : Integer:=0;					--index najmniejszej kolejki
	index2 : Integer:=0;					--index najmniejszej kolejki
begin
	accept selectDistributor(vol : in out Integer; selectedPump : out Distributor_ptr) do
		for i in Integer range 1..DistributorsNumber loop
			if(Distributors(i).queue < lowestQueue) then
				lowestQueue := Distributors(i).queue;
				index := i;
			end if;
			if(Distributors(i).queue > longestQueue) then
				longestQueue := Distributors(i).queue; 
			end if;
			--put_line("lowestQueue: " & lowestQueue'Img & " queue: " & Distributors(i).queue'Img & " i=" & i'Img);
		end loop;
		lowestQueue :=99;
		put_line("chosen distributor: " & index'Img & " queue: " & Distributors(index).queue'Img);
		Distributors(index).queue := Distributors(index).queue + 1;
		if(lowestQueue = MaxQueue) then
			if capacity < vol then
				loss := loss + capacity*(FuelPrice-FuelPrice2);
				notServisedCars := notServisedCars+1;
			else
				loss := loss + vol*(FuelPrice-FuelPrice2);
				notServisedCars := notServisedCars+1;
			end if;
		else
			selectedPump := Distributors(index)'Unrestricted_Access;
			if capacity < vol then
			  vol := capacity;
			  CashRegister := CashRegister + vol* FuelPrice;
			  income := income + vol* FuelPrice;
			  capacity := 0;
			  tanker.FillTanks(capacity,MaxCapacity);
			  delay(3.0);
			  income := income - capacity * FuelPrice2;
			else
			  capacity := capacity - vol;
			  CashRegister := CashRegister + vol* FuelPrice;
			  income := income + vol* FuelPrice;
			end if;
		end if;
	end selectDistributor;
	loop
		select
			accept selectDistributor(vol : in out Integer;selectedPump : out Distributor_ptr) do
				for i in Integer range 1..DistributorsNumber loop
					if(Distributors(i).queue < lowestQueue) then
						lowestQueue := Distributors(i).queue;
						index := i;
					end if;
					if(Distributors(i).queue > longestQueue) then
						longestQueue := Distributors(i).queue; 
					end if;
					--put_line("lowestQueue: " & lowestQueue'Img & " queue: " & Distributors(i).queue'Img & " i=" & i'Img);
				end loop;
				lowestQueue :=99;
				put_line("chosen distributor: " & index'Img & " queue: " & Distributors(index).queue'Img);
				Distributors(index).queue := Distributors(index).queue + 1;
				if(lowestQueue = MaxQueue) then
					if capacity < vol then
						loss := loss + capacity*(FuelPrice-FuelPrice2);
						notServisedCars := notServisedCars+1;
					else
						loss := loss + vol*(FuelPrice-FuelPrice2);
						notServisedCars := notServisedCars+1;
					end if;
				else
					selectedPump := Distributors(index)'Unrestricted_Access;
					if capacity < vol then
					  vol := capacity;
					  CashRegister := CashRegister + vol* FuelPrice;
					  income := income + vol* FuelPrice;
					  capacity := 0;
					  tanker.FillTanks(capacity,MaxCapacity);
					  delay(3.0);
					  income := income - capacity * FuelPrice2;
					else
					  capacity := capacity - vol;
					  CashRegister := CashRegister + vol* FuelPrice;
					  income := income + vol* FuelPrice;
					end if;
				end if;
			end selectDistributor;
			or
			accept EndOfDay do
			put_line("station starts");
				--totalIncome := totalIncome + income;
				--TotalCashRegister := TotalCashRegister + CashRegister;
				--daysCount := daysCount+1;
				--income := 0;
				--cashRegister :=0;
			end EndOfDay;
			or
			accept stop;
			tanker.stop;
			for i in Integer range 1..DistributorsNumber loop
				Distributors(i).pump.stop;
			end loop;
			exit;
		end select;
	end loop;
end Gas_Station;
end GasStation;