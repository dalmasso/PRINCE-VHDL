------------------------------------------------------------------------
-- Engineer:	Dalmasso Loic
-- Create Date:	12/05/2018
-- Module Name:	RoundConstant - Behavioral
-- Description:
--	  	Generate round constant of PRINCE encryption
--      Input data - RoundConst_in : 64bits of RoundConstant
--      Output data - RoundConst_out : 64bits of RoundConstant updated
------------------------------------------------------------------------

--  LUT

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY RoundConstant is

PORT( RoundConst_in  : IN INTEGER;
	  RoundConst_out : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

-- No optimization  
attribute dont_touch : string;
attribute dont_touch of RoundConstant : entity is "true";

END RoundConstant;

ARCHITECTURE Behavioral of RoundConstant is

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

with RoundConst_in select

	RoundConst_out <= X"13198A2E03707344" when 0,
					  X"A4093822299F31D0" when 1,
					  X"082EFA98EC4E6C89" when 2,
					  X"452821E638D01377" when 3,
					  X"BE5466CF34E90C6C" when 4,
					  X"7EF84F78FD955CB1" when 5,
					  X"85840851F1AC43AA" when 6,
					  X"C882D32F25323C54" when 7,
					  X"64A51195E0E3610D" when 8,
					  X"D3B5A399CA0C2399" when 9,

					(OTHERS =>'0') when OTHERS;

end Behavioral;