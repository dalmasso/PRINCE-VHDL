------------------------------------------------------------------------
-- Engineer:	Dalmasso Loic
-- Create Date:	12/05/2018
-- Module Name:	Round 6 to 10 - Behavioral
-- Description:
--		Implement 6 to 10 rounds of PRINCE encryption algorithm
--		Input data - Plaintext : 64 bits of plaintext
-- 		Input data - RoundKey  : 64 bits of round key
-- 		Input data - RoundConst : 64 bits of round constant
--      Output data - Ciphertext : 64 bits of ciphertext
------------------------------------------------------------------------

--  LUT

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Round_6_to_10 is

PORT( Plaintext  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  Key1	 	 : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  RoundConst : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  Ciphertext : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

-- No optimization  
attribute dont_touch : string;
attribute dont_touch of Round_6_to_10 : entity is "true";

END Round_6_to_10;

ARCHITECTURE Behavioral of Round_6_to_10 is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------
COMPONENT M_Layer_Inv is

PORT( M_Layer_Inv_in  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  M_Layer_Inv_out : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
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
signal Add_Key_output     : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');	-- XOR Key result
signal Add_RC_output      : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');	-- XOR RC result
signal M_Layer_Inv_output : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');	-- MLayer Inv result


-- No optimization  
attribute dont_touch of Add_Key_output     : signal is "true";
attribute dont_touch of Add_RC_output      : signal is "true";
attribute dont_touch of M_Layer_Inv_output : signal is "true";
------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

-- LUT
-----------------
-- AddRoundKey --
-----------------
Add_Key_output <= Plaintext XOR Key1;


-- LUT
----------------------
-- AddRoundConstant --
----------------------
Add_RC_output <= Add_Key_output XOR RoundConst;


-- LUT
----------------
-- MLayer_Inv --
----------------
MLayer_Inv : M_Layer_Inv port map (Add_RC_output, M_Layer_Inv_output);


-- LUT
------------------------------
-- 16 SBOXes Inv generation --
------------------------------
SBOXS_INV: for i in 15 downto 0 generate
	SBOX_Inv : SubCells_Inv port map (M_Layer_Inv_output((4*i)+3 downto (4*i)), Ciphertext((4*i)+3 downto (4*i)));
end generate;

end Behavioral;