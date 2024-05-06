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
COMPONENT Round_1_to_5 is

PORT( Plaintext  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  Key1	 	 : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  RoundConst : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  Ciphertext : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

END COMPONENT;


COMPONENT Round_Middle is

PORT( Plaintext  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  Ciphertext : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

END COMPONENT;


COMPONENT Round_6_to_10 is

PORT( Plaintext  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  Key1	 	 : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  RoundConst : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  Ciphertext : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

END COMPONENT;

------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
signal Input_RD_1_5  : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');
signal Input_RD_Midd : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');
signal Input_RD_6_10 : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');

signal Output_RD_1_5  : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');
signal Output_RD_Midd : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');
signal Output_RD_6_10 : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');

-- No optimization  
attribute dont_touch of Input_RD_1_5   : signal is "true";
attribute dont_touch of Input_RD_Midd  : signal is "true";
attribute dont_touch of Input_RD_6_10  : signal is "true";
attribute dont_touch of Output_RD_1_5  : signal is "true";
attribute dont_touch of Output_RD_Midd : signal is "true";
attribute dont_touch of Output_RD_6_10 : signal is "true";
------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin


---------------------------
-- Control type of round --
---------------------------
Input_RD_1_5  <= Plaintext when SelectType = "00" or SelectType = "01" else (others=>'0');
Input_RD_Midd <= Output_RD_1_5 when SelectType = "01" else (others=>'0');
Input_RD_6_10 <= Plaintext when SelectType = "10" else (others=>'0');


-- LUT
------------------
-- Round 1 to 5 --
------------------
RD_1_5 : Round_1_to_5 port map(Input_RD_1_5, Key1, RoundConst, Output_RD_1_5);

-- LUT
------------------
-- Round Middle --
------------------
RD_Midd : Round_Middle port map(Input_RD_Midd, Output_RD_Midd);

-- LUT
-------------------
-- Round 6 to 10 --
-------------------
RD_6_10 : Round_6_to_10 port map(Input_RD_6_10, Key1, RoundConst, Output_RD_6_10);

--------------------
-- Control Output --
--------------------
Ciphertext  <= Output_RD_1_5  when SelectType = "00" else
			   Output_RD_Midd when SelectType = "01" else
			   Output_RD_6_10;

end Behavioral;