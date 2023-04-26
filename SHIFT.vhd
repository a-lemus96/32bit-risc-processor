----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:45:45 07/19/2020 
-- Design Name: 
-- Module Name:    SHIFT - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SHIFT is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);			-- Operando A[31:0].
           B : in  STD_LOGIC_VECTOR (4 downto 0);			-- Indica la cantidad de desplazamientos a realizar.
           SFN : in  STD_LOGIC_VECTOR (1 downto 0);		-- Indica el tipo de desplazamiento.
           Y : out  STD_LOGIC_VECTOR (31 downto 0));		-- Salida Y[31:0].
end SHIFT;

architecture Behavioral of SHIFT is
signal rev_A, rev_A_back : STD_LOGIC_VECTOR (31 downto 0); 							-- Señales para invertir el orden de significancia de A[31:0] y sh[31:0].
signal p, q, r, s, t, sh : STD_LOGIC_VECTOR (31 downto 0);
signal sh_16, sh_8, sh_4, sh_2, sh_1 : STD_LOGIC_VECTOR (31 downto 0);
signal sign : STD_LOGIC;

begin
	reverse_A : for i in 0 to 31 generate
		rev_A(i) <= A(31 - i); 
	end generate;
	
	with SFN(0) select
		p <= rev_A when '1',
			  A when '0',
			  x"00000000" when others;

	with SFN(1) select
		sign <= A(31) when '1',
				  '0' when '0',
				  '0' when others;
	
	---------------------------------------------------------------------------------
	
	shift_16_low : for i in 0 to 15 generate		-- Desplazamiento de 16 bits.
		sh_16(i) <= sign;
	end generate;
	shift_16_high : for i in 16 to 31 generate
		sh_16(i) <= p(i - 16);
	end generate;
	
	with B(4) select									-- Seleccion de desplazamiento de 16 bits.
		q <= sh_16 when '1',
			  p when '0',
			  x"00000000" when others;
	
	---------------------------------------------------------------------------------
	
	shift_8_low : for i in 0 to 7 generate		-- Desplazamiento de 8 bits.
		sh_8(i) <= sign;
	end generate;
	shift_8_high : for i in 8 to 31 generate
		sh_8(i) <= q(i - 8);
	end generate;
	
	with B(3) select									-- Seleccion de desplazamiento de 8 bits.
		r <= sh_8 when '1',
			  q when '0',
			  x"00000000" when others;
		
	---------------------------------------------------------------------------------		
			  
	shift_4_low : for i in 0 to 3 generate		-- Desplazamiento de 4 bits.
		sh_4(i) <= sign;
	end generate;
	shift_4_high : for i in 4 to 31 generate
		sh_4(i) <= r(i - 4);
	end generate;
	
	with B(2) select									-- Seleccion de desplazamiento de 4 bits.
		s <= sh_4 when '1',
			  r when '0',
			  x"00000000" when others;
			  
	---------------------------------------------------------------------------------		
			  
	shift_2_low : for i in 0 to 1 generate		-- Desplazamiento de 2 bits.
		sh_2(i) <= sign;
	end generate;
	shift_2_high : for i in 2 to 31 generate
		sh_2(i) <= s(i - 2);
	end generate;
	
	with B(1) select									-- Seleccion de desplazamiento de 2 bits.
		t <= sh_2 when '1',
			  s when '0',
			  x"00000000" when others;
			  
	---------------------------------------------------------------------------------		
			  
	shift_1_low : for i in 0 to 0 generate		-- Desplazamiento de 1 bit.
		sh_1(i) <= sign;
	end generate;
	shift_1_high : for i in 1 to 31 generate
		sh_1(i) <= t(i - 1);
	end generate;
	
	with B(0) select									-- Seleccion de desplazamiento de 1 bit.
		sh <= sh_1 when '1',
			  t when '0',
			  x"00000000" when others;
			  
	---------------------------------------------------------------------------------

	--rev_A_back <= sh;		-- Se invierten las posiciones de los bits de sh
	reverse_back : for i in 0 to 31 generate
	rev_A_back(i) <= sh(31 - i); 
	end generate;
	with SFN(0) select
		Y <= rev_A_back when '1',
			  sh when '0',
			  x"00000000" when others;
			  
end Behavioral;

