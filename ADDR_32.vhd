-------------------------------------------------------------------------------
-- Author: Alejandro Daniel Lemus Najera
-- 
-- Create Date: 03:37:11 07/15/2020
-- Design Name: 32-bit adder
-- Module Name: ADD_32 - Behavioral
-- Project Name: 32 Bit RISC Processor
-- Tool versions: ISE Design Suite 14.6
-- Description: 32-bit adder built by cascading multiple FA modules
-- Dependencies: FA.vhd
---------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADDR_32 is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0); -- A[31:0] operand
           B : in  STD_LOGIC_VECTOR (31 downto 0); -- B[31:0] operand
           CIN : in  STD_LOGIC;			   -- CIN input carry bit
           S : out  STD_LOGIC_VECTOR (31 downto 0); -- Result S[31:0]
           COUT : out  STD_LOGIC); 		   -- COUT output carry bit
end ADDR_32;

architecture Behavioral of ADDR_32 is

-- full adder component declaration
component FA
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           CIN : in  STD_LOGIC;
           S : out  STD_LOGIC;
           COUT : out  STD_LOGIC);
end component;

-- signal for keeping each of the 31 carry bits produced by all FA modules
signal int_c : STD_LOGIC_VECTOR (31 downto 0);	
-- signal for connecting COUT bit from last FA module
signal int_cout : STD_LOGIC;

begin
	-- FA0 module instantiation
	Full_Adder_0: FA
		port map (A => A(0), B => B(0), CIN => CIN, S => S(0), COUT => int_c(0));
		
	-- instantiation for the remaining 31 FA modules
	cascade : for i in 1 to 31 generate
		Full_Adder_i: FA
		port map (A => A(i), B => B(i), CIN => int_c(i - 1), S => S(i), COUT => int_c(i));
	end generate;

	-- last carry bit assignment to COUT outpu
	int_cout <= int_c(31);
	COUT <= int_cout;				
end Behavioral;

