----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:49:39 06/04/2011 
-- Design Name: 
-- Module Name:    ControlUnit - Behavioral 
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

entity ControlUnit is
	generic(pkt_size		: natural;
			  address_size : natural;
			  rsv_size 		: natural;
			  sch_size		: natural
			  );
	port(
			clk				   : in 	std_logic;
			rst					: in 	std_logic;
			
			--North Set 
			n_rsv_data_in_a	: in 	std_logic_vector (rsv_size-1 downto 0);
			n_rsv_data_in_b	: in 	std_logic_vector (rsv_size-1 downto 0);
			n_rsv_addr_a		: out natural range 0 to address_size-1;
			n_rsv_addr_b		: out natural range 0 to address_size-1;
			n_rsv_wen_a			: out std_logic;
			n_rsv_wen_b			: out std_logic;
			n_rsv_table_full	: in 	std_logic;
			n_rsv_data_out_a	: out std_logic_vector (rsv_size-1 downto 0);
			n_rsv_data_out_b	: out std_logic_vector (rsv_size-1 downto 0);
			n_sch_data_in_a	: in 	std_logic_vector (sch_size-1 downto 0);
			n_sch_data_in_b	: in 	std_logic_vector (sch_size-1 downto 0);
			n_sch_addr_a		: out natural range 0 to address_size-1;
			n_sch_addr_b		: out natural range 0 to address_size-1;
			n_sch_wen_a			: out std_logic;
			n_sch_wen_b			: out std_logic;
			n_sch_sort			: out std_logic;
			n_sch_table_full	: in std_logic;
			n_sch_data_out_a	: out std_logic_vector (sch_size-1 downto 0);
			n_sch_data_out_b	: out std_logic_vector (sch_size-1 downto 0);
			
			--East Set
			e_rsv_data_in_a	: in 	std_logic_vector (rsv_size-1 downto 0);
			e_rsv_data_in_b	: in 	std_logic_vector (rsv_size-1 downto 0);
			e_rsv_addr_a		: out natural range 0 to address_size-1;
			e_rsv_addr_b		: out natural range 0 to address_size-1;
			e_rsv_wen_a			: out std_logic;
			e_rsv_wen_b			: out std_logic;
			e_rsv_table_full	: in 	std_logic;
			e_rsv_data_out_a	: out std_logic_vector (rsv_size-1 downto 0);
			e_rsv_data_out_b	: out std_logic_vector (rsv_size-1 downto 0);
			e_sch_data_in_a	: in 	std_logic_vector (sch_size-1 downto 0);
			e_sch_data_in_b	: in 	std_logic_vector (sch_size-1 downto 0);
			e_sch_addr_a		: out natural range 0 to address_size-1;
			e_sch_addr_b		: out natural range 0 to address_size-1;
			e_sch_wen_a			: out std_logic;
			e_sch_wen_b			: out std_logic;
			e_sch_sort			: out std_logic;
			e_sch_table_full	: in std_logic;
			e_sch_data_out_a	: out std_logic_vector (sch_size-1 downto 0);
			e_sch_data_out_b	: out std_logic_vector (sch_size-1 downto 0);
			
			--South Set
			s_rsv_data_in_a	: in 	std_logic_vector (rsv_size-1 downto 0);
			s_rsv_data_in_b	: in 	std_logic_vector (rsv_size-1 downto 0);
			s_rsv_addr_a		: out natural range 0 to address_size-1;
			s_rsv_addr_b		: out natural range 0 to address_size-1;
			s_rsv_wen_a			: out std_logic;
			s_rsv_wen_b			: out std_logic;
			s_rsv_table_full	: in 	std_logic;
			s_rsv_data_out_a	: out std_logic_vector (rsv_size-1 downto 0);
			s_rsv_data_out_b	: out std_logic_vector (rsv_size-1 downto 0);
			s_sch_data_in_a	: in 	std_logic_vector (sch_size-1 downto 0);
			s_sch_data_in_b	: in 	std_logic_vector (sch_size-1 downto 0);
			s_sch_addr_a		: out natural range 0 to address_size-1;
			s_sch_addr_b		: out natural range 0 to address_size-1;
			s_sch_wen_a			: out std_logic;
			s_sch_wen_b			: out std_logic;
			s_sch_sort			: out std_logic;
			s_sch_table_full	: in std_logic;
			s_sch_data_out_a	: out std_logic_vector (sch_size-1 downto 0);
			s_sch_data_out_b	: out std_logic_vector (sch_size-1 downto 0);
			
			--West Set
			w_rsv_data_in_a	: in 	std_logic_vector (rsv_size-1 downto 0);
			w_rsv_data_in_b	: in 	std_logic_vector (rsv_size-1 downto 0);
			w_rsv_addr_a		: out natural range 0 to address_size-1;
			w_rsv_addr_b		: out natural range 0 to address_size-1;
			w_rsv_wen_a			: out std_logic;
			w_rsv_wen_b			: out std_logic;
			w_rsv_table_full	: in 	std_logic;
			w_rsv_data_out_a	: out std_logic_vector (rsv_size-1 downto 0);
			w_rsv_data_out_b	: out std_logic_vector (rsv_size-1 downto 0);
			w_sch_data_in_a	: in 	std_logic_vector (sch_size-1 downto 0);
			w_sch_data_in_b	: in 	std_logic_vector (sch_size-1 downto 0);
			w_sch_addr_a		: out natural range 0 to address_size-1;
			w_sch_addr_b		: out natural range 0 to address_size-1;
			w_sch_wen_a			: out std_logic;
			w_sch_wen_b			: out std_logic;
			w_sch_sort			: out std_logic;
			w_sch_table_full	: in std_logic;
			w_sch_data_out_a	: out std_logic_vector (sch_size-1 downto 0);
			w_sch_data_out_b	: out std_logic_vector (sch_size-1 downto 0);
			
			--Interface to other components in Router
			n_vc_deq 			: out std_logic;
			n_vc_rnaSelI 		: out std_logic_vector (1 downto 0);		 
			n_vc_rnaSelO 		: out std_logic_vector (1 downto 0);		
			n_vc_rnaSelS		: out	std_logic_vector (1 downto 0);		
			n_vc_strq 			: out std_logic;									
			n_vc_status 		: in 	std_logic_vector (1 downto 0);
			n_invld_out			: out std_logic;
			n_invld_in			: in  std_logic;
			e_vc_deq 			: out std_logic;									
			e_vc_rnaSelI 		: out std_logic_vector (1 downto 0);		
			e_vc_rnaSelO 		: out std_logic_vector (1 downto 0);		 
			e_vc_rnaSelS		: out	std_logic_vector (1 downto 0);
			e_vc_strq 			: out std_logic;
			e_vc_status 		: in 	std_logic_vector (1 downto 0);
			e_invld_out			: out std_logic;
			e_invld_in			: in 	std_logic;
			s_vc_deq 			: out std_logic;							
			s_vc_rnaSelI 		: out std_logic_vector (1 downto 0); 
			s_vc_rnaSelO 		: out std_logic_vector (1 downto 0); 
			s_vc_rnaSelS		: out	std_logic_vector (1 downto 0);
			s_vc_strq 			: out std_logic;							
			s_vc_status 		: in 	std_logic_vector (1 downto 0);
			s_invld_out			: out std_logic;
			s_invld_in			: in  std_logic;
			w_vc_deq 			: out std_logic;
			w_vc_rnaSelI 		: out std_logic_vector (1 downto 0); 
			w_vc_rnaSelO 		: out std_logic_vector (1 downto 0); 
			w_vc_rnaSelS		: out	std_logic_vector (1 downto 0);
			w_vc_strq 			: out std_logic;
			w_vc_status 		: in 	std_logic_vector (1 downto 0);
			w_invld_out			: out std_logic;
			w_invld_in			: in  std_logic;
			n_CTRinFlg			: in  std_logic;
			n_CTRflg				: out std_logic;
			n_CtrlFlg			: in 	std_logic;
			n_DataFlg			: in  std_logic;
			n_arbEnq				: out std_logic;
			n_rnaCtrl			: in 	std_logic_vector(pkt_size downto 0);
			e_CTRinFlg			: in  std_logic;
			e_CTRflg				: out std_logic;
			e_CtrlFlg			: in 	std_logic;
			e_DataFlg			: in  std_logic;
			e_arbEnq				: out std_logic;
			e_rnaCtrl			: in 	std_logic_vector(pkt_size downto 0);
			s_CTRinFlg			: in  std_logic;
			s_CTRflg				: out std_logic;
			s_CtrlFlg			: in 	std_logic;
			s_DataFlg			: in  std_logic;
			s_arbEnq				: out std_logic;
			s_rnaCtrl			: in 	std_logic_vector(pkt_size downto 0);
			w_CTRinFlg			: in  std_logic;
			w_CTRflg				: out std_logic;
			w_CtrlFlg			: in 	std_logic;
			w_DataFlg			: in  std_logic;
			w_arbEnq				: out std_logic;
			w_rnaCtrl			: in 	std_logic_vector(pkt_size downto 0);
			sw_nSel				: out std_logic_vector(2 downto 0);
			sw_eSel				: out std_logic_vector(2 downto 0);
			sw_sSel				: out std_logic_vector(2 downto 0);
			sw_wSel				: out std_logic_vector(2 downto 0);
			sw_ejectSel			: out std_logic_vector(2 downto 0);
			sw_rnaCtFl			: in 	std_logic;
			sw_rnaCtDeq			: out std_logic;
			rna_ctrlPkt			: out std_logic_vector(pkt_size downto 0);
			injt_ctrlPkt		: in 	std_logic_vector (pkt_size downto 0);
			injt_dataGood		: out std_logic
		);
