------------------------------------------------------------------------
-- Engineer:  Dalmasso Loic
-- Create Date: 12/05/2018
-- Module Name: PRINCE - Behavioral
-- Description:
--      Implement one round of PRINCE encryption algorithm
--      Input data - Clk : clock of PRINCE
--      Input data - Reset : reset of PRINCE
--      Input data - Plaintext : 64 bits of plaintext
--      Input data - Key1 : 128 bits of cipherkey
--      Output data - Ciphertext : 64 bits of ciphertext
--      Output data - EndOfGIFT : siganl to identify end of PRINCE algorithm
------------------------------------------------------------------------

-- LUT
-- FF

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY PRINCE is

PORT( Clk         : IN STD_LOGIC;
      Reset       : IN STD_LOGIC;
      Plaintext   : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
      CipherKey   : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      Ciphertext  : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
      EndOfPRINCE : OUT STD_LOGIC
    );

-- No optimization  
attribute dont_touch : string;
attribute dont_touch of PRINCE : entity is "true";

END PRINCE;

ARCHITECTURE Behavioral of PRINCE is

------------------------------------------------------------------------
-- Component Declarations
------------------------------------------------------------------------
COMPONENT Round is

PORT( SelectType : IN STD_LOGIC_VECTOR(1 downto 0);
      Plaintext  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
      Key1       : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
      RoundConst : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
      Ciphertext : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    );

END COMPONENT;


COMPONENT RoundConstant is

PORT( RoundConst_in  : IN INTEGER;
      RoundConst_out : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    );

END COMPONENT;


COMPONENT KeySchedule is

PORT( CipherKey : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      Key0      : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
      Key0_bis  : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
      Key1      : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    );

END COMPONENT;


COMPONENT Data_Key_RC_Store is

PORT( Clk      : IN STD_LOGIC;
      Reset    : IN STD_LOGIC;
      Plaintext: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
      Data_in  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
      Data_out : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    );

END COMPONENT;

------------------------------------------------------------------------
-- Constant Declarations
------------------------------------------------------------------------
constant RC0  : STD_LOGIC_VECTOR(63 DOWNTO 0)  := X"0000000000000000";
constant RC11 : STD_LOGIC_VECTOR(63 DOWNTO 0)  := X"C0AC29B7C97C50DD";


------------------------------------------------------------------------
-- Signal Declarations
------------------------------------------------------------------------
signal Key0      : STD_LOGIC_VECTOR(63 DOWNTO 0)  := (others => '0');
signal Key0_bis  : STD_LOGIC_VECTOR(63 DOWNTO 0)  := (others => '0');
signal Key1      : STD_LOGIC_VECTOR(63 DOWNTO 0)  := (others => '0');

signal MyPTI     : STD_LOGIC_VECTOR(63 DOWNTO 0)  := (others => '0');
signal MyCTO     : STD_LOGIC_VECTOR(63 DOWNTO 0)  := (others => '0');

signal NB_round  : INTEGER RANGE 0 TO 10 := 0;
signal RoundType : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');

signal RCstate   : STD_LOGIC_VECTOR(63 DOWNTO 0)  := (others => '0');

signal NewPlain  : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');
signal NewCipher : STD_LOGIC_VECTOR(63 DOWNTO 0) := (others => '0');


-- No optimization  
attribute dont_touch of Key0      : signal is "true";
attribute dont_touch of Key0_bis  : signal is "true";
attribute dont_touch of Key1      : signal is "true";
attribute dont_touch of MyPTI     : signal is "true";
attribute dont_touch of MyCTO     : signal is "true";
attribute dont_touch of NB_round  : signal is "true";
attribute dont_touch of RoundType : signal is "true";
attribute dont_touch of RCstate   : signal is "true";
attribute dont_touch of NewPlain  : signal is "true";
attribute dont_touch of NewCipher : signal is "true";
------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

--------------------
-- PRINCE Control --
--------------------
process(Clk, Reset)
begin

  if rising_edge(Clk) then
    
    if Reset = '0' then
      NB_round <= 0;
    else
      NB_round <= NB_round +1;
    end if;

  end if;
end process;

---------------------------
-- Control type of round --
---------------------------
with NB_round select
  RoundType <= "00" when 0, -- Round 1 to 5
               "00" when 1,
               "00" when 2,
               "00" when 3,
               "00" when 4,
               "01" when 5, -- Round Middle
               "10" when 6, -- Round 6 to 10
               "10" when 7,
               "10" when 8,
               "10" when 9,
               "10" when 10,
               "00" when others;

-----------------
-- KeySchedule --
-----------------
KEYSCH : KeySchedule port map (CipherKey, Key0, Key0_bis, Key1);


------------------
-- Generate PTI --
------------------
MyPTI <= Key0 XOR Plaintext XOR Key1 XOR RC0;

-------------------
-- RoundConstant --
-------------------
ROUNDC : RoundConstant port map (NB_round, RCstate);

-----------
-- Round --
-----------
ROUNDS : Round port map (RoundType, NewPlain, Key1, RCstate, NewCipher);

-------------
-- Storage --
-------------
STORE : Data_Key_RC_Store port map (Clk, Reset, MyPTI, NewCipher, NewPlain);

---------------------------
-- Send final ciphertext --
---------------------------
Ciphertext <= NewCipher XOR RC11 XOR Key1 XOR Key0_bis;

-------------------------
-- Final round trigger --
-------------------------
EndOfPRINCE <= '1' when NB_round = 10 else '0'; -- 10th round

end Behavioral;