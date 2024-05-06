------------------------------------------------------------------------
-- Engineer:	Dalmasso Loic
-- Create Date:	12/05/2018
-- Module Name:	SubCells - Behavioral
-- Description:
--		SBOX of PRINCE encryption
--		Input data - SubCells_in : nibble of plaintext on 4bits
--		Output data - SubCells_out : substituted data on 4bits
------------------------------------------------------------------------

--  LUTs

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY SubCells is

PORT( SubCells_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	  SubCells_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);

-- No optimization		
attribute dont_touch : string;
attribute dont_touch of SubCells : entity is "true";

END SubCells;

ARCHITECTURE Behavioral of SubCells is

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

with SubCells_in select

	SubCells_out <= X"B" when X"0",
					X"F" when X"1",
					X"3" when X"2",
					X"2" when X"3",
					X"A" when X"4",
					X"C" when X"5",
					X"9" when X"6",
					X"1" when X"7",
					X"6" when X"8",
					X"7" when X"9",
					X"8" when X"A",
					X"0" when X"B",
					X"E" when X"C",
					X"5" when X"D",
					X"D" when X"E",
					X"4" when X"F",

					(OTHERS =>'X') when OTHERS;

end Behavioral;