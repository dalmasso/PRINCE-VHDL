------------------------------------------------------------------------
-- Engineer:	Dalmasso Loic
-- Create Date:	12/05/2018
-- Module Name:	M' matrix layer - Behavioral
-- Description:
--	  	Generate M' matrix layer of PRINCE encryption
--      Input data - M_pLayer_Input : 64bits of M' matrix layer
--      Output data - M_pLayer_Output : 64bits of M' matrix layer updated
------------------------------------------------------------------------

--  LUT

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY M_pLayer is

PORT( M_pLayer_Input  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
	  M_pLayer_Output : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);

-- No optimization  
attribute dont_touch : string;
attribute dont_touch of M_pLayer : entity is "true";

END M_pLayer;

ARCHITECTURE Behavioral of M_pLayer is

------------------------------------------------------------------------
-- Module Implementation
------------------------------------------------------------------------
begin

-- M0 Matrix : 	0000			M1 Matrix : 1000
--				0100						0000
--				0010						0010
--				0001						0001

-- M2 Matrix : 	1000			M3 Matrix : 1000
--				0100						0100
--				0000						0010
--				0001						0000

-- M^0 Matrix : M0 M1 M2 M3		M^1 Matrix : M1 M2 M3 M0
--				M1 M2 M3 M0					 M2 M3 M0 M1
--				M2 M3 M0 M1					 M3 M0 M1 M2
--				M3 M0 M1 M2					 M0 M1 M2 M3

-- M' Matrix : M^0, M^1, M^1, M^0

-- M^0 				     M^1 				   M^1 				     M^0
-- 0000 1000 1000 1000   1000 1000 1000 0000   1000 1000 1000 0000   0000 1000 1000 1000
-- 0100 0000 0100 0100   0000 0100 0100 0100   0000 0100 0100 0100   0100 0000 0100 0100
-- 0010 0010 0000 0010   0010 0000 0010 0010   0010 0000 0010 0010   0010 0010 0000 0010
-- 0001 0001 0001 0000   0001 0001 0000 0001   0001 0001 0000 0001   0001 0001 0001 0000

-- 1000 1000 1000 0000   1000 1000 0000 1000   1000 1000 0000 1000   1000 1000 1000 0000
-- 0000 0100 0100 0100   0100 0100 0100 0000   0100 0100 0100 0000   0000 0100 0100 0100
-- 0010 0000 0010 0010   0000 0010 0010 0010   0000 0010 0010 0010   0010 0000 0010 0010
-- 0001 0001 0000 0001   0001 0000 0001 0001   0001 0000 0001 0001   0001 0001 0000 0001

-- 1000 1000 0000 1000   1000 0000 1000 1000   1000 0000 1000 1000   1000 1000 0000 1000
-- 0100 0100 0100 0000   0100 0100 0000 0100   0100 0100 0000 0100   0100 0100 0100 0000
-- 0000 0010 0010 0010   0010 0010 0010 0000   0010 0010 0010 0000   0000 0010 0010 0010
-- 0001 0000 0001 0001   0000 0001 0001 0001   0000 0001 0001 0001   0001 0000 0001 0001

-- 1000 0000 1000 1000   0000 1000 1000 1000   0000 1000 1000 1000   1000 0000 1000 1000
-- 0100 0100 0000 0100   0100 0000 0100 0100   0100 0000 0100 0100   0100 0100 0000 0100
-- 0010 0010 0010 0000   0010 0010 0000 0010   0010 0010 0000 0010   0010 0010 0010 0000
-- 0000 0001 0001 0001   0001 0001 0001 0000   0001 0001 0001 0000   0000 0001 0001 0001



