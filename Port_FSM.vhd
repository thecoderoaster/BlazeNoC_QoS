----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:33:23 01/27/2012 
-- Design Name: 
-- Module Name:    Port_FSM - Behavioral 
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

entity Port_FSM is
	Port(clk 				: in  std_logic;
        reset 				: in  std_logic;
		  trigger 			: in  std_logic;
		  tb_data_out		: in 	std_logic_vector (WIDTH downto 0);   	-- Packet submitted by Testbench (top level)
		  data_in 			: in 	std_logic_vector (WIDTH downto 0);		-- Datalink from neighbor (to FCU)
		  din_good			: out std_logic;										-- Data good indicator from neighbor (to FCU)
		  CTR_in				: out std_logic;										-- CTR indicator from neighbor to arbiter indicating ready to recieve (to RNA) *** need implment in rna
		  data_out			: out std_logic_vector (WIDTH downto 0);		-- Datalink to neighbor (from SW)
		  dout_good			: in 	std_logic;										-- Data good indicator to neighbor (from SW)
		  CTR_out			: in 	std_logic);										-- CTR indicator from FCU to neighbor for accpeting data (from FCU)
end Port_FSM;

architecture rtl of Port_FSM is

type state_type is (start, wait_state, send, data_good, 
						  ctr, receive);   --61 State FSM

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
				next_state1 <= wait_state;
			when wait_state =>
				--Wait state
				if(CTR_out = '1') then
					next_state1 <= ctr;
				else
					next_state1 <= wait_state;
				end if;
			when ctr =>
				--Notify the FCU that we're ready for the data.
				CTR_in <= '1', '0' after 1 ns;
				next_state1 <= receive;
			when receive =>
				--Read in the data and notify the FCU that it's good
				ram_data_rcvd <= data_in;
				din_good <= '1', '0' after 1 ns;
				next_state1 <= wait_state;
			when others =>
				next_state1 <= start;
		end case;
	end process;
	
	--Processes outgoing packets
	send_process: process(state2)
	begin
		case state2 is
			when start =>
				--Reset state
				next_state2 <= wait_state;
			when wait_state =>
				if(trigger = '1') then
					next_state2 <= send;
				else
					next_state2 <= wait_state;
				end if;
			when send =>
				data_out <= tb_data_out;
				next_state2 <= data_good;
			when data_good =>
				if(dout_good = '1') then
					next_state2 <= wait_state;
				else
					next_state2 <= data_good;
				end if;
			when others =>
				next_state2 <= start;
		end case;
	end process;


end rtl;

