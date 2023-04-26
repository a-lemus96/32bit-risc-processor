----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:43:50 07/20/2020 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);			-- Operando A[31:0]
           B : in  STD_LOGIC_VECTOR (31 downto 0);			-- Operando B[31:0]
           FN : in  STD_LOGIC_VECTOR (5 downto 0);			-- Operacion a realizar FN[5:0]
           Y : out  STD_LOGIC_VECTOR (31 downto 0));		-- Salida Y[31:0]
end ALU;

----------------------------------------------------------------------------------

architecture Behavioral of ALU is
component SHIFT
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);			-- Operando A[31:0].
           B : in  STD_LOGIC_VECTOR (4 downto 0);			-- Indica la cantidad de desplazamientos a realizar.
           SFN : in  STD_LOGIC_VECTOR (1 downto 0);		-- Indica el tipo de desplazamiento.
           Y : out  STD_LOGIC_VECTOR (31 downto 0));		-- Salida Y[31:0].
end component;

component BOOL
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);			-- Operando A[31:0]
           B : in  STD_LOGIC_VECTOR (31 downto 0);			-- Operando B[31:0]
           BFN : in  STD_LOGIC_VECTOR (3 downto 0);		-- Indica la operacion a realizar BFN[3:0]
           Y : out  STD_LOGIC_VECTOR (31 downto 0));		-- Salida Y[31:0]
end component;

component ARITH
	Port ( A : in STD_LOGIC_VECTOR (31 downto 0);		-- Operando A[31:0]
			 B : in STD_LOGIC_VECTOR (31 downto 0);		-- Operando B[31:0]
			 AFN : in STD_LOGIC;									-- Entrada AFN, indica el tipo de operación (suma o resta)
			 S : out STD_LOGIC_VECTOR (31 downto 0);		-- Resultado S[31:0]
			 Z : out STD_LOGIC;									-- Indicador de cero en el resultado
			 V : out STD_LOGIC;									-- Indicador de sobreflujo en el resultado
			 N : out STD_LOGIC);									-- Indicador de resultado negativo
end component;

component CMP
    Port ( Z : in  STD_LOGIC;										-- Entrada Z, proveniente del módulo ARITH.
           V : in  STD_LOGIC;										-- Entrada V, proveniente del módulo ARITH.
           N : in  STD_LOGIC;										-- Entrada N, proveniente del módulo ARITH.
           CFN : in  STD_LOGIC_VECTOR (1 downto 0);		-- Entrada de control CFN[1:0], determina el tipo de comparación a realizar.
           Y : out  STD_LOGIC_VECTOR (31 downto 0));		-- Salida Y[31:0]
end component;

signal z, v, n : STD_LOGIC;
signal shift_result, bool_result, arith_result, cmp_result : STD_LOGIC_VECTOR (31 downto 0);
signal operation : STD_LOGIC_VECTOR (1 downto 0);
begin
	Shift_Unit : SHIFT
		port map(A => A, B(0) => B(0), B(1) => B(1), B(2) => B(2), B(3) => B(3), B(4) => B(4), 
					SFN(0) => FN(0), SFN(1) => FN(1), Y => shift_result);
					
	Boolean_Unit : BOOL
		port map(A => A, B => B, BFN(0) => FN(0), BFN(1) => FN(1), BFN(2) => FN(2), BFN(3) => FN(3), Y => bool_result);
		
	Arithmetic_Unit : ARITH
		port map(A => A, B => B, AFN => FN(0), S => arith_result, Z => z, V => v, N => n);
		
	Compare_Unit : CMP
		port map(Z => z, V => v, N => n, CFN(0) => FN(1), CFN(1) => FN(2), Y => cmp_result);
		
	
	operation(1) <= FN(5);
	operation(0) <= FN(4);
	
	with operation select
		Y <= shift_result when "11",
			  bool_result when "10",
			  arith_result when "01",
			  cmp_result when "00",
			  x"00000000" when others;
	
end Behavioral;

