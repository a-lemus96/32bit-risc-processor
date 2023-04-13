--------------------------------------------------------------------------------
-- Author: Alejandro Daniel Lemus Najera
-- 
-- Create Date: 02:17:08 07/28/2020
-- Design Name: 32-bit nor gate
-- Module Name: NOR_32 - Behavioral
-- Project Name: 32 Bit RISC Processor
-- Tool versions: ISE Design Suite 14.6
-- Description: 32-bit NOR gate using 4-entry NAND and NOR atomic gates
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NOR_32 is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0); -- 32-bit A[31:0] entry
           Z : out  STD_LOGIC);	-- NOR operation between all 32 bits in A
end NOR_32;

architecture Behavioral of NOR_32 is
-- signals for each of the stages of the NOR and NAND based tree
signal nor_stage : STD_LOGIC_VECTOR (7 downto 0);
signal nand_stage : STD_LOGIC_VECTOR (3 downto 0);

begin
	-- NOR stage made out of 8 NOR gates
	nor_stage(0) <= not(A(0) or A(1) or A(2) or A(3));
	nor_stage(1) <= not(A(4) or A(5) or A(6) or A(7));
	nor_stage(2) <= not(A(8) or A(9) or A(10) or A(11));
	nor_stage(3) <= not(A(12) or A(13) or A(14) or A(15));
	nor_stage(4) <= not(A(16) or A(17) or A(18) or A(19));
	nor_stage(5) <= not(A(20) or A(21) or A(22) or A(23));
	nor_stage(6) <= not(A(24) or A(25) or A(26) or A(27));
	nor_stage(7) <= not(A(28) or A(29) or A(30) or A(31));
	
	-- NAND stage made out of 4 NAND gates
	nand_stage(0) <= nor_stage(0) nand nor_stage(1);
	nand_stage(1) <= nor_stage(2) nand nor_stage(3);
	nand_stage(2) <= nor_stage(4) nand nor_stage(5);
	nand_stage(3) <= nor_stage(6) nand nor_stage(7);
	
	-- 4-entry NOR gate whose output is connected to Z
	Z <= not(nand_stage(0) or nand_stage(1) or nand_stage(2) or nand_stage(3));
end Behavioral;