end ControlUnit;

architecture Behavioral of ControlUnit is
	type state_type is (start, north1, north2, north3, north4, north5, north6, north7, north8,
							  east1, east2, east3, east4, east5, east6, east7, east8,
							  south1, south2, south3, south4, south5, south6, south7, south8,
							  west1, west2, west3, west4, west5, west6, west7, west8,
							  injection1, injection2, injection3, injection4, injection5,injection6,
							  north_sw1, north_sw2, east_sw1, east_sw2, south_sw1, south_sw2, west_sw1, west_sw2,
							  injection_sw1);   -- State FSM
	
	signal state_north_handler: state_type;
	signal state_east_handler: state_type;
	signal state_south_handler: state_type;
	signal state_west_handler: state_type;
	signal state_injection_handler: state_type;
	signal state_scheduler_handler: state_type;
	signal state_switch_handler: state_type;
	
	signal ns_north_handler: state_type;
	signal ns_east_handler: state_type;
	signal ns_south_handler: state_type;
	signal ns_west_handler: state_type;
	signal ns_injection_handler: state_type;
	signal ns_scheduler_handler: state_type;
	signal ns_switch_handler: state_type;
	
	signal router_address 	: std_logic_vector(PID_WIDTH-1 downto 0);

	--Timer Related Signals
	signal globaltime			: std_logic_vector(31 downto 0);
	signal counter 			: std_logic_vector(31 downto 0);
	signal timeunit1 			: std_logic_vector(31 downto 0);
	signal timeunit2 			: std_logic_vector(31 downto 0);
	signal start_timer 		: std_logic;
	signal time_expired  	: std_logic;
	
	--Departure Itinerary
	signal scheduled_pkt_expires_in : std_logic_vector(31 downto 0);
	
	--Arrival Related Signals
	signal n_DpFlg				: std_logic;
	signal e_DpFlg				: std_logic;
	signal s_DpFlg				: std_logic;
	signal w_DpFlg				: std_logic;
	
	--WDT Related
	signal wdt_counter1 		: std_logic_vector(15 downto 0);
	signal wdt_elapsed 		: std_logic_vector(15 downto 0);
	signal wdt_expired 		: std_logic;
	signal wdt_expires_in   : std_logic_vector(15 downto 0);
	signal start_wdt_timer	: std_logic;
	
	--Switch Related
	signal sw_n_rna_ctrlPkt	: std_logic_vector(pkt_size downto 0);
	signal sw_e_rna_ctrlPkt	: std_logic_vector(pkt_size downto 0);
	signal sw_s_rna_ctrlPkt	: std_logic_vector(pkt_size downto 0);
	signal sw_w_rna_ctrlPkt	: std_logic_vector(pkt_size downto 0);
	
	signal sw_n_rna_toggle : std_logic;
	signal sw_e_rna_toggle : std_logic;
	signal sw_s_rna_toggle : std_logic;
	signal sw_w_rna_toggle : std_logic;
	
	signal sw_injt_pkt 		: std_logic_vector (pkt_size downto 0);
	signal sw_injt_toggle 	: std_logic;
	signal sw_injt_ack 		: std_logic;
	signal sw_n_rna_ack 		: std_logic;
	signal sw_e_rna_ack 		: std_logic;
	signal sw_s_rna_ack		: std_logic;
	signal sw_w_rna_ack		: std_logic;
	
	

	
