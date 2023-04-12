--------------------------------------------------------------------------------
-- Engineer: Alejandro Daniel Lemus Najera 
-- 
-- Create Date: 03:56:57 07/12/2020 
-- Design Name: Full Adder
-- Module Name: alu_fa - Behavioral 
-- Project Name: 32 Bit RISC Processor
-- Tool versions: ISE Design Suite 14.6
-- Description: Full adder implementation based on its sum-of-products represen-
--		tation (SOP)
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           CIN : in  STD_LOGIC;
           S : out  STD_LOGIC;
           COUT : out  STD_LOGIC);
end FA;

architecture Behavioral of FA is
-- signals for partial products associated with S and COUT outputs
signal pp_s: STD_LOGIC_VECTOR(3 downto 0);
signal pp_c: STD_LOGIC_VECTOR(3 downto 0); 

begin
	-- bit-wise assignment of partial products to signal pp_s
	pp_s(0) <= (not A) and (not B) and CIN;				
	pp_s(1) <= (not A) and B and (not CIN);
	pp_s(2) <= A and (not B) and (not CIN);
	pp_s(3) <= A and B and CIN;
	
	-- bit-wise assignment of partial products to signal pp_c
	pp_c(0) <= (not A) and B and CIN;
	pp_c(1) <= A and (not B) and CIN;
	pp_c(2) <= A and B and (not CIN);
	pp_c(3) <= A and B and CIN;
	
	-- connect partial products to OR gates entries to produce S and COUT
	S <= pp_s(0) or pp_s(1) or pp_s(2) or pp_s(3);
	COUT <= pp_c(0) or pp_c(1) or pp_c(2) or pp_c(3);
end Behavioral;
