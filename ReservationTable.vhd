----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:58:25 06/09/2011 
-- Design Name: 
-- Module Name:    ReservationTable - Behavioral 
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

entity ReservationTable is
	generic(word_size 	: natural;
			  address_size	: natural);
   port (  	data_a 	: in	std_logic_vector(word_size-1 downto 0);
				data_b	: in 	std_logic_vector(word_size-1 downto 0);
			  	addr_a 	: in 	natural range 0 to 2**address_size-1;
				addr_b	: in 	natural range 0 to 2**address_size-1;
				we_a		: in	std_logic := '1';
				we_b		: in 	std_logic := '1';
				clk		: in	std_logic;
				full		: out std_logic;
				purge		: in  std_logic;
				q_a 		: out std_logic_vector(word_size-1 downto 0);
				q_b		: out std_logic_vector(word_size-1 downto 0));
end ReservationTable;

architecture Behavioral of ReservationTable is
	type memory_type is array (0 to 2**address_size-1) of
		std_logic_vector(word_size-1 downto 0);
	shared variable rsv_table : memory_type;
	shared variable slots_taken : natural range 0 to 2**address_size-1;
	signal table_full : std_logic;
	
begin

	--Port A
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(we_a = '1' and table_full = '0' and purge = '0') then
				rsv_table(addr_a) := data_a;
				slots_taken := slots_taken + 1;			--Increment
			end if;
			
			if(we_a = '1' and purge = '1') then
				slots_taken := slots_taken - 1;			--Decrement
			end if;
			
			q_a <= rsv_table(addr_a);
		end if;	
	end process;
	
	--Port B
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(we_b = '1' and table_full = '0' and purge = '0') then
				rsv_table(addr_b) := data_b;
				--slots_taken := slots_taken + 1;			--Increment
			end if;
			
			q_b <= rsv_table(addr_b);
		end if;
	end process;
	
	--Check Capacity of Table
	table_full <= '1' when (slots_taken = 256) else '0';
	full <= '1' when (slots_taken = 256) else '0';
	
end Behavioral;

