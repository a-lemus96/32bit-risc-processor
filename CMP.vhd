--------------------------------------------------------------------------------
-- Author: Alejandro Daniel Lemus Najera
-- 
-- Create Date: 06:25:25 07/19/2020
-- Design Name: Comparison unit
-- Module Name: CMP - Behavioral
-- Project Name: 32 Bit RISC Processor
-- Tool versions: ISE Design Suite 14.6
-- Description: Comparison unit for determining the comparisons (=, <, <=)
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CMP is
    Port ( Z : in  STD_LOGIC; -- zero result indicator flag
           V : in  STD_LOGIC; -- overflow indicator flag
           N : in  STD_LOGIC; -- negative result indicator flag
           CFN : in  STD_LOGIC_VECTOR (1 downto 0); -- CFN[1:0] comparison type
           Y : out  STD_LOGIC_VECTOR (31 downto 0) ); -- Y[31:0] output
end CMP;

architecture Behavioral of CMP is

-- signals to be connected to mux entries
signal s3, s2, s1, s0 : STD_LOGIC;

begin
	-- find if A[31:0] is less than or equal to B[31:0]
	s3 <= Z or (N xor V);
	-- find if A[31:0] is less than B[31:0]
	s2 <= N xor V;
	-- find if A[31:0] equals B[31:0]
	s1 <= Z;	
	-- remaining mux entry
	s0 <= '0';

	-- 4-entry mux whose output is connected to bit Y[0]
	with CFN select
		Y(0) <= s3 when "11",
			s2 when "10",			
			s1 when "01",
			s0 when "00",
			'0' when others;
	
	-- assignment for the rest of the 31 bits in Y[31:1]
	zeros : for i in 1 to 31 generate
		Y(i) <= '0';
	end generate;
end Behavioral;
