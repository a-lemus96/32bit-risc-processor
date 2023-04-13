--------------------------------------------------------------------------------
-- Author: Alejandro Daniel Lemus Najera
-- 
-- Create Date: 06:08:46 07/19/2020
-- Design Name: 4-entry multiplexor
-- Module Name: MUX_4 - Behavioral
-- Project Name: 32 Bit RISC Processor
-- Tool versions: ISE Design Suite 14.6
-- Description: 4-entry multiplexor
-- Dependencies: ADDR_32.vhd, NOR_32.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_4 is
    Port ( DATA : in  STD_LOGIC_VECTOR (3 downto 0); -- DATA[31:0] data entry
           CTL : in  STD_LOGIC_VECTOR (1 downto 0); -- CTL[1:0] control entry
           Y : out  STD_LOGIC ); -- mux output
end MUX_4;

architecture Behavioral of MUX_4 is

begin
	-- mux especification
	with CTL select
		Y <= DATA(3) when "11",			
		     DATA(2) when "10",
		     DATA(1) when "01",
		     DATA(0) when "00",
		     '0' when others;

end Behavioral;
