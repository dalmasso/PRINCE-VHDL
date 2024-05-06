------------------------------------------------------------------------
-- Engineer:	Dalmasso Loic
-- Create Date:	12/05/2018
-- Module Name:	Round 1 to 5 - Behavioral
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

ENTITY Round_1_to_5 is

PORT( Plaintext  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  Key1	 	 : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  RoundConst : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  Ciphertext : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

-- No optimization  
attribute dont_touch : string;
attribute dont_touch of Round_1_to_5 : entity is "true";

END Round_1_to_5;

ARCHITECTURE Behavioral of Round_1_to_5 is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------
COMPONENT SubCells is

PORT( SubCells_in  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	  SubCells_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);

END COMPONENT;


COMPONENT M_Layer is

PORT( M_Layer_in  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  M_Layer_out : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

END COMPONENT;

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
signal SubCells_output : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');	-- SBOX result
signal M_Layer_output  : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');	-- MLayer result
signal Add_RC_output   : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');	-- XOR RC result

-- No optimization  
attribute dont_touch of SubCells_output : signal is "true";
attribute dont_touch of M_Layer_output  : signal is "true";
attribute dont_touch of Add_RC_output   : signal is "true";
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
-- MLayer --
------------
MLayer : M_Layer port map (SubCells_output, M_Layer_output);


-- LUT
----------------------
-- AddRoundConstant --
----------------------
Add_RC_output <= M_Layer_output XOR RoundConst;


-- LUT
-----------------
-- AddRoundKey --
-----------------
Ciphertext <= Add_RC_output XOR Key1;

end Behavioral;