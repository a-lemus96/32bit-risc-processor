--------------------------------------------------------------------------------
-- Author: Alejandro Daniel Lemus Najera
-- 
-- Create Date: 06:23:21 07/15/2020
-- Design Name: 32-bit adder
-- Module Name: ARITH - Behavioral
-- Project Name: 32 Bit RISC Processor
-- Tool versions: ISE Design Suite 14.6
-- Description: Arithmetic unit. It is built based on ADDR_32 and NOR_32 modules
-- Dependencies: ADDR_32.vhd, NOR_32.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ARITH is
	Port ( A : in STD_LOGIC_VECTOR (31 downto 0); -- A[31:0] operand
	       B : in STD_LOGIC_VECTOR (31 downto 0); -- B[31:0] operand
	       AFN : in STD_LOGIC; -- operation selection (add/substract)
	       S : out STD_LOGIC_VECTOR (31 downto 0); -- S[31:0] result
	       Z : out STD_LOGIC; -- zero result indicator flag
	       V : out STD_LOGIC; -- overflow indicator flag
	       N : out STD_LOGIC); -- negative result indicator flag
end ARITH;

architecture Behavioral of ARITH is

-- 32-bit adder component declaration
component ADDR_32
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           CIN : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (31 downto 0);
           COUT : out  STD_LOGIC);
end component;

-- 32-bit NOR gate component declaration
component NOR_32
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0); -- A[31:0] operand
           Z : out  STD_LOGIC);	-- NOR operation between all the bits in A
end component;

-- ones' complement and 32-bit adder output signals
signal xb, sum : STD_LOGIC_VECTOR (31 downto 0);
signal cout : STD_LOGIC;

begin
	-- XOR gates to find ones' complement of B and assign it to xb
	complement_1 : for i in 0 to 31 generate
		xb(i) <= B(i) xor AFN;
	end generate;	

	-- ADDR_32 module instantiation
	Adder_32_Bit : ADDR_32
		port map ( A => A, 
			   B => xb, 
			   CIN => AFN, 
			   S => sum, 
			   COUT => cout );			

	S <= sum; -- sum signal connection with output S	

	-- NOR_32 module instantiation
	NOR_32_Inputs : NOR_32
		port map( A => sum,
			  Z => Z );	

	-- SOP expression for V flag
	V <= (A(31) and xb(31) and not(sum(31))) or (not(A(31)) and not(xb(31)) and sum(31));

	-- sum(31) contains the sign bit to be connected with N flag
	N <= sum(31);	
end Behavioral;