begin

	--************************************************************************
	--globaltimer_process: This is the running timer (indefinitely)
	--************************************************************************
	globaltimer_process: process(clk, rst)
	begin
		
		if rst = '1' then
			globaltime <= std_logic_vector(to_unsigned(0, globaltime'length));
			timeunit1 <= std_logic_vector(to_unsigned(0, timeunit1'length));
		
		elsif rising_edge(clk) then
			timeunit1 <= timeunit1 + "00000000000000000000000000000001";
			if(timeunit1 = "0000000000000000000000111110") then
			--if(timeunit1 = "0000011000101010") then				-- 3052 periods = 30.518 us ~ 32.768 kHz (RTC)
				globaltime <= globaltime + "0000000000000001";
				timeunit1 <= "00000000000000000000000000000000";
			end if;
		end if;
	end process;


	--************************************************************************
	--timebase_process: 	Creates a "stopwatch" for establishing a timebase that
	--							the packet transfers process requires to ensure QoS.
	--************************************************************************
	timebase_process: process(clk, rst)
	begin
	
		if rst = '1' then
			counter <= std_logic_vector(to_unsigned(0, counter'length));
			time_expired <= '0';
			timeunit2 <= std_logic_vector(to_unsigned(0, timeunit2'length));
			
		elsif rising_edge(clk) then
			if(start_timer = '1' and time_expired = '0') then
				timeunit2 <= timeunit2 + "00000000000000000000000000000001";
				time_expired <= '0';
				if(timeunit2 = "00000000000000000000000000000110") then								-- was 1000 cycles 0000000000111110
					counter <= counter + "00000000000000000000000000000001";		--increment the counter by 1 tick
					if(counter = scheduled_pkt_expires_in) then
						counter <= "00000000000000000000000000000000";
						time_expired <= '1';
					end if;
					timeunit2 <= "00000000000000000000000000000000";
				end if;
			elsif(start_timer = '0' and time_expired = '1') then
				time_expired <= '0';
			end if;
		end if;
	end process;
	
	--************************************************************************
	--wdt_process: This process is an exclusive timer that executes up to 1000 times the period
	--************************************************************************
	wdt_process: process(clk, start_wdt_timer)
	begin
	
		if start_wdt_timer = '0' then
			wdt_counter1 <= std_logic_vector(to_unsigned(0, wdt_counter1'length));
			wdt_elapsed <= std_logic_vector(to_unsigned(0, wdt_elapsed'length));
			wdt_expired <= '0';
		
		elsif rising_edge(clk) and start_wdt_timer = '1' then
			wdt_counter1 <= wdt_counter1 + "0000000000000001";
			if(wdt_counter1 = "000000001110") then
				wdt_elapsed <= wdt_elapsed + "0000000000000001";
				wdt_counter1 <= "0000000000000000";
			end if;
			
			if(wdt_elapsed >= wdt_expires_in) then
				wdt_expired <= '1';
			else
				wdt_expired <= '0';
			end if;
			
		end if;
	end process;
	
	--************************************************************************
	--cpStateHandler_process: These processes below are responsible for assigning the next_state
	--************************************************************************
	process
	begin
		wait until rising_edge(clk);
		if rst = '1' then
			state_north_handler <= start;
			state_east_handler <= start;
			state_south_handler <= start;
			state_west_handler <= start;
			state_scheduler_handler <= start;
			state_switch_handler <= start;
		else
			state_north_handler <= ns_north_handler;
			state_east_handler <= ns_east_handler;
			state_south_handler <= ns_south_handler;
			state_west_handler <= ns_west_handler;
			state_scheduler_handler <= ns_scheduler_handler;
			state_switch_handler <= ns_switch_handler;
		end if;
	end process;
	
	--************************************************************************
	--north_handler: Handles all incoming packets (data/control) on north port
	--************************************************************************
	north_handler:process(state_north_handler)
	variable temp : std_logic_vector(1 downto 0);
	begin
		case state_north_handler is
				when start =>
					
					--Drive signals to default state
					n_CTRflg <= '0';
					n_arbEnq <= '0';
					
					n_rsv_wen_a <= '0';
					n_sch_wen_a	<= '0';
					sw_n_rna_toggle <= '0';
					
					ns_north_handler <= north1;
				when north1 =>
					--Control Packet Arrived?
					if(n_CtrlFlg = '1') then
						ns_north_handler <= north2;
					else
						ns_north_handler <= north4;
					end if;
				when north2 =>
					if(n_rsv_table_full = '0') then
						sw_n_rna_ctrlPkt <= n_rnaCtrl;		--Make copy of packet
						ns_north_handler <= north3;
					else
						ns_north_handler <= north4;			--Table is full. Try again later
					end if;
				when north3 =>	
					--Reserve and schedule the incoming control packet
					n_CTRflg <= '1', '0' after 1 ns;					--Ack back to src.
					
					--Write bits to rsv_data_out
					case n_rnaCtrl(12 downto 11) is
						when "00" =>
							n_rsv_data_out_a <= n_rnaCtrl(15 downto 13);
						when "01" =>
							n_rsv_data_out_a <= n_rnaCtrl(18 downto 16);
						when "10" =>
							n_rsv_data_out_a <= n_rnaCtrl(21 downto 19);
						when "11" =>
							n_rsv_data_out_a <= n_rnaCtrl(24 downto 22);
						when others =>
							null;
					end case;
					
					--Write bits to sch_packet
					n_sch_data_out_a <= (globaltime + n_rnaCtrl(pkt_size downto 25));

					--Send to reservation table
					n_rsv_addr_a <= conv_integer(n_rnaCtrl(10 downto 3));
					n_sch_addr_a <= conv_integer(n_rnaCtrl(10 downto 3));
					n_rsv_wen_a <= '1';
					n_sch_wen_a <= '1';
					
					--Update count
					temp := sw_n_rna_ctrlPkt(12 downto 11) + 1;		--Update count
					sw_n_rna_ctrlPkt(12 downto 11) <= temp;
					
					ns_north_handler <= north4;
					
				when north4 =>
					--Reset signals
					n_rsv_wen_a <= '0';
					n_sch_wen_a <= '0';
				
					--Forward the Packet by checking routing table first			
					sw_n_rna_toggle <= '1';
					ns_north_handler <= north5;
				
				when north5 =>
					--Data Packet Arrived?
					if(n_DataFlg = '1') then
						ns_north_handler <= north6;
					else
						ns_north_handler <= north1;
					end if;
				when north6 =>
					--Grab reservation table details
					n_rsv_addr_a <= conv_integer(n_rnaCtrl(10 downto 3));
					
					ns_north_handler <= north7;
				when north7 =>	
					--Control VCC
					case n_rsv_data_in_a(2 downto 0) is
						when "001" =>
							n_vc_rnaSelI <= "00";			--East
						when "010" =>
							n_vc_rnaSelI <= "01";			--South
						when "011" =>
							n_vc_rnaSelI <= "10";			--West
						when "111" =>
							n_vc_rnaSelI <= "11";			--Ejection
						when others =>
							null;
					end case;
					
					--Acknowledge
					n_CTRflg <= '1';
					n_arbEnq <= '1';
					ns_north_handler <= north8;
				when north8 =>
					n_CTRflg <= '0';
					n_arbEnq <= '0';
					ns_north_handler <= north1;
				when others =>
					ns_north_handler <= north1;
			end case;
	end process;

	--************************************************************************
	--east_handler: Handles all incoming packets (data/control) on east port
	--************************************************************************
	east_handler:process(state_east_handler)
	variable temp : std_logic_vector(1 downto 0);
	begin
		case state_east_handler is
				when start =>
					
					--Drive signals to default state
					e_CTRflg <= '0';
					e_arbEnq <= '0';
					
					e_rsv_wen_a <= '0';
					e_sch_wen_a	<= '0';
					sw_e_rna_toggle <= '0';
					
					ns_east_handler <= east1;
				when east1 =>
					--Control Packet Arrived?
					if(e_CtrlFlg = '1') then
						ns_east_handler <= east2;
					else
						ns_east_handler <= east4;
					end if;
				when east2 =>
					if(e_rsv_table_full = '0') then
						sw_e_rna_ctrlPkt <= e_rnaCtrl;
						ns_east_handler <= east3;
					else
						ns_east_handler <= east4;			--Table is full. Try again later
					end if;
				when east3 =>	
					--Reserve and schedule the incoming control packet
					e_CTRflg <= '1', '0' after 1 ns;					--Ack back to src.
					
					--Write bits to rsv_data_out
					case e_rnaCtrl(12 downto 11) is
						when "00" =>
							e_rsv_data_out_a <= e_rnaCtrl(15 downto 13);
						when "01" =>
							e_rsv_data_out_a <= e_rnaCtrl(18 downto 16);
						when "10" =>
							e_rsv_data_out_a <= e_rnaCtrl(21 downto 19);
						when "11" =>
							e_rsv_data_out_a <= e_rnaCtrl(24 downto 22);
						when others =>
							null;
					end case;
					
					--Write bits to sch_packet
					e_sch_data_out_a <= (globaltime + e_rnaCtrl(pkt_size downto 25));

					--Send to reservation table
					e_rsv_addr_a <= conv_integer(e_rnaCtrl(10 downto 3));
					e_sch_addr_a <= conv_integer(e_rnaCtrl(10 downto 3));
					e_rsv_wen_a <= '1';
					e_sch_wen_a <= '1';
					
					--Update count
					temp := sw_e_rna_ctrlPkt(12 downto 11) + 1;		--Update count
					sw_e_rna_ctrlPkt(12 downto 11) <= temp;
					
					ns_east_handler <= east4;
				when east4 =>
					--Reset signals
					e_rsv_wen_a <= '0';
					e_sch_wen_a <= '0';
					
					--Forward the Packet	
					sw_e_rna_toggle <= '1';
					
					ns_east_handler <= east5;
				
				when east5 =>
					--Data Packet Arrived?
					if(e_DataFlg = '1') then
						ns_east_handler <= east6;
					else
						ns_east_handler <= east1;
					end if;
				when east6 =>
					--Grab reservation table details
					e_rsv_addr_a <= conv_integer(e_rnaCtrl(10 downto 3));
					
					ns_east_handler <= east7;
				when east7 =>	
					--Control VCC
					case e_rsv_data_in_a(2 downto 0) is
						when "000" =>
							e_vc_rnaSelI <= "00";			--North
						when "010" =>
							e_vc_rnaSelI <= "01";			--South
						when "011" =>
							e_vc_rnaSelI <= "10";			--West
						when "111" =>
							e_vc_rnaSelI <= "11";			--Ejection
						when others =>
							null;
					end case;
					
					--Acknowledge
					e_CTRflg <= '1';
					e_arbEnq <= '1';
					ns_east_handler <= east8;
				when east8 =>
					e_CTRflg <= '0';
					e_arbEnq <= '0';
					ns_east_handler <= east1;
				when others =>
					ns_east_handler <= east1;
			end case;
	end process;
	
	--************************************************************************
	--south_handler: Handles all incoming packets (data/control) on south port
	--************************************************************************
	south_cp_handler:process(state_south_handler)
	variable temp : std_logic_vector(1 downto 0);
	begin
		case state_south_handler is
				when start =>
					
					--Drive signals to default state
					s_CTRflg <= '0';
					s_arbEnq <= '0';
					
					s_rsv_wen_a <= '0';
					s_sch_wen_a	<= '0';
					sw_s_rna_toggle <= '0';
					
					ns_south_handler <= south1;
				when south1 =>
					--Control Packet Arrived?
					if(s_CtrlFlg = '1') then
						ns_south_handler <= south2;
					else
						ns_south_handler <= south4;
					end if;
				when south2 =>
					if(s_rsv_table_full = '0') then
						sw_s_rna_ctrlPkt <= s_rnaCtrl;
						ns_south_handler <= south3;
					else
						ns_south_handler <= south4;			--Table is full. Try again later
					end if;
				when south3 =>	
					--Reserve and schedule the incoming control packet
					s_CTRflg <= '1', '0' after 1 ns;					--Ack back to src.
					
					--Write bits to rsv_data_out
					case s_rnaCtrl(12 downto 11) is
						when "00" =>
							s_rsv_data_out_a <= s_rnaCtrl(15 downto 13);
						when "01" =>
							s_rsv_data_out_a <= s_rnaCtrl(18 downto 16);
						when "10" =>
							s_rsv_data_out_a <= s_rnaCtrl(21 downto 19);
						when "11" =>
							s_rsv_data_out_a <= s_rnaCtrl(24 downto 22);
						when others =>
							null;
					end case;
					
					--Write bits to sch_packet
					s_sch_data_out_a <= (globaltime + s_rnaCtrl(pkt_size downto 25));

					--Send to reservation table
					s_rsv_addr_a <= conv_integer(s_rnaCtrl(10 downto 3));
					s_sch_addr_a <= conv_integer(s_rnaCtrl(10 downto 3));
					s_rsv_wen_a <= '1';
					s_sch_wen_a <= '1';
					
					--Update count
					temp := sw_s_rna_ctrlPkt(12 downto 11) + 1;		--Update count
					sw_s_rna_ctrlPkt(12 downto 11) <= temp;
					
					ns_south_handler <= south4;
				when south4 =>
					--Reset signals
					s_rsv_wen_a <= '0';
					s_sch_wen_a <= '0';
				
					--Forward the Packet
					sw_s_rna_toggle <= '1';
					
					ns_south_handler <= south5;
				
				when south5 =>
					--Data Packet Arrived?
					if(s_DataFlg = '1') then
						ns_south_handler <= south6;
					else
						ns_south_handler <= south1;
					end if;
				when south6 =>
					--Grab reservation table details
					s_rsv_addr_a <= conv_integer(s_rnaCtrl(10 downto 3));
					
					ns_south_handler <= south7;
				when south7 =>	
					--Control VCC
					case s_rsv_data_in_a(2 downto 0) is
						when "000" =>
							s_vc_rnaSelI <= "00";			--North
						when "001" =>
							s_vc_rnaSelI <= "01";			--East
						when "011" =>
							s_vc_rnaSelI <= "10";			--West
						when "111" =>
							s_vc_rnaSelI <= "11";			--Ejection
						when others =>
							null;
					end case;
					
					--Acknowledge
					s_CTRflg <= '1';
					s_arbEnq <= '1';
					ns_south_handler <= south8;
				when south8 =>
					s_CTRflg <= '0';
					s_arbEnq <= '0';
					ns_south_handler <= south1;
				when others =>
					ns_south_handler <= south1;
			end case;
	end process;
	
	--************************************************************************
	--west_handler: Handles all incoming packets (data/control) on west port
	--************************************************************************
	west_cp_handler:process(state_west_handler)
	variable temp : std_logic_vector(1 downto 0);
	begin
		case state_west_handler is
				when start =>
					
					--Drive signals to default state
					w_CTRflg <= '0';
					w_arbEnq <= '0';
					
					w_rsv_wen_a <= '0';
					w_sch_wen_a	<= '0';
					sw_w_rna_toggle <= '0';
					
					ns_west_handler <= west1;
				when west1 =>
					--Control Packet Arrived?
					if(w_CtrlFlg = '1') then
						ns_west_handler <= west2;
					else
						ns_west_handler <= west4;
					end if;
				when west2 =>
					if(w_rsv_table_full = '0') then
						sw_w_rna_ctrlPkt <= w_rnaCtrl;
						ns_west_handler <= west3;
					else
						ns_west_handler <= west4;			--Table is full. Try again later
					end if;
				when west3 =>	
					--Reserve and schedule the incoming control packet
					w_CTRflg <= '1', '0' after 1 ns;					--Ack back to src.
					
					--Write bits to rsv_data_out
					case w_rnaCtrl(12 downto 11) is
						when "00" =>
							w_rsv_data_out_a <= w_rnaCtrl(15 downto 13);
						when "01" =>
							w_rsv_data_out_a <= w_rnaCtrl(18 downto 16);
						when "10" =>
							w_rsv_data_out_a <= w_rnaCtrl(21 downto 19);
						when "11" =>
							w_rsv_data_out_a <= w_rnaCtrl(24 downto 22);
						when others =>
							null;
					end case;
					
					--Write bits to sch_packet
					w_sch_data_out_a <= (globaltime + w_rnaCtrl(pkt_size downto 25));

					--Send to reservation table
					w_rsv_addr_a <= conv_integer(w_rnaCtrl(10 downto 3));
					w_sch_addr_a <= conv_integer(w_rnaCtrl(10 downto 3));
					w_rsv_wen_a <= '1';
					w_sch_wen_a <= '1';
					
					--Update count
					temp := sw_w_rna_ctrlPkt(12 downto 11) + 1;		--Update count
					sw_w_rna_ctrlPkt(12 downto 11) <= temp;
					
					ns_west_handler <= west4;
				when west4 =>
					--Reset signals
					w_rsv_wen_a <= '0';
					w_sch_wen_a <= '0';
				
					--Forward the Packet
					sw_w_rna_toggle <= '1';
					
					ns_west_handler <= west5;
				when west5 =>
					--Data Packet Arrived?
					if(w_DataFlg = '1') then
						ns_west_handler <= west6;
					else
						ns_west_handler <= west1;
					end if;
				when west6 =>
					--Grab reservation table details
					w_rsv_addr_a <= conv_integer(w_rnaCtrl(10 downto 3));
					
					ns_west_handler <= west7;
				when west7 =>	
					--Control VCC
					case w_rsv_data_in_a(2 downto 0) is
						when "000" =>
							w_vc_rnaSelI <= "00";			--North
						when "001" =>
							w_vc_rnaSelI <= "01";			--East
						when "010" =>
							w_vc_rnaSelI <= "10";			--South
						when "111" =>
							w_vc_rnaSelI <= "11";			--Ejection
						when others =>
							null;
					end case;
					
					--Acknowledge
					w_CTRflg <= '1';
					w_arbEnq <= '1';
					ns_west_handler <= west8;
				when west8 =>
					w_CTRflg <= '0';
					w_arbEnq <= '0';
					ns_west_handler <= west1;
				when others =>
					ns_west_handler <= west1;
			end case;
	end process;
	
	--************************************************************************
	--injection_handler: Handles all incoming packets (data/control) on injection port
	--************************************************************************
	injection_handler:process(state_injection_handler)
	begin
		case state_injection_handler is
				when start =>
					sw_injt_toggle <= '0';
				
					ns_injection_handler <= injection1;
				when injection1 =>
					--Control Packet Arrived?
					if(sw_rnaCtFl = '1') then
						ns_injection_handler <= injection2;
					else
						ns_injection_handler <= injection1;
					end if;
				when injection2 =>
					if(injt_ctrlPkt(0) = '1') then
						ns_injection_handler <= injection3;	--Control Packet
					else
						ns_injection_handler <= injection5;	--Data Packet
					end if;
				when injection3 =>
					case injt_ctrlPkt(2 downto 1) is
						when "00" =>
							ns_injection_handler <= injection5;	-- Condition: Normal Packet
						when "01" =>
							ns_injection_handler <= injection4;	-- Condition: PE is re/assigning addresses
						when others =>
							sw_rnaCtDeq <= '1', '0' after 1 ns;		-- dequeue from FIFO
							ns_injection_handler <= injection1;	-- Condition: Unknown, move to next state. (was timer_check1)
					end case;
				when injection4 =>
					router_address <= injt_ctrlPkt(28 downto 25);
					sw_rnaCtDeq <= '1', '0' after 1 ns;		-- dequeue from FIFO
					ns_injection_handler <= injection1;
				when injection5 =>
					--Forward packet
					sw_injt_pkt <= injt_ctrlPkt;
					
					sw_injt_toggle <= '1';
					
					ns_injection_handler <= injection6;
				when injection6 =>
					if(sw_injt_ack = '1') then
						sw_rnaCtDeq <= '1', '0' after 1 ns;
						ns_injection_handler <= injection1;
					else
						ns_injection_handler <= injection5;	--Keep trying (might need WDT eventually)
					end if;
				when others =>
					ns_injection_handler <= injection1;
			end case;
	end process;
	
		
	--scheduler_handler - Handles all scheduling related tasks
	scheduler_handler:process(state_scheduler_handler)
	begin
	end process;
	
	--switch_handler - Handles all switch related tasks
	switch_handler:process(state_switch_handler)
		variable count : std_logic_vector(1 downto 0);
		variable direction : std_logic_vector(2 downto 0);
	begin		
		case state_switch_handler is
			when start =>
				sw_n_rna_ack <= '0';
				sw_e_rna_ack <= '0';
				sw_s_rna_ack <= '0';
				sw_w_rna_ack <= '0';
				ns_switch_handler <= north_sw1;
			when north_sw1 =>
				if(sw_n_rna_toggle = '1') then
					sw_n_rna_ack <= '0';
					count:= sw_n_rna_ctrlPkt(12 downto 11);	--Get next hop
					case count is
						when "00" =>	
							direction := sw_n_rna_ctrlPkt(15 downto 13);
						when "01" =>
							direction := sw_n_rna_ctrlPkt(18 downto 16);
						when "10" =>
							direction := sw_n_rna_ctrlPkt(21 downto 19);
						when "11" =>
							direction := sw_n_rna_ctrlPkt(24 downto 22);
						when others =>
							null;
					end case;
					
					ns_switch_handler <= north_sw2;
				else
					ns_switch_handler <= east_sw1;
				end if;
			when north_sw2 =>
				--Send control packet
				rna_ctrlPkt <= sw_n_rna_ctrlPkt;
					
				--Configure the switch
				case direction is
					when "000" =>
						sw_nSel <= "111";			-- "00" North FIFO								
					when "001" =>
						sw_eSel <= "111";			-- "01" East FIFO
					when "010" =>
						sw_sSel <= "111";			-- "10" South FIFO
					when "011" =>
						sw_wSel <= "111";			-- "11" Ejection FIFO
					when others =>	
						null;
				end case;
				
				--Ack
				sw_n_rna_ack <= '1';
				ns_switch_handler <= east_sw1;
			when east_sw1 =>
				if(sw_e_rna_toggle = '1') then
					sw_e_rna_ack <= '0';
					count:= sw_e_rna_ctrlPkt(12 downto 11);	--Get next hop
					case count is
						when "00" =>	
							direction := sw_e_rna_ctrlPkt(15 downto 13);
						when "01" =>
							direction := sw_e_rna_ctrlPkt(18 downto 16);
						when "10" =>
							direction := sw_e_rna_ctrlPkt(21 downto 19);
						when "11" =>
							direction := sw_e_rna_ctrlPkt(24 downto 22);
						when others =>
							null;
					end case;

					ns_switch_handler <= east_sw2;
				else
					ns_switch_handler <= south_sw1;
				end if;
			when east_sw2 =>
				--Send control packet
				rna_ctrlPkt <= sw_e_rna_ctrlPkt;
					
				--Configure the switch
				case direction is
					when "000" =>
						sw_nSel <= "111";			-- "00" North FIFO								
					when "001" =>
						sw_eSel <= "111";			-- "01" East FIFO
					when "010" =>
						sw_sSel <= "111";			-- "10" South FIFO
					when "011" =>
						sw_wSel <= "111";			-- "11" Ejection FIFO
					when others =>	
						null;
				end case;
				
				--Ack
				sw_e_rna_ack <= '1';
				ns_switch_handler <= south_sw1;
			when south_sw1 =>
				if(sw_s_rna_toggle = '1') then
					sw_s_rna_ack <= '0';
					count:= sw_s_rna_ctrlPkt(12 downto 11);	--Get next hop
					case count is
						when "00" =>	
							direction := sw_s_rna_ctrlPkt(15 downto 13);
						when "01" =>
							direction := sw_s_rna_ctrlPkt(18 downto 16);
						when "10" =>
							direction := sw_s_rna_ctrlPkt(21 downto 19);
						when "11" =>
							direction := sw_s_rna_ctrlPkt(24 downto 22);
						when others =>
							null;
					end case;

					ns_switch_handler <= south_sw2;
				else
					ns_switch_handler <= west_sw1;
				end if;
			when south_sw2 =>
				--Send control packet
				rna_ctrlPkt <= sw_s_rna_ctrlPkt;
					
				--Configure the switch
				case direction is
					when "000" =>
						sw_nSel <= "111";			-- "00" North FIFO								
					when "001" =>
						sw_eSel <= "111";			-- "01" East FIFO
					when "010" =>
						sw_sSel <= "111";			-- "10" South FIFO
					when "011" =>
						sw_wSel <= "111";			-- "11" Ejection FIFO
					when others =>	
						null;
				end case;
				
				--Ack
				sw_s_rna_ack <= '1';
				ns_switch_handler <= west_sw1;
			when west_sw1 =>
				if(sw_w_rna_toggle = '1') then
					sw_w_rna_ack <= '0';
					count:= sw_w_rna_ctrlPkt(12 downto 11);	--Get next hop
					case count is
						when "00" =>	
							direction := sw_w_rna_ctrlPkt(15 downto 13);
						when "01" =>
							direction := sw_w_rna_ctrlPkt(18 downto 16);
						when "10" =>
							direction := sw_w_rna_ctrlPkt(21 downto 19);
						when "11" =>
							direction := sw_w_rna_ctrlPkt(24 downto 22);
						when others =>
							null;
					end case;

					ns_switch_handler <= west_sw2;
				else
					ns_switch_handler <= injection_sw1;
				end if;
			when west_sw2 =>
				--Send control packet
				rna_ctrlPkt <= sw_w_rna_ctrlPkt;
					
				--Configure the switch
				case direction is
					when "000" =>
						sw_nSel <= "111";			-- "00" North FIFO								
					when "001" =>
						sw_eSel <= "111";			-- "01" East FIFO
					when "010" =>
						sw_sSel <= "111";			-- "10" South FIFO
					when "011" =>
						sw_wSel <= "111";			-- "11" Ejection FIFO
					when others =>	
						null;
				end case;
				
				--Ack
				sw_w_rna_ack <= '1';
				ns_switch_handler <= injection_sw1;
			when injection_sw1 =>
				ns_switch_handler <= north_sw1;
				
			when others =>
				ns_switch_handler <= north_sw1;
		end case;
	end process;
	
end Behavioral;
