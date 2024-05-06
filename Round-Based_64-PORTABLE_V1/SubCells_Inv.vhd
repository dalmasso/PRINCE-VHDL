------------------------------------------------------------------------
-- Engineer:	Dalmasso Loic
-- Create Date:	12/05/2018
-- Module Name:	SubCells_Inv - Behavioral
-- Description:
--		SBOX_Inv of PRINCE encryption
--		Input data - SubCells_Inv_in : nibble of plaintext on 4bits
--		Output data - SubCells_Inv_out : substituted data on 4bits
------------------------------------------------------------------------

--  LUTs

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY SubCells_Inv is

PORT( SubCells_Inv_in  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	  SubCells_Inv_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);

-- No optimization		
attribute dont_touch : string;
attribute dont_touch of SubCells_Inv : entity is "true";

END SubCells_Inv;

ARCHITECTURE Behavioral of SubCells_Inv is

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

with SubCells_Inv_in select

	SubCells_Inv_out <= X"B" when X"0",
						X"7" when X"1",
						X"3" when X"2",
						X"2" when X"3",
						X"F" when X"4",
						X"D" when X"5",
						X"8" when X"6",
						X"9" when X"7",
						X"A" when X"8",
						X"6" when X"9",
						X"4" when X"A",
						X"0" when X"B",
						X"5" when X"C",
						X"E" when X"D",
						X"C" when X"E",
						X"1" when X"F",

					(OTHERS =>'X') when OTHERS;

end Behavioral;