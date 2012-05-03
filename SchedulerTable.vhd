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
				data_b 	: in	std_logic_vector(word_size-1 downto 0);
				addr_a 	: in 	natural range 0 to 2**address_size-1;
				addr_b 	: in 	natural range 0 to 2**address_size-1;
				we_a		: in	std_logic;
				we_b		: in  std_logic;
				clk		: in	std_logic;
				rst		: in  std_logic;
				full		: out std_logic;
				purge		: in 	std_logic;
				count		: out natural range 0 to 2**address_size-1;
				q_a 		: out std_logic_vector(word_size-1 downto 0);
				q_b 		: out std_logic_vector(word_size-1 downto 0));
end SchedulerTable;

architecture Behavioral of SchedulerTable is
	type memory_type is array(0 to 2**address_size-1) of
		std_logic_vector(word_size-1 downto 0);
	shared variable sch_table: memory_type;
	signal table_full : std_logic;
	
begin

	--Port A
	process(clk, rst)
	begin		
			
		if(rising_edge(clk)) then
			if(we_a = '1' and table_full = '0') then
				sch_table(addr_a) := data_a;
			end if;
						
			q_a <= sch_table(addr_a);
		end if;	
	end process;
	
	--Port B
	process(clk)
	begin
	
		if(rising_edge(clk)) then
			if(we_b = '1' and table_full = '0') then
				sch_table(addr_b) := data_b;
			end if;
			
			q_b <= sch_table(addr_b);
		end if;
	end process;
	
	--Capacity Monitor
	process(rst, we_a, we_b, purge)
	variable slots_taken : natural range 0 to 2**address_size-1;
	begin
				
			if(rst'event and rst = '1') then
				slots_taken := 0;
			end if;
		
			if(we_a = '1' and purge = '0') then
				slots_taken := slots_taken + 1;
			end if;
			
			if(we_b = '1' and purge = '0') then
				slots_taken := slots_taken + 1;
			end if;
			
			if(we_a = '0' and purge = '1') then
				slots_taken := slots_taken - 1;
			end if;
			
			if(we_b = '0' and purge = '1') then
				slots_taken := slots_taken - 1;
			end if;
		
			--Always notify table capacity status
			if(slots_taken = 256) then
				full <= '1';
				table_full <= '1';
			else
				full <= '0';
				table_full <= '0';
			end if;

			--Count Signal
			count <= slots_taken;
	end process;
end Behavioral;

