--------------------------------------------------------------------------------
-- Author: Alejandro Daniel Lemus Najera
-- 
-- Create Date: 04:57:22 07/19/2020
-- Design Name: Boolean unit
-- Module Name: BOOL - Behavioral
-- Project Name: 32 Bit RISC Processor
-- Tool versions: ISE Design Suite 14.6
-- Description: Boolean unit. It performs bit-wise operations between two 32-bit
--		operands.
-- Dependencies; MUX_4.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BOOL is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0); -- A[31:0] operand
           B : in  STD_LOGIC_VECTOR (31 downto 0); -- B[31:0] operand
	   BFN : in  STD_LOGIC_VECTOR (3 downto 0); -- BFN[3:0] operation select
           Y : out  STD_LOGIC_VECTOR (31 downto 0) ); -- output Y[31:0]
end BOOL;

architecture Behavioral of BOOL is

-- 4-entry multiplexor component declaration
component MUX_4
    Port ( DATA : in  STD_LOGIC_VECTOR (3 downto 0);
           CTL : in  STD_LOGIC_VECTOR (1 downto 0);
           Y : out  STD_LOGIC );
end component;

begin
	-- instantiation of 32 multiplexors for each op between B(i) and A(i)
	bitwise_bool : for i in 0 to 31 generate
		LUTs : MUX_4
		port map(DATA => BFN, CTL(1) => B(i), CTL(0) => A(i), Y => Y(i));
	end generate;
end Behavioral;

