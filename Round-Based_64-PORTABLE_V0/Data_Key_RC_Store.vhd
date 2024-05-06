------------------------------------------------------------------------
-- Engineer:    Dalmasso Loic
-- Create Date: 09/03/2018
-- Module Name: Data_Key_RC_Store - Behavioral
-- Description:
--      Save all data / key / round counter
--      Input data - Clk : clock for KeySchedule
--      Input data - Reset : reset block
--      Input data - Plaintext : 64bits of Plaintext
--      Input data - Data_in : 64bits of Intermediate plaintext
--      Output data - Data_out : 64bits of Intermediate plaintext
------------------------------------------------------------------------

-- LUT
--  FF

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Data_Key_RC_Store is

PORT( Clk      : IN STD_LOGIC;
      Reset    : IN STD_LOGIC;

      Plaintext: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
      Data_in  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);

      Data_out : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    );

-- No optimization 
attribute dont_touch : string;
attribute dont_touch of Data_Key_RC_Store : entity is "true";

END Data_Key_RC_Store;


ARCHITECTURE Behavioral of Data_Key_RC_Store is

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

-------------------------
-- 64-bit Data storage --
-------------------------
process(Clk)
begin

  if rising_edge(Clk) then
    
    if Reset = '0' then
      Data_out <= Plaintext;
    else
      Data_out <= Data_in;
    end if;

  end if;
end process;

end Behavioral;