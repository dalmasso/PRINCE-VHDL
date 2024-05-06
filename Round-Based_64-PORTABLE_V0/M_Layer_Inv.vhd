------------------------------------------------------------------------
-- Engineer:	Dalmasso Loic
-- Create Date:	12/05/2018
-- Module Name:	M_Layer - Behavioral
-- Description:
--		M_Layer of PRINCE encryption
--		Input data - M_Layer_in : nibble of plaintext on 64bits
--		Output data - M_Layer_out : substituted data on 64bits
------------------------------------------------------------------------

--  LUTs

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY M_Layer_Inv is

PORT( M_Layer_Inv_in  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  M_Layer_Inv_out : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

-- No optimization		
attribute dont_touch : string;
attribute dont_touch of M_Layer_Inv : entity is "true";

END M_Layer_Inv;

ARCHITECTURE Behavioral of M_Layer_Inv is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------
COMPONENT M_pLayer is

PORT( M_pLayer_Input  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  M_pLayer_Output : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

END COMPONENT;

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
signal M_Layer_perm : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0'); -- M' layer output

-- No optimization  
attribute dont_touch of M_Layer_perm : signal is "true";
------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

-- Input bits : 63 ... 0
-- Input Nibbs:  0 5 10 15 4 9 14 3 8 13  2  7 12  1  6 11
-- Output Nibbs: 0 1  2  3 4 5  6 7 8  9 10 11 12 13 14 15
M_Layer_perm(63 downto 60) <= M_Layer_Inv_in(63 downto 60);
M_Layer_perm(59 downto 56) <= M_Layer_Inv_in(11 downto 8);
M_Layer_perm(55 downto 52) <= M_Layer_Inv_in(23 downto 20);
M_Layer_perm(51 downto 48) <= M_Layer_Inv_in(35 downto 32);
M_Layer_perm(47 downto 44) <= M_Layer_Inv_in(47 downto 44);
M_Layer_perm(43 downto 40) <= M_Layer_Inv_in(59 downto 56);
M_Layer_perm(39 downto 36) <= M_Layer_Inv_in(7 downto 4);
M_Layer_perm(35 downto 32) <= M_Layer_Inv_in(19 downto 16);
M_Layer_perm(31 downto 28) <= M_Layer_Inv_in(31 downto 28);
M_Layer_perm(27 downto 24) <= M_Layer_Inv_in(43 downto 40);
M_Layer_perm(23 downto 20) <= M_Layer_Inv_in(55 downto 52);
M_Layer_perm(19 downto 16) <= M_Layer_Inv_in(3 downto 0);
M_Layer_perm(15 downto 12) <= M_Layer_Inv_in(15 downto 12);
M_Layer_perm(11 downto 8)  <= M_Layer_Inv_in(27 downto 24);
M_Layer_perm(7 downto 4)   <= M_Layer_Inv_in(39 downto 36);
M_Layer_perm(3 downto 0)   <= M_Layer_Inv_in(51 downto 48);

-- Apply M' layer
M_PrimeLayer : M_pLayer port map(M_Layer_perm, M_Layer_Inv_out);


end Behavioral;