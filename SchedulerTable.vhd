----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:08:07 09/10/2011 
-- Design Name: 
-- Module Name:    SchedulerTable - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.router_library.all;


entity SchedulerTable is
	generic(word_size 	: natural;
			  address_size	: natural);
   port ( 	data_a 	: in	std_logic_vector(word_size-1 downto 0);
				data_b	: in 	std_logic_vector(word_size-1 downto 0);
			  	addr_a 	: in 	natural range 0 to address_size-1;
				addr_b	: in 	natural range 0 to address_size-1;
				we_a		: in	std_logic := '1';
				we_b		: in 	std_logic := '1';
				clk		: in	std_logic;
				q_a 		: out std_logic_vector(word_size-1 downto 0);
				q_b		: out std_logic_vector(word_size-1 downto 0));
end SchedulerTable;

architecture Behavioral of SchedulerTable is
	type memory_type is array(0 to 2**address_size-1) of
		std_logic_vector(word_size-1 downto 0);
	shared variable sch_table: memory_type;
	
begin

	--Port A
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(we_a = '1') then
				sch_table(addr_a) := data_a;
			end if;
			q_a <= sch_table(addr_a);
		end if;	
	end process;
	
	--Port B
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(we_b = '1') then
				sch_table(addr_b) := data_b;
			end if;
			q_b <= sch_table(addr_b);
		end if;
	end process;
	
end Behavioral;

