------------------------------------------------------------------------
-- Engineer:	Dalmasso Loic
-- Create Date:	12/05/2018
-- Module Name:	Round - Behavioral
-- Description:
--		Implement 1 to 10 rounds of PRINCE encryption algorithm
--		Input data - Plaintext : 64 bits of plaintext
-- 		Input data - RoundKey  : 64 bits of round key
-- 		Input data - RoundConst : 64 bits of round constant
--      Output data - Ciphertext : 64 bits of ciphertext
------------------------------------------------------------------------

--  LUT

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Round is

PORT( SelectType : IN STD_LOGIC_VECTOR(1 downto 0);
	  Plaintext  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  Key1	 	 : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  RoundConst : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  Ciphertext : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

-- No optimization  
attribute dont_touch : string;
attribute dont_touch of Round : entity is "true";

END Round;

ARCHITECTURE Behavioral of Round is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------
COMPONENT SubCells is

PORT( SubCells_in  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	  SubCells_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);

END COMPONENT;


COMPONENT SubCells_Inv is

PORT( SubCells_Inv_in  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	  SubCells_Inv_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);

END COMPONENT;


COMPONENT M_pLayer is

PORT( M_pLayer_Input  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  M_pLayer_Output : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

END COMPONENT;


COMPONENT ShiftRow is

PORT( ShiftRow_in  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  ShiftRow_out : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

END COMPONENT;


COMPONENT ShiftRow_Inv is

PORT( ShiftRow_Inv_in  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  ShiftRow_Inv_out : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

END COMPONENT;


------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
signal SubCells_output  : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');
signal ShiftRow_Inv_in  : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');
signal ShiftRow_Inv_out : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');
signal M_pLayer_in  	: STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');
signal M_pLayer_out 	: STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');
signal ShiftRow_out  	: STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');
signal Round_1_to_5_out : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');
signal Round_6_to_10_out: STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');

-- No optimization  
attribute dont_touch of SubCells_output  : signal is "true";
attribute dont_touch of ShiftRow_Inv_in  : signal is "true";
attribute dont_touch of ShiftRow_Inv_out : signal is "true";
attribute dont_touch of M_pLayer_in   	 : signal is "true";
attribute dont_touch of M_pLayer_out   	 : signal is "true";
attribute dont_touch of ShiftRow_out   	 : signal is "true";
attribute dont_touch of Round_1_to_5_out : signal is "true";
attribute dont_touch of Round_6_to_10_out: signal is "true";
------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin


-----------------------------------
-- Round 1 to 5 operations input --
-----------------------------------
SBOXS: for i in 15 downto 0 generate
	SBOX : SubCells port map (Plaintext((4*i)+3 downto (4*i)), SubCells_output((4*i)+3 downto (4*i)));
end generate;

------------------------------------
-- Round 6 to 10 operations input --
------------------------------------
ShiftRow_Inv_in <= Plaintext XOR RoundConst XOR Key1;
SHIFT_INV : ShiftRow_Inv port map(ShiftRow_Inv_in, ShiftRow_Inv_out);


--------------------------
-- M' Matrix operations --
--------------------------
M_pLayer_in <= SubCells_output when SelectType = "00" or SelectType = "01" else
			   ShiftRow_Inv_out;
M_PrimeLayer : M_pLayer port map(M_pLayer_in, M_pLayer_out);


------------------------------------
-- Round 1 to 5 operations output --
------------------------------------
SHIFT : ShiftRow port map(M_pLayer_out, ShiftRow_out);
Round_1_to_5_out <= ShiftRow_out XOR RoundConst XOR Key1;


-------------------------------------
-- Round 6 to 10 operations output --
-------------------------------------
SBOXS_INV: for i in 15 downto 0 generate
	SBOX_INV : SubCells_Inv port map (M_pLayer_out((4*i)+3 downto (4*i)), Round_6_to_10_out((4*i)+3 downto (4*i)));
end generate;


---------------------------
-- Control type of round --
---------------------------
Ciphertext <= Round_1_to_5_out when SelectType = "00" else
			  Round_6_to_10_out;


end Behavioral;