-- M^0
M_pLayer_Output(63) <= M_pLayer_Input(59) xor M_pLayer_Input(55) xor M_pLayer_Input(51);
M_pLayer_Output(62) <= M_pLayer_Input(62) xor M_pLayer_Input(54) xor M_pLayer_Input(50);
M_pLayer_Output(61) <= M_pLayer_Input(61) xor M_pLayer_Input(57) xor M_pLayer_Input(49);
M_pLayer_Output(60) <= M_pLayer_Input(60) xor M_pLayer_Input(56) xor M_pLayer_Input(52);
M_pLayer_Output(59) <= M_pLayer_Input(63) xor M_pLayer_Input(59) xor M_pLayer_Input(55);
M_pLayer_Output(58) <= M_pLayer_Input(58) xor M_pLayer_Input(54) xor M_pLayer_Input(50);
M_pLayer_Output(57) <= M_pLayer_Input(61) xor M_pLayer_Input(53) xor M_pLayer_Input(49);
M_pLayer_Output(56) <= M_pLayer_Input(60) xor M_pLayer_Input(56) xor M_pLayer_Input(48);
M_pLayer_Output(55) <= M_pLayer_Input(63) xor M_pLayer_Input(59) xor M_pLayer_Input(51);
M_pLayer_Output(54) <= M_pLayer_Input(62) xor M_pLayer_Input(58) xor M_pLayer_Input(54);
M_pLayer_Output(53) <= M_pLayer_Input(57) xor M_pLayer_Input(53) xor M_pLayer_Input(49);
M_pLayer_Output(52) <= M_pLayer_Input(60) xor M_pLayer_Input(52) xor M_pLayer_Input(48);
M_pLayer_Output(51) <= M_pLayer_Input(63) xor M_pLayer_Input(55) xor M_pLayer_Input(51);
M_pLayer_Output(50) <= M_pLayer_Input(62) xor M_pLayer_Input(58) xor M_pLayer_Input(50);
M_pLayer_Output(49) <= M_pLayer_Input(61) xor M_pLayer_Input(57) xor M_pLayer_Input(53);
M_pLayer_Output(48) <= M_pLayer_Input(56) xor M_pLayer_Input(52) xor M_pLayer_Input(48);

-- M^1
M_pLayer_Output(47) <= M_pLayer_Input(47) xor M_pLayer_Input(43) xor M_pLayer_Input(39);
M_pLayer_Output(46) <= M_pLayer_Input(42) xor M_pLayer_Input(38) xor M_pLayer_Input(34);
M_pLayer_Output(45) <= M_pLayer_Input(45) xor M_pLayer_Input(37) xor M_pLayer_Input(33);
M_pLayer_Output(44) <= M_pLayer_Input(44) xor M_pLayer_Input(40) xor M_pLayer_Input(32);
M_pLayer_Output(43) <= M_pLayer_Input(47) xor M_pLayer_Input(43) xor M_pLayer_Input(35);
M_pLayer_Output(42) <= M_pLayer_Input(46) xor M_pLayer_Input(42) xor M_pLayer_Input(38);
M_pLayer_Output(41) <= M_pLayer_Input(41) xor M_pLayer_Input(37) xor M_pLayer_Input(33);
M_pLayer_Output(40) <= M_pLayer_Input(44) xor M_pLayer_Input(36) xor M_pLayer_Input(32);
M_pLayer_Output(39) <= M_pLayer_Input(47) xor M_pLayer_Input(39) xor M_pLayer_Input(35);
M_pLayer_Output(38) <= M_pLayer_Input(46) xor M_pLayer_Input(42) xor M_pLayer_Input(34);
M_pLayer_Output(37) <= M_pLayer_Input(45) xor M_pLayer_Input(41) xor M_pLayer_Input(37);
M_pLayer_Output(36) <= M_pLayer_Input(40) xor M_pLayer_Input(36) xor M_pLayer_Input(32);
M_pLayer_Output(35) <= M_pLayer_Input(43) xor M_pLayer_Input(39) xor M_pLayer_Input(35);
M_pLayer_Output(34) <= M_pLayer_Input(46) xor M_pLayer_Input(38) xor M_pLayer_Input(34);
M_pLayer_Output(33) <= M_pLayer_Input(45) xor M_pLayer_Input(41) xor M_pLayer_Input(33);
M_pLayer_Output(32) <= M_pLayer_Input(44) xor M_pLayer_Input(40) xor M_pLayer_Input(36);

