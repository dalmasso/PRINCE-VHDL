------------------------------------------------------------------------
-- Engineer:	Dalmasso Loic
-- Create Date:	12/05/2018
-- Module Name:	Round Middle - Behavioral
-- Description:
--		Implement 1 to 5 rounds of PRINCE encryption algorithm
--		Input data - Plaintext : 64 bits of plaintext
-- 		Input data - RoundKey  : 64 bits of round key
-- 		Input data - RoundConst : 64 bits of round constant
--      Output data - Ciphertext : 64 bits of ciphertext
------------------------------------------------------------------------

--  LUT

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Round_Middle is

PORT( Plaintext  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  Ciphertext : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

-- No optimization  
attribute dont_touch : string;
attribute dont_touch of Round_Middle : entity is "true";

END Round_Middle;

ARCHITECTURE Behavioral of Round_Middle is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------
COMPONENT SubCells is

PORT( SubCells_in  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	  SubCells_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);

END COMPONENT;


COMPONENT M_pLayer is

PORT( M_pLayer_Input  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  M_pLayer_Output : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

END COMPONENT;


COMPONENT SubCells_Inv is

PORT( SubCells_Inv_in  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	  SubCells_Inv_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);

END COMPONENT;

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
signal SubCells_output : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');	-- SBOX result
signal M_pLayer_output : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');	-- MpLayer result

-- No optimization  
attribute dont_touch of SubCells_output : signal is "true";
attribute dont_touch of M_pLayer_output : signal is "true";
------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

-- LUT
--------------------------
-- 16 SBOXes generation --
--------------------------
SBOXS: for i in 15 downto 0 generate
	SBOX : SubCells port map (Plaintext((4*i)+3 downto (4*i)), SubCells_output((4*i)+3 downto (4*i)));
end generate;


-- LUT
------------
-- MpLayer --
------------
MpLayer : M_pLayer port map (SubCells_output, M_pLayer_output);


-- LUT
------------------------------
-- 16 SBOXes Inv generation --
------------------------------
SBOXS_INV: for i in 15 downto 0 generate
	SBOX_Inv : SubCells_Inv port map (M_pLayer_output((4*i)+3 downto (4*i)), Ciphertext((4*i)+3 downto (4*i)));
end generate;

end Behavioral;