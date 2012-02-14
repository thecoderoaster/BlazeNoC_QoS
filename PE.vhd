----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:37:49 01/08/2012 
-- Design Name: 
-- Module Name:    PE - Behavioral 
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.router_library.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PE is
    Port ( clk 					: in  std_logic;
           reset 					: in  std_logic;
			  trigger 				: in  std_logic;									-- From Traffic Generator
			  full					: out std_logic;									-- To Traffic Generator
			  done					: out std_logic;									-- To Traffic Generator
			  tb_data_out			: in 	std_logic_vector (WIDTH downto 0);
           injection_data 		: out std_logic_vector (WIDTH downto 0);
           injection_enq 		: out std_logic;
           injection_status 	: in  std_logic_vector (1 downto 0);	  	-- Buffer status to PE;
			  ejection_data 		: in  std_logic_vector (WIDTH downto 0);
			  ejection_deq 		: out std_logic;
           ejection_status 	: in  std_logic_vector (1 downto 0));		-- Buffer status to PE
end PE;

architecture rtl of PE is

type state_type is (start, wait_state, triggered_state, send_state, 
						  full_state, ctr_state, receive_state);   --61 State FSM

signal state1, next_state1, state2, next_state2 : state_type;

signal ram_data_rcvd 	: std_logic_vector(WIDTH downto 0);

begin

	--State Machine(s)
	process
	begin
		wait until rising_edge(clk);
		if reset = '1' then
			state1 <= start;
			state2 <= start;
		else
			state1 <= next_state1;
			state2 <= next_state2;
		end if;
	end process;

	--Handles incoming packets to FSM
	receive_process: process(state1)
	begin
		case state1 is
			when start =>
				--Reset state
				ejection_deq <= '0';
				next_state1 <= wait_state;
			when wait_state =>
				--Wait state
				if(ejection_status = FULL_FIFO) then
					next_state1 <= ctr_state;
				elsif(ejection_status = EMPTY_FIFO) then
					next_state1 <= start;
				elsif(ejection_status = NORM_FIFO) then
					next_state1 <= start;
				elsif(ejection_status = ERR_FIFO) then
					next_state1 <= start;
				else
					next_state1 <= start;
				end if;
			when ctr_state =>
				--Dequeue a packet from the FIFO
				ejection_deq <= '1', '0' after 1 ns;
				next_state1 <= receive_state;
			when receive_state =>
				--Read in the data and notify the FCU that it's good
				ram_data_rcvd <= ejection_data;
				next_state1 <= wait_state;
			when others =>
				next_state1 <= start;
		end case;
	end process;
	
	--Processes outgoing packets
	--send_process: process(state2)
	send_process: process(state2)
	begin
		case state2 is
			when start =>
				--Reset state
				full <= '0';
				done <= '0';
				injection_enq <= '0';
				next_state2 <= wait_state;
			when wait_state =>
				if(trigger = '1') then
					next_state2 <= triggered_state;
				else
					next_state2 <= start;
				end if;
			when full_state =>
				next_state2 <= triggered_state;
			when triggered_state =>
				if(injection_status = FULL_FIFO) then
					full <= '1';
					next_state2 <= full_state;
				elsif(injection_status = EMPTY_FIFO) then
					full <= '0';
					next_state2 <= send_state;
				elsif(injection_status = NORM_FIFO) then
					full <= '0';
					next_state2 <= send_state;
				else
					full <= '1';
					next_state2 <= full_state;
				end if;
			when send_state =>
				injection_data <= tb_data_out;
				injection_enq <= '1', '0' after 1 ns;
				done <= '1';
				next_state2 <= start;
			when others =>
				next_state2 <= start;
		end case;
	end process;
end rtl;

