------------------------------------------------------------------------
-- Engineer:	Dalmasso Loic
-- Create Date:	12/05/2018
-- Module Name:	M_Layer - Behavioral
-- Description:
--		M_Layer of PRINCE encryption
--		Input data - M_Layer_in : nibble of plaintext on 64bits
--		Output data - ShiftRow_out : substituted data on 64bits
------------------------------------------------------------------------

--  LUTs

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ShiftRow is

PORT( ShiftRow_in  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  ShiftRow_out : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

-- No optimization		
attribute dont_touch : string;
attribute dont_touch of ShiftRow : entity is "true";

END ShiftRow;

ARCHITECTURE Behavioral of ShiftRow is

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

-- Input bits : 63 ... 0
-- Input Nibbs:  0 1  2  3 4 5  6 7 8  9 10 11 12 13 14 15
-- Output Nibbs: 0 5 10 15 4 9 14 3 8 13  2  7 12  1  6 11
ShiftRow_out(63 downto 60) <= ShiftRow_in(63 downto 60);
ShiftRow_out(59 downto 56) <= ShiftRow_in(43 downto 40);
ShiftRow_out(55 downto 52) <= ShiftRow_in(23 downto 20);
ShiftRow_out(51 downto 48) <= ShiftRow_in(3  downto 0);
ShiftRow_out(47 downto 44) <= ShiftRow_in(47 downto 44);
ShiftRow_out(43 downto 40) <= ShiftRow_in(27 downto 24);
ShiftRow_out(39 downto 36) <= ShiftRow_in(7  downto 4);
ShiftRow_out(35 downto 32) <= ShiftRow_in(51 downto 48);
ShiftRow_out(31 downto 28) <= ShiftRow_in(31 downto 28);
ShiftRow_out(27 downto 24) <= ShiftRow_in(11 downto 8);
ShiftRow_out(23 downto 20) <= ShiftRow_in(55 downto 52);
ShiftRow_out(19 downto 16) <= ShiftRow_in(35 downto 32);
ShiftRow_out(15 downto 12) <= ShiftRow_in(15 downto 12);
ShiftRow_out(11 downto 8)  <= ShiftRow_in(59 downto 56);
ShiftRow_out(7 downto 4)   <= ShiftRow_in(39 downto 36);
ShiftRow_out(3 downto 0)   <= ShiftRow_in(19 downto 16);

end Behavioral;