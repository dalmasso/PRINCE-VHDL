------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 12/05/2018
-- Module Name: KeySchedule - Behavioral
-- Description:
--      Create 3 keys
--      Input data - Keystate : 128bits of Cipherkey
--      Output data - NewKey : 128bits of Keystate
--      Output data - RoundKey : 32bits of Roundkey
------------------------------------------------------------------------

--  LUT

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY KeySchedule is

PORT( CipherKey : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
	  Key0		: OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
	  Key0_bis	: OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
      Key1		: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    );

-- No optimization  
attribute dont_touch : string;
attribute dont_touch of KeySchedule : entity is "true";

END KeySchedule;

ARCHITECTURE Behavioral of KeySchedule is

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

Key0 	 <= CipherKey(127 downto 64);
Key0_bis <= CipherKey(64) & CipherKey(127 downto 66) & (CipherKey(65) XOR CipherKey(127) );
Key1	 <= CipherKey(63 downto 0);

end Behavioral;