-- M^1
M_pLayer_Output(31) <= M_pLayer_Input(31) xor M_pLayer_Input(27) xor M_pLayer_Input(23);
M_pLayer_Output(30) <= M_pLayer_Input(26) xor M_pLayer_Input(22) xor M_pLayer_Input(18);
M_pLayer_Output(29) <= M_pLayer_Input(29) xor M_pLayer_Input(21) xor M_pLayer_Input(17);
M_pLayer_Output(28) <= M_pLayer_Input(28) xor M_pLayer_Input(24) xor M_pLayer_Input(16);
M_pLayer_Output(27) <= M_pLayer_Input(31) xor M_pLayer_Input(27) xor M_pLayer_Input(19);
M_pLayer_Output(26) <= M_pLayer_Input(30) xor M_pLayer_Input(26) xor M_pLayer_Input(22);
M_pLayer_Output(25) <= M_pLayer_Input(25) xor M_pLayer_Input(21) xor M_pLayer_Input(17);
M_pLayer_Output(24) <= M_pLayer_Input(28) xor M_pLayer_Input(20) xor M_pLayer_Input(16);
M_pLayer_Output(23) <= M_pLayer_Input(31) xor M_pLayer_Input(23) xor M_pLayer_Input(19);
M_pLayer_Output(22) <= M_pLayer_Input(30) xor M_pLayer_Input(26) xor M_pLayer_Input(18);
M_pLayer_Output(21) <= M_pLayer_Input(29) xor M_pLayer_Input(25) xor M_pLayer_Input(21);
M_pLayer_Output(20) <= M_pLayer_Input(24) xor M_pLayer_Input(20) xor M_pLayer_Input(16);
M_pLayer_Output(19) <= M_pLayer_Input(27) xor M_pLayer_Input(23) xor M_pLayer_Input(19);
M_pLayer_Output(18) <= M_pLayer_Input(30) xor M_pLayer_Input(22) xor M_pLayer_Input(18);
M_pLayer_Output(17) <= M_pLayer_Input(29) xor M_pLayer_Input(25) xor M_pLayer_Input(17);
M_pLayer_Output(16) <= M_pLayer_Input(28) xor M_pLayer_Input(24) xor M_pLayer_Input(20);

-- M^0
M_pLayer_Output(15) <= M_pLayer_Input(11) xor M_pLayer_Input(7)  xor M_pLayer_Input(3);
M_pLayer_Output(14) <= M_pLayer_Input(14) xor M_pLayer_Input(6)  xor M_pLayer_Input(2);
M_pLayer_Output(13) <= M_pLayer_Input(13) xor M_pLayer_Input(9)  xor M_pLayer_Input(1);
M_pLayer_Output(12) <= M_pLayer_Input(12) xor M_pLayer_Input(8)  xor M_pLayer_Input(4);
M_pLayer_Output(11) <= M_pLayer_Input(15) xor M_pLayer_Input(11) xor M_pLayer_Input(7);
M_pLayer_Output(10) <= M_pLayer_Input(10) xor M_pLayer_Input(6)  xor M_pLayer_Input(2);
M_pLayer_Output(9)  <= M_pLayer_Input(13) xor M_pLayer_Input(5)  xor M_pLayer_Input(1);
M_pLayer_Output(8)  <= M_pLayer_Input(12) xor M_pLayer_Input(8)  xor M_pLayer_Input(0);
M_pLayer_Output(7)  <= M_pLayer_Input(15) xor M_pLayer_Input(11) xor M_pLayer_Input(3);
M_pLayer_Output(6)  <= M_pLayer_Input(14) xor M_pLayer_Input(10) xor M_pLayer_Input(6);
M_pLayer_Output(5)  <= M_pLayer_Input(9)  xor M_pLayer_Input(5)  xor M_pLayer_Input(1);
M_pLayer_Output(4)  <= M_pLayer_Input(12) xor M_pLayer_Input(4)  xor M_pLayer_Input(0);
M_pLayer_Output(3)  <= M_pLayer_Input(15) xor M_pLayer_Input(7)  xor M_pLayer_Input(3);
M_pLayer_Output(2)  <= M_pLayer_Input(14) xor M_pLayer_Input(10) xor M_pLayer_Input(2);
M_pLayer_Output(1)  <= M_pLayer_Input(13) xor M_pLayer_Input(9)  xor M_pLayer_Input(5);
M_pLayer_Output(0)  <= M_pLayer_Input(8)  xor M_pLayer_Input(4)  xor M_pLayer_Input(0);

end Behavioral;