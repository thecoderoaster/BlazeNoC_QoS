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
			n_rsv_addr_a		: out natural range 0 to 2**address_size-1;
			n_rsv_addr_b		: out natural range 0 to 2**address_size-1;
			n_rsv_wen_a			: out std_logic;
			n_rsv_wen_b			: out std_logic;
			n_rsv_table_full	: in 	std_logic;
			n_rsv_table_purge	: out std_logic;
			n_rsv_data_out_a	: out std_logic_vector (rsv_size-1 downto 0);
			n_rsv_data_out_b	: out std_logic_vector (rsv_size-1 downto 0);
			n_sch_data_in_a	: in 	std_logic_vector (sch_size-1 downto 0);
			n_sch_data_in_b	: in 	std_logic_vector (sch_size-1 downto 0);
			n_sch_addr_a		: out natural range 0 to 2**address_size-1;
			n_sch_addr_b		: out natural range 0 to 2**address_size-1;
			n_sch_wen_a			: out std_logic;
			n_sch_wen_b			: out std_logic;
			n_sch_table_full	: in std_logic;
			n_sch_table_purge	: out std_logic;
			n_sch_table_count	: in natural range 0 to 2**address_size-1;
			n_sch_data_out_a	: out std_logic_vector (sch_size-1 downto 0);
			n_sch_data_out_b	: out std_logic_vector (sch_size-1 downto 0);
			
			--East Set
			e_rsv_data_in_a	: in 	std_logic_vector (rsv_size-1 downto 0);
			e_rsv_data_in_b	: in 	std_logic_vector (rsv_size-1 downto 0);
			e_rsv_addr_a		: out natural range 0 to 2**address_size-1;
			e_rsv_addr_b		: out natural range 0 to 2**address_size-1;
			e_rsv_wen_a			: out std_logic;
			e_rsv_wen_b			: out std_logic;
			e_rsv_table_full	: in 	std_logic;
			e_rsv_table_purge	: out std_logic;
			e_rsv_data_out_a	: out std_logic_vector (rsv_size-1 downto 0);
			e_rsv_data_out_b	: out std_logic_vector (rsv_size-1 downto 0);
			e_sch_data_in_a	: in 	std_logic_vector (sch_size-1 downto 0);
			e_sch_data_in_b	: in 	std_logic_vector (sch_size-1 downto 0);
			e_sch_addr_a		: out natural range 0 to 2**address_size-1;
			e_sch_addr_b		: out natural range 0 to 2**address_size-1;
			e_sch_wen_a			: out std_logic;
			e_sch_wen_b			: out std_logic;
			e_sch_table_full	: in std_logic;
			e_sch_table_purge	: out std_logic;
			e_sch_table_count	: in natural range 0 to 2**address_size-1;
			e_sch_data_out_a	: out std_logic_vector (sch_size-1 downto 0);
			e_sch_data_out_b	: out std_logic_vector (sch_size-1 downto 0);
			
			--South Set
			s_rsv_data_in_a	: in 	std_logic_vector (rsv_size-1 downto 0);
			s_rsv_data_in_b	: in 	std_logic_vector (rsv_size-1 downto 0);
			s_rsv_addr_a		: out natural range 0 to 2**address_size-1;
			s_rsv_addr_b		: out natural range 0 to 2**address_size-1;
			s_rsv_wen_a			: out std_logic;
			s_rsv_wen_b			: out std_logic;
			s_rsv_table_full	: in 	std_logic;
			s_rsv_table_purge	: out std_logic;
			s_rsv_data_out_a	: out std_logic_vector (rsv_size-1 downto 0);
			s_rsv_data_out_b	: out std_logic_vector (rsv_size-1 downto 0);
			s_sch_data_in_a	: in 	std_logic_vector (sch_size-1 downto 0);
			s_sch_data_in_b	: in 	std_logic_vector (sch_size-1 downto 0);
			s_sch_addr_a		: out natural range 0 to 2**address_size-1;
			s_sch_addr_b		: out natural range 0 to 2**address_size-1;
			s_sch_wen_a			: out std_logic;
			s_sch_wen_b			: out std_logic;
			s_sch_table_full	: in std_logic;
			s_sch_table_purge	: out std_logic;
			s_sch_table_count	: in natural range 0 to 2**address_size-1;
			s_sch_data_out_a	: out std_logic_vector (sch_size-1 downto 0);
			s_sch_data_out_b	: out std_logic_vector (sch_size-1 downto 0);
			
			--West Set
			w_rsv_data_in_a	: in 	std_logic_vector (rsv_size-1 downto 0);
			w_rsv_data_in_b	: in 	std_logic_vector (rsv_size-1 downto 0);
			w_rsv_addr_a		: out natural range 0 to 2**address_size-1;
			w_rsv_addr_b		: out natural range 0 to 2**address_size-1;
			w_rsv_wen_a			: out std_logic;
			w_rsv_wen_b			: out std_logic;
			w_rsv_table_full	: in 	std_logic;
			w_rsv_table_purge	: out std_logic;
			w_rsv_data_out_a	: out std_logic_vector (rsv_size-1 downto 0);
			w_rsv_data_out_b	: out std_logic_vector (rsv_size-1 downto 0);
			w_sch_data_in_a	: in 	std_logic_vector (sch_size-1 downto 0);
			w_sch_data_in_b	: in 	std_logic_vector (sch_size-1 downto 0);
			w_sch_addr_a		: out natural range 0 to 2**address_size-1;
			w_sch_addr_b		: out natural range 0 to 2**address_size-1;
			w_sch_wen_a			: out std_logic;
			w_sch_wen_b			: out std_logic;
			w_sch_table_full	: in std_logic;
			w_sch_table_purge	: out std_logic;
			w_sch_table_count	: in natural range 0 to 2**address_size-1;
			w_sch_data_out_a	: out std_logic_vector (sch_size-1 downto 0);
			w_sch_data_out_b	: out std_logic_vector (sch_size-1 downto 0);
			
			--Interface to other components in Router
			n_vc_deq 			: out std_logic;
			n_vc_rnaSelI 		: out std_logic_vector (1 downto 0);		 
			n_vc_rnaSelO 		: out std_logic_vector (1 downto 0);		
			n_vc_rnaSelS		: out	std_logic_vector (1 downto 0);		
			n_vc_strq 			: out std_logic;
			n_vc_circEn			: out std_logic;
			n_vc_circSel		: out std_logic_vector(1 downto 0);
			n_vc_directEnq		: out std_logic;			
			n_vc_status 		: in 	std_logic_vector (1 downto 0);
			n_invld_out			: out std_logic;
			n_invld_in			: in  std_logic;
			e_vc_deq 			: out std_logic;									
			e_vc_rnaSelI 		: out std_logic_vector (1 downto 0);		
			e_vc_rnaSelO 		: out std_logic_vector (1 downto 0);		 
			e_vc_rnaSelS		: out	std_logic_vector (1 downto 0);
			e_vc_strq 			: out std_logic;
			e_vc_circEn			: out std_logic;
			e_vc_circSel		: out std_logic_vector(1 downto 0);
			e_vc_directEnq		: out std_logic;
			e_vc_status 		: in 	std_logic_vector (1 downto 0);
			e_invld_out			: out std_logic;
			e_invld_in			: in 	std_logic;
			s_vc_deq 			: out std_logic;							
			s_vc_rnaSelI 		: out std_logic_vector (1 downto 0); 
			s_vc_rnaSelO 		: out std_logic_vector (1 downto 0); 
			s_vc_rnaSelS		: out	std_logic_vector (1 downto 0);
			s_vc_strq 			: out std_logic;
			s_vc_circEn			: out std_logic;
			s_vc_circSel		: out std_logic_vector(1 downto 0);
			s_vc_directEnq		: out	std_logic;			
			s_vc_status 		: in 	std_logic_vector (1 downto 0);
			s_invld_out			: out std_logic;
			s_invld_in			: in  std_logic;
			w_vc_deq 			: out std_logic;
			w_vc_rnaSelI 		: out std_logic_vector (1 downto 0); 
			w_vc_rnaSelO 		: out std_logic_vector (1 downto 0); 
			w_vc_rnaSelS		: out	std_logic_vector (1 downto 0);
			w_vc_strq 			: out std_logic;
			w_vc_circEn			: out std_logic;
			w_vc_circSel		: out std_logic_vector(1 downto 0);
			w_vc_directEnq		: out std_logic;
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
	type state_type is (start, wait_state,
							  north1, north2, north3, north4, north5, north6, north7, north8, north9, north10, north11,
							  east1, east2, east3, east4, east5, east6, east7, east8, east9, east10, east11,
							  south1, south2, south3, south4, south5, south6, south7, south8, south9, south10, south11,
							  west1, west2, west3, west4, west5, west6, west7, west8, west9, west10, west11,
							  injection1, injection2, injection3, injection4, injection5,
							  north_sw1, north_sw2, north_sw3, north_sw4,
							  east_sw1, east_sw2, east_sw3, east_sw4,
							  south_sw1, south_sw2, south_sw3, south_sw4,
							  west_sw1, west_sw2, west_sw3, west_sw4,
							  injection_sw1, injection_sw2, injection_sw3, injection_sw4,
							  depart_w_sw1, depart_w_sw2, depart_w_sw3, depart_w_sw4, depart_w_sw5,
							  sort1, sort2, sort3, sort4, sort5, sort6, sort7,
							  schedule1, schedule2, schedule3, schedule4, schedule5, schedule6, schedule7, schedule8, schedule9);   -- State FSM
	
	signal state_north_handler: state_type;
	signal state_east_handler: state_type;
	signal state_south_handler: state_type;
	signal state_west_handler: state_type;
	signal state_injection_handler: state_type;
	signal state_scheduler_handler: state_type;
	signal state_switch_handler: state_type;
	signal state_west_sorting_handler: state_type;
	signal state_w_scheduler_handler: state_type;
	
	signal ns_north_handler: state_type;
	signal ns_east_handler: state_type;
	signal ns_south_handler: state_type;
	signal ns_west_handler: state_type;
	signal ns_injection_handler: state_type;
	signal ns_scheduler_handler: state_type;
	signal ns_switch_handler: state_type;
	signal ns_west_sorting_handler: state_type;
	signal ns_w_scheduler_handler: state_type;
	
	signal router_address 	: std_logic_vector(PID_WIDTH-1 downto 0);

	--Timer Related Signals
	signal globaltime			: std_logic_vector(31 downto 0);
	signal timeunit1 			: std_logic_vector(31 downto 0);
	signal timeunit2 			: std_logic_vector(31 downto 0);
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
	
	--Port Signal Handler Related
	signal n_rst				: std_logic;
	signal n_pkt_in_flg_set : std_logic;
	signal e_rst				: std_logic;
	signal e_pkt_in_flg_set : std_logic;
	signal s_rst				: std_logic;
	signal s_pkt_in_flg_set : std_logic;
	signal w_rst				: std_logic;
	signal w_pkt_in_flg_set : std_logic;
	signal i_rst				: std_logic;
	signal i_pkt_in_flg_set : std_logic;
	
	--Signal synchronization
	signal n_sync_rst			: std_logic;
	signal n_sync_signal		: std_logic;
	signal e_sync_rst			: std_logic;
	signal e_sync_signal		: std_logic;
	signal s_sync_rst			: std_logic;
	signal s_sync_signal		: std_logic;
	signal w_sync_rst			: std_logic;
	signal w_sync_signal		: std_logic;
	
	--Scheduling Related
	signal w_index 					: natural range 0 to 2**address_size;
	signal w_next_sch_job_midpid 	: natural range 0 to 2**address_size-1;
	signal w_next_sch_job_time		: std_logic_vector(sch_size-1 downto 0);	
	signal w_purge_sch_job			: std_logic;
	signal w_pktprg_rst				: std_logic;
	signal w_pktprg_signal			: std_logic;
	signal w_purge_midpid			: natural range 0 to 2**address_size-1;
	signal w_midgid_scheduled		: natural range 0 to 2**address_size-1;
	signal w_new_job_ready			: std_logic;
	signal w_jobrdy_rst				: std_logic;
	signal w_jobrdy_signal			: std_logic;
	signal w_request_next_job		: std_logic;
	signal w_next_sch_job_valid 	: std_logic;
	signal w_current_job_expired 	: std_logic;
	signal w_pkt_expires_in			: std_logic_vector(sch_size-1 downto 0);
	signal w_dpkt_arrived			: std_logic;
	signal w_pktarr_rst				: std_logic;
	signal w_pktarr_signal			: std_logic;
	signal w_departed_ack			: std_logic;
	signal w_start_timer 			: std_logic;
	

	--Switch Related
	signal sw_n_rna_ctrlPkt	: std_logic_vector(pkt_size downto 0);
	signal sw_e_rna_ctrlPkt	: std_logic_vector(pkt_size downto 0);
	signal sw_s_rna_ctrlPkt	: std_logic_vector(pkt_size downto 0);
	signal sw_w_rna_ctrlPkt	: std_logic_vector(pkt_size downto 0);
	
	signal sw_n_rna_toggle : std_logic;
	signal sw_e_rna_toggle : std_logic;
	signal sw_s_rna_toggle : std_logic;
	signal sw_w_rna_toggle : std_logic;
	
	signal sw_w_depart_toggle : std_logic;
	
	signal sw_injt_pkt 		: std_logic_vector (pkt_size downto 0);
	signal sw_injt_toggle 	: std_logic;
	signal sw_injt_ack 		: std_logic;
	signal sw_n_rna_ack 		: std_logic;
	signal sw_e_rna_ack 		: std_logic;
	signal sw_s_rna_ack		: std_logic;
	signal sw_w_rna_ack		: std_logic;
	
	signal sw_n_count			: std_logic_vector (1 downto 0);
	signal sw_e_count			: std_logic_vector (1 downto 0);
	signal sw_s_count			: std_logic_vector (1 downto 0);
	signal sw_w_count			: std_logic_vector (1 downto 0);
	

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
				globaltime <= globaltime + "00000000000000000000000000000001";
				timeunit1 <= "00000000000000000000000000000000";
			end if;
		end if;
	end process;


	--************************************************************************
	--w_timebase_process: 	Creates a "stopwatch" for establishing a timebase that
	--							the packet transfers process requires to ensure QoS.
	--************************************************************************
	w_timebase_process: process(clk, rst)
		variable counter 			: std_logic_vector(31 downto 0);
		variable timeunit			: std_logic_vector(31 downto 0);
		variable expires_in		: std_logic_vector(31 downto 0);
	begin
	
		if rst = '1' then
			counter := std_logic_vector(to_unsigned(0, counter'length));
			timeunit := std_logic_vector(to_unsigned(0, timeunit'length));
			w_current_job_expired <= '0';
			
		elsif rising_edge(clk) then
			if(w_start_timer = '1' and w_current_job_expired = '0') then
				timeunit := timeunit + "00000000000000000000000000000001";
				if(timeunit = "00000000000000000000000000000110") then								-- was 1000 cycles 0000000000111110
					counter := counter + "00000000000000000000000000000001";		--increment the counter by 1 tick
					if(counter = w_pkt_expires_in) then
						counter := "00000000000000000000000000000000";
						w_current_job_expired <= '1';
					else
						timeunit := "00000000000000000000000000000000";
					end if;
				end if;
			elsif(w_start_timer = '0' and w_current_job_expired = '1') then
				w_current_job_expired <= '0';
			elsif(w_start_timer = '0' and w_current_job_expired = '0') then
				w_current_job_expired <= '0';
				counter := std_logic_vector(to_unsigned(0, counter'length));
				timeunit := std_logic_vector(to_unsigned(0, timeunit'length));
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
			state_injection_handler <= start;
			state_scheduler_handler <= start;
			state_w_scheduler_handler <= start;
			state_switch_handler <= start;
			state_west_sorting_handler <= start;
		else
			state_north_handler <= ns_north_handler;
			state_east_handler <= ns_east_handler;
			state_south_handler <= ns_south_handler;
			state_west_handler <= ns_west_handler;
			state_injection_handler <= ns_injection_handler;
			state_scheduler_handler <= ns_scheduler_handler;
			state_w_scheduler_handler <= ns_w_scheduler_handler;
			state_switch_handler <= ns_switch_handler;
			state_west_sorting_handler <= ns_west_sorting_handler;
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
					n_vc_circEn <= '0';
					
					n_rsv_wen_a <= '0';
					n_rsv_table_purge <= '0';
					n_sch_wen_a	<= '0';
					n_sch_table_purge <= '0';
					sw_n_rna_toggle <= '0';
					
					n_sync_rst <= '1', '0' after 1 ns;
					
					ns_north_handler <= north1;
				
				when wait_state =>
					ns_north_handler <= north1;
				
				when north1 =>
					--Control Packet Arrived?
					if(n_CtrlFlg = '1') then
						ns_north_handler <= north2;
					else
						ns_north_handler <= north8;
					end if;
				when north2 =>
					if(n_rsv_table_full = '0') then
						sw_n_rna_ctrlPkt <= n_rnaCtrl;		--Make copy of packet
						ns_north_handler <= north3;
					else
						ns_north_handler <= north8;			--Table is full. Try again later
					end if;
				when north3 =>	
					--Reserve and schedule the incoming control packet
					
					--Update count
					temp := sw_n_rna_ctrlPkt(12 downto 11) + 1;
					sw_n_rna_ctrlPkt(12 downto 11) <= temp;
					
					ns_north_handler <= north4;
					
				when north4 =>
					--Write bits to rsv_data_out
					case sw_n_rna_ctrlPkt(12 downto 11) is
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
										
					ns_north_handler <= north5;
					
				when north5 =>
					--Reset signals
					n_rsv_wen_a <= '0';
					n_sch_wen_a <= '0';
				
					--Forward the Packet by checking routing table first			
					sw_n_rna_toggle <= '1';
					ns_north_handler <= north6;
				when north6 =>
					ns_north_handler <= north7;
				when north7 =>
					if(n_sync_signal = '1') then
						sw_n_rna_toggle <= '0';
						n_sync_rst <= '1', '0' after 1 ns;
						n_CTRflg <= '1', '0' after 1 ns;				--Ack back to src.
						ns_north_handler <= north8;
					else
						ns_north_handler <= north6;	--Keep trying (might need WDT eventually)
					end if;
				when north8 =>
					--Data Packet Arrived?
					if(n_DataFlg = '1') then
						ns_north_handler <= north9;
					else
						ns_north_handler <= wait_state;
					end if;
				when north9 =>
					--Grab reservation table details
					n_rsv_addr_a <= conv_integer(n_rnaCtrl(10 downto 3));
					
					ns_north_handler <= north10;
				when north10 =>	
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
					ns_north_handler <= north11;
				when north11 =>
					n_CTRflg <= '0';
					n_arbEnq <= '0';
					ns_north_handler <= wait_state;
				when others =>
					ns_north_handler <= wait_state;
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
					e_vc_circEn <= '0';
					
					e_rsv_wen_a <= '0';
					e_rsv_table_purge <= '0';
					e_sch_wen_a	<= '0';
					e_sch_table_purge <= '0';
					sw_e_rna_toggle <= '0';
					
					e_sync_rst <= '1', '0' after 1 ns;
					
					ns_east_handler <= east1;
				
				when wait_state =>
					ns_east_handler <= east1;	
				
				when east1 =>
					--Control Packet Arrived?
					if(e_CtrlFlg = '1') then
						ns_east_handler <= east2;
					else
						ns_east_handler <= east8;
					end if;
				when east2 =>
					if(e_rsv_table_full = '0') then
						sw_e_rna_ctrlPkt <= e_rnaCtrl;
						ns_east_handler <= east3;
					else
						ns_east_handler <= east8;			--Table is full. Try again later
					end if;
				when east3 =>	
					--Reserve and schedule the incoming control packet
				
					--Update count
					temp := sw_e_rna_ctrlPkt(12 downto 11) + 1;
					sw_e_rna_ctrlPkt(12 downto 11) <= temp;
					
					ns_east_handler <= east4;
				when east4 =>
					--Write bits to rsv_data_out
					case sw_e_rna_ctrlPkt(12 downto 11) is
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
										
					ns_east_handler <= east5;
				when east5 =>
					--Reset signals
					e_rsv_wen_a <= '0';
					e_sch_wen_a <= '0';
					
					--Forward the Packet	
					sw_e_rna_toggle <= '1';
					
					ns_east_handler <= east6;
				when east6 =>
					ns_east_handler <= east7;
				when east7 =>
					if(e_sync_signal = '1') then
						sw_e_rna_toggle <= '0';
						e_sync_rst <= '1', '0' after 1 ns;
						e_CTRflg <= '1', '0' after 1 ns;					--Ack back to src.
						ns_east_handler <= east8;
					else
						ns_east_handler <= east6;	--Keep trying (might need WDT eventually)
					end if;
				when east8 =>
					--Data Packet Arrived?
					if(e_DataFlg = '1') then
						ns_east_handler <= east9;
					else
						ns_east_handler <= wait_state;
					end if;
				when east9 =>
					--Grab reservation table details
					e_rsv_addr_a <= conv_integer(e_rnaCtrl(10 downto 3));
					
					ns_east_handler <= east10;
				when east10 =>	
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
					ns_east_handler <= east11;
				when east11 =>
					e_CTRflg <= '0';
					e_arbEnq <= '0';
					ns_east_handler <= wait_state;
				when others =>
					ns_east_handler <= wait_state;
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
					s_vc_circEn <= '0';
					
					s_rsv_wen_a <= '0';
					s_rsv_table_purge <= '0';
					s_sch_wen_a	<= '0';
					s_sch_table_purge <= '0';
					sw_s_rna_toggle <= '0';
					
					s_sync_rst <= '1', '0' after 1 ns;
					
					ns_south_handler <= south1;
				when wait_state =>
					ns_south_handler <= south1;
				when south1 =>
					--Control Packet Arrived?
					if(s_CtrlFlg = '1') then
						ns_south_handler <= south2;
					else
						ns_south_handler <= south8;
					end if;
				when south2 =>
					if(s_rsv_table_full = '0') then
						sw_s_rna_ctrlPkt <= s_rnaCtrl;
						ns_south_handler <= south3;
					else
						ns_south_handler <= south8;			--Table is full. Try again later
					end if;
				when south3 =>	
					--Reserve and schedule the incoming control packet
					
					--Update count
					temp := sw_s_rna_ctrlPkt(12 downto 11) + 1;
					sw_s_rna_ctrlPkt(12 downto 11) <= temp;
					
					ns_south_handler <= south4;
					
				when south4 =>
					--Write bits to rsv_data_out
					case sw_s_rna_ctrlPkt(12 downto 11) is
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
										
					ns_south_handler <= south5;
				when south5 =>
					--Reset signals
					s_rsv_wen_a <= '0';
					s_sch_wen_a <= '0';
				
					--Forward the Packet
					sw_s_rna_toggle <= '1';
					
					ns_south_handler <= south6;
				when south6 =>
					ns_south_handler <= south7;
				when south7 =>
					if(s_sync_signal = '1') then
						sw_s_rna_toggle <= '0';
						s_sync_rst <= '1', '0' after 1 ns;
						s_CTRflg <= '1', '0' after 1 ns;					--Ack back to src.
						ns_south_handler <= south8;
					else
						ns_south_handler <= south6;	--Keep trying (might need WDT eventually)
					end if;
				when south8 =>
					--Data Packet Arrived?
					if(s_DataFlg = '1') then
						ns_south_handler <= south9;
					else
						ns_south_handler <= wait_state;
					end if;
				when south9 =>
					--Grab reservation table details
					s_rsv_addr_a <= conv_integer(s_rnaCtrl(10 downto 3));
					
					ns_south_handler <= south10;
				when south10 =>	
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
					ns_south_handler <= south11;
				when south11 =>
					s_CTRflg <= '0';
					s_arbEnq <= '0';
					ns_south_handler <= wait_state;
				when others =>
					ns_south_handler <= wait_state;
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
					w_vc_circEn <= '0';
					w_vc_directEnq <= '0';
					
					w_rsv_wen_a <= '0';
					w_rsv_table_purge <= '0';
					w_sch_wen_a	<= '0';
					w_sch_table_purge <= '0';
					sw_w_rna_toggle <= '0';
					w_dpkt_arrived <= '0';
					
					w_sync_rst <= '1', '0' after 1 ns;
					
					ns_west_handler <= west1;
				when wait_state =>
					w_vc_circEn <= '0';
					w_vc_directEnq <= '0';
					w_vc_deq <= '0';
					ns_west_handler <= west1;
				when west1 =>
					--Control Packet Arrived?
					if(w_CtrlFlg = '1') then
						ns_west_handler <= west2;
					else
						ns_west_handler <= west8;
					end if;
				when west2 =>
					if(w_rsv_table_full = '0') then
						sw_w_rna_ctrlPkt <= w_rnaCtrl;
						ns_west_handler <= west3;
					else
						ns_west_handler <= west8;			--Table is full. Try again later
					end if;
				when west3 =>	
					--Reserve and schedule the incoming control packet
					
					--Update count
					temp := sw_w_rna_ctrlPkt(12 downto 11) + 1;		--Update count
					sw_w_rna_ctrlPkt(12 downto 11) <= temp;
				
					ns_west_handler <= west4;
				when west4 =>
					--Write bits to rsv_data_out
					case sw_w_rna_ctrlPkt(12 downto 11) is
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
										
					ns_west_handler <= west5;
				when west5 =>
					--Reset signals
					w_rsv_wen_a <= '0';
					w_sch_wen_a <= '0';
				
					--Forward the Packet
					sw_w_rna_toggle <= '1';
					
					ns_west_handler <= west6;
				when west6 =>
					ns_west_handler <= west7;
				when west7 =>
					if(w_sync_signal = '1') then
						sw_w_rna_toggle <= '0';
						w_sync_rst <= '1', '0' after 1 ns;
						w_CTRflg <= '1', '0' after 1 ns;					--Ack back to src.
						ns_west_handler <= west8;
					else
						ns_west_handler <= west6;	--Keep trying (might need WDT eventually)
					end if;
			
				when west8 =>
					--Data Packet Arrived?
					if(w_DataFlg = '1') then
						ns_west_handler <= west9;
					else
						ns_west_handler <= wait_state;
					end if;
				when west9 =>
					--Grab reservation table details
					w_rsv_addr_a <= conv_integer(w_rnaCtrl(10 downto 3));
					
					ns_west_handler <= west10;
				when west10 =>	
					--Control VCC
					case w_rsv_data_in_a(2 downto 0) is
						when "000" =>
							w_vc_rnaSelI <= "00";			--North
						when "001" =>
							w_vc_rnaSelI <= "01";			--East
						when "010" =>
							w_vc_rnaSelI <= "10";			--South
							w_vc_circSel <= "10";
						when "111" =>
							w_vc_rnaSelI <= "11";			--Ejection
						when others =>
							null;
					end case;
					
					--Acknowledge
					w_CTRflg <= '1';
					w_arbEnq <= '1';
					ns_west_handler <= west11;
				when west11 =>
					w_CTRflg <= '0';
					w_arbEnq <= '0';
					
					--Notify scheduler if this packet is set to depart soon
					if(w_midgid_scheduled = conv_integer(w_rnaCtrl(10 downto 3))) then
						w_dpkt_arrived <= '1', '0' after 1 ns;
					else
						w_dpkt_arrived <= '0';
					end if;
					
					--Shift VC (TEST)
					w_vc_circEn <= '1';	-- Resets to 0 at "wait_state" Am I doing this right?	
					w_vc_directEnq <= '1';
					w_vc_deq <= '1';
					
					ns_west_handler <= wait_state;
				when others =>
					ns_west_handler <= wait_state;
			end case;
	end process;
		
	--************************************************************************
	--injection_handler: Handles all incoming packets (data/control) on injection port
	--************************************************************************
	injection_handler:process(state_injection_handler)
	variable temp : std_logic_vector(1 downto 0);
	begin
		case state_injection_handler is
				when start =>
					sw_injt_toggle <= '0';
					i_rst <= '1', '0' after 1 ns;
						
					ns_injection_handler <= injection1;
				when wait_state =>
					ns_injection_handler <= injection1;
				when injection1 =>
					--Control Packet Arrived?
					if(sw_rnaCtFl = '1') then
						ns_injection_handler <= injection2;
					else
						ns_injection_handler <= wait_state;
					end if;
				when injection2 =>
					sw_injt_pkt <= injt_ctrlPkt;
					ns_injection_handler <= injection3;
				when injection3 =>
					--Forward packet
					sw_injt_toggle <= '1';
					ns_injection_handler <= injection4;
				when injection4 =>
					ns_injection_handler <= injection5;
				when injection5 =>
					if(i_pkt_in_flg_set = '1') then
						sw_injt_toggle <= '0';
						i_rst <= '1', '0' after 1 ns;
						ns_injection_handler <= wait_state;
					else
						ns_injection_handler <= injection4;	--Keep trying (might need WDT eventually)
					end if;
				when others =>
					ns_injection_handler <= injection1;
			end case;
	end process;
	
--	--************************************************************************	
--	--n_scheduler_handler - Handles all scheduling related tasks on North Port
--	--************************************************************************
--	n_scheduler_handler:process(state_scheduler_handler)
--	begin
--	end process;

	--************************************************************************	
	--w_scheduler_handler - Handles all scheduling related tasks on West Port
	--************************************************************************
	w_scheduler_handler:process(state_w_scheduler_handler)
	begin
		case state_w_scheduler_handler is
			when start =>
				w_request_next_job <= '0';
				w_purge_sch_job <= '0';
				w_pktarr_rst <= '0';
				w_jobrdy_rst <= '0';
				
				ns_w_scheduler_handler <= schedule1;
			when wait_state =>
				ns_w_scheduler_handler <= schedule1;
			when schedule1 =>
				if(w_current_job_expired = '0') then
					w_request_next_job <= '1';
					ns_w_scheduler_handler <= schedule3;
				else
					w_request_next_job <= '0';
					ns_w_scheduler_handler <= wait_state;
				end if;
			when schedule2 =>
				ns_w_scheduler_handler <= schedule3;
			when schedule3 =>
				if(w_jobrdy_signal = '1') then
					w_jobrdy_rst <= '1', '0' after 1 ns;
					w_request_next_job <= '0';
					ns_w_scheduler_handler <= schedule4;
				else
					ns_w_scheduler_handler <= schedule2;
				end if;
			when schedule4 =>
				w_pkt_expires_in <= w_next_sch_job_time;
				w_midgid_scheduled <= w_next_sch_job_midpid;
				w_start_timer <= '1';
				ns_w_scheduler_handler <= schedule6;
			when schedule5 =>
				ns_w_scheduler_handler <= schedule6;
			when schedule6 =>
				if(w_current_job_expired = '1' or w_pktarr_signal = '1') then
					w_pktarr_rst <= '1', '0' after 1 ns;
					w_start_timer <= '0';
					ns_w_scheduler_handler <= schedule8;		--Job expired!
				else	
					ns_w_scheduler_handler <= schedule5;		--Not yet...
				end if;
			when schedule7 =>
				ns_w_scheduler_handler <= schedule9;			--Wait for ack...
			when schedule8 =>
				--Initiate data packet transfer
				sw_w_depart_toggle <= '1';
				ns_w_scheduler_handler <= schedule9;
			when schedule9 =>
				if(w_departed_ack = '1') then
					sw_w_depart_toggle <= '0';
					
					--Purge data from scheduler
					w_purge_sch_job <= '1', '0' after 1 ns;
					w_purge_midpid <= w_midgid_scheduled;
					ns_w_scheduler_handler <= wait_state;
				else
					ns_w_scheduler_handler <= schedule7;
				end if;
			when others =>
				ns_w_scheduler_handler <= start;
		end case;
	end process;
	
	--************************************************************************	
	--w_sorting_handler - Handles all schedule sorting for West Port
	--************************************************************************
	w_sorting_handler:process(state_west_sorting_handler)
		variable w_last_scheduled : natural range 0 to 2**address_size := 256;
	begin
		case state_west_sorting_handler is
			when start =>
				w_sch_wen_b <= '0';
				w_new_job_ready <= '0';
				w_pktprg_rst <= '0';
				w_next_sch_job_valid <= '0';
			
				ns_west_sorting_handler <= sort1;
				
			when wait_state =>
				ns_west_sorting_handler <= sort1;
			when sort1 =>
				--Did job finish? Purge location in scheduler?
				if(w_pktprg_signal = '1') then
					w_pktprg_rst <= '1', '0' after 1 ns;
					w_sch_addr_b <= w_purge_midpid;
					w_sch_data_out_b <= "11111111111111111111111111111111";	
					w_sch_wen_b <= '1';
								
					ns_west_sorting_handler <= sort2;
				else
					ns_west_sorting_handler <= sort3;
				end if;
			when sort2 =>
				w_sch_wen_b <= '0';
				--Reset Signals
				ns_west_sorting_handler <= sort3;
			when sort3 =>
				if(w_sch_table_count > 0) then
					w_sch_addr_b <= w_index;
					ns_west_sorting_handler <= sort4;
				else
					w_index <= 0;
					ns_west_sorting_handler <= wait_state;
				end if;
			when sort4 =>
				--Take first item
				w_next_sch_job_time <= w_sch_data_in_b;
				w_next_sch_job_midpid <= w_index;
				w_index <= w_index + 1;
				if(w_sch_data_in_b(31 downto 0) > 0 and (w_last_scheduled /= w_index)) then
					w_next_sch_job_valid <= '1';
				else
					w_next_sch_job_valid <= '0';
				end if;
				ns_west_sorting_handler <= sort5;
			when sort5 =>
				if(w_index /= 256) then
					w_sch_addr_b <= w_index;
					ns_west_sorting_handler <= sort6;
				else
					w_index <= 0;
					ns_west_sorting_handler <= sort7;
				end if;
			when sort6 =>
				if(w_sch_data_in_b < w_next_sch_job_time and (w_sch_data_in_b(31 downto 0) > 0)) then
					w_next_sch_job_time <= w_sch_data_in_b;
					w_next_sch_job_midpid <= w_index;
					if(w_index /= w_next_sch_job_midpid) then
						w_next_sch_job_valid <= '1';			--Ensure that you're not reading the same location
					else
						w_next_sch_job_valid <= '0';			--If so, don't issue the request.
					end if;
				end if;
		
				w_index <= w_index + 1;
				ns_west_sorting_handler <= sort5;
			when sort7 =>
				--Is there a new job request? Issue it, if so.
				if(w_request_next_job = '1' and w_next_sch_job_valid = '1') then
					w_last_scheduled := w_index;
					w_new_job_ready <= '1', '0' after 1 ns;
				else
					w_new_job_ready <= '0';
				end if;
						
				ns_west_sorting_handler <= wait_state;
			when others =>
				ns_west_sorting_handler <= start;
		end case;
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
				
				n_vc_deq <= '0';
				n_vc_strq <= '0';
				e_vc_deq <= '0';
				e_vc_strq <= '0';
				s_vc_deq <= '0';
				s_vc_strq <= '0';
				--w_vc_deq <= '0';
				w_vc_strq <= '0';
				
				sw_nSel <= "000";
				sw_eSel <= "000";
				sw_sSel <= "000";
				sw_wSel <= "000";
				
				n_rst <= '1', '0' after 1 ns;
				e_rst <= '1', '0' after 1 ns;
				s_rst <= '1', '0' after 1 ns;
				w_rst <= '1', '0' after 1 ns;
				
				n_invld_out <= '0';
				e_invld_out <= '0';
				s_invld_out <= '0';
				w_invld_out <= '0';
				
				injt_dataGood <= '0';
				sw_rnaCtDeq <= '0';
				
				w_departed_ack <= '0';
				
				ns_switch_handler <= north_sw1;
			when north_sw1 =>
				if(sw_n_rna_toggle = '1') then
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
						sw_nSel <= "111";			-- "00" North								
					when "001" =>
						sw_eSel <= "111";			-- "01" East
					when "010" =>
						sw_sSel <= "111";			-- "10" South
					when "011" =>
						sw_wSel <= "111";			-- "11" West
					when "111" =>
						sw_ejectSel <= "111";	-- "Ejection"
					when others =>	
						null;
				end case;
				
				if(direction = "111") then
					--Ejection
					sw_n_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					ns_switch_handler <= east_sw1;
				else
					ns_switch_handler <= north_sw3;
				end if;
			
			when north_sw3 =>
				ns_switch_handler <= north_sw4;
				
			when north_sw4 =>	
					
				if(n_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_n_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					n_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= east_sw1;
				elsif(e_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_n_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					e_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= east_sw1;
				elsif(s_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_n_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					s_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= east_sw1;
				elsif(w_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_n_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					w_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= east_sw1;
				else
					ns_switch_handler <= north_sw3;
				end if;
				
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
						sw_nSel <= "111";			-- "00" North								
					when "001" =>
						sw_eSel <= "111";			-- "01" East
					when "010" =>
						sw_sSel <= "111";			-- "10" South
					when "011" =>
						sw_wSel <= "111";			-- "11" West
					when "111" =>
						sw_ejectSel <= "111";	-- "Ejection"
					when others =>	
						null;
				end case;
				
				if(direction = "111") then
					--Ejection
					sw_e_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					ns_switch_handler <= south_sw1;
				else
					ns_switch_handler <= east_sw3;
				end if;
			
			when east_sw3 =>
				ns_switch_handler <= east_sw4;
				
			when east_sw4 =>	
					
				if(n_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_e_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					n_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= south_sw1;
				elsif(e_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_e_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					e_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= south_sw1;
				elsif(s_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_e_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					s_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= south_sw1;
				elsif(w_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_e_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					w_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= south_sw1;
				else
					ns_switch_handler <= east_sw3;
				end if;
				
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
						sw_nSel <= "111";			-- "00" North								
					when "001" =>
						sw_eSel <= "111";			-- "01" East
					when "010" =>
						sw_sSel <= "111";			-- "10" South
					when "011" =>
						sw_wSel <= "111";			-- "11" West
					when "111" =>
						sw_ejectSel <= "111";	-- "Ejection"
					when others =>	
						null;
				end case;
				
				if(direction = "111") then
					--Ejection
					sw_s_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					ns_switch_handler <= west_sw1;
				else
					ns_switch_handler <= south_sw3;
				end if;
						
			when south_sw3 =>
				ns_switch_handler <= south_sw4;
				
			when south_sw4 =>	
					
				if(n_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_s_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					n_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= west_sw1;
				elsif(e_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_s_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					e_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= west_sw1;
				elsif(s_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_s_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					s_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= west_sw1;
				elsif(w_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_s_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					w_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= west_sw1;
				else
					ns_switch_handler <= south_sw3;
				end if;
				
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
						sw_nSel <= "111";			-- "00" North								
					when "001" =>
						sw_eSel <= "111";			-- "01" East
					when "010" =>
						sw_sSel <= "111";			-- "10" South
					when "011" =>
						sw_wSel <= "111";			-- "11" West
					when "111" =>
						sw_ejectSel <= "111";	-- "Ejection"
					when others =>	
						null;
				end case;
				
				if(direction = "111") then
					--Ejection
					sw_w_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					ns_switch_handler <= injection_sw1;
				else
					ns_switch_handler <= west_sw3;
				end if;
				
			when west_sw3 =>
				ns_switch_handler <= west_sw4;
				
			when west_sw4 =>	
					
				if(n_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_w_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					n_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= injection_sw1;
				elsif(e_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_w_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					e_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= injection_sw1;
				elsif(s_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_w_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					s_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= injection_sw1;
				elsif(w_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_w_rna_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					w_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= injection_sw1;
				else
					ns_switch_handler <= west_sw3;
				end if;
				
			when injection_sw1 =>
				if(sw_injt_toggle = '1') then
				
					count:= sw_injt_pkt(12 downto 11);	--Get next hop
					case count is
						when "00" =>	
							direction := sw_injt_pkt(15 downto 13);
						when "01" =>
							direction := sw_injt_pkt(18 downto 16);
						when "10" =>
							direction := sw_injt_pkt(21 downto 19);
						when "11" =>
							direction := sw_injt_pkt(24 downto 22);
						when others =>
							null;
					end case;
					
					ns_switch_handler <= injection_sw2;
				else
					ns_switch_handler <= depart_w_sw1;
				end if;
			when injection_sw2 =>
			
				if(sw_injt_pkt(0) = '1') then
					--Configure the switch for CONTROL PACKETS
					
					--Send control packet
					rna_ctrlPkt <= sw_injt_pkt;
					
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
				else
					--Configure the switch for DATA PACKETS
					case direction is
						when "000" =>
							sw_nSel <= "101";			-- "00" North FIFO								
						when "001" =>
							sw_eSel <= "101";			-- "01" East FIFO
						when "010" =>
							sw_sSel <= "101";			-- "10" South FIFO
						when "011" =>
							sw_wSel <= "101";			-- "11" Ejection FIFO
						when others =>	
							null;
					end case;
					
					injt_dataGood <= '1';
				
				end if;
				ns_switch_handler <= injection_sw3;
			
			when injection_sw3 =>
				ns_switch_handler <= injection_sw4;
				
			when injection_sw4 =>	
					
				if(n_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_injt_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					injt_dataGood <= '0';
					sw_rnaCtDeq <= '1', '0' after 1 ns;
					n_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= depart_w_sw1;
				elsif(e_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_injt_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					injt_dataGood <= '0';
					sw_rnaCtDeq <= '1', '0' after 1 ns;
					e_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= depart_w_sw1;
				elsif(s_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_injt_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					injt_dataGood <= '0';
					sw_rnaCtDeq <= '1', '0' after 1 ns;
					s_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= depart_w_sw1;
				elsif(w_pkt_in_flg_set = '1') then
					--Ack & Reset Signals
					sw_injt_ack <= '1', '0' after 1 ns;
					rna_CtrlPkt(0) <= '0';
					injt_dataGood <= '0';
					sw_rnaCtDeq <= '1', '0' after 1 ns;
					w_rst <= '1', '0' after 1 ns;
					ns_switch_handler <= depart_w_sw1;
				else
					ns_switch_handler <= injection_sw3;
				end if;
			when depart_w_sw1 =>
				if(sw_w_depart_toggle = '1') then
					--Grab reservation table details
					w_rsv_addr_b <= conv_integer(w_midgid_scheduled);
					ns_switch_handler <= depart_w_sw2;
				else
					w_departed_ack <= '0';
					ns_switch_handler <= north_sw1;
				end if;
			when depart_w_sw2 =>	
				--Control VCC Output and Switch to move Data Packet out
				case w_rsv_data_in_b(2 downto 0) is
					when "000" =>
						w_vc_rnaSelO <= "00";
						sw_nSel <= "011"; 						--North
					when "001" =>
						w_vc_rnaSelO <= "01";
						sw_eSel <= "011";							--East
					when "010" =>
						w_vc_rnaSelO <= "10";
						sw_sSel <= "011";							--South
					when "111" =>
						w_vc_rnaSelO <= "11";
						sw_ejectSel <= "011";					--Ejection
					when others =>
						null;
				end case;
				
				--injt_dataGood <= '1';
				ns_switch_handler <= depart_w_sw4;
			when depart_w_sw3 =>
				--Wait state
				ns_switch_handler <= depart_w_sw4;
			when depart_w_sw4 =>
				--Check for ack
				if(n_pkt_in_flg_set = '1') then
					w_departed_ack <= '1';
					n_rst <= '1', '0' after 1 ns;
					--injt_dataGood <= '0';
					ns_switch_handler <= depart_w_sw5;
				elsif(e_pkt_in_flg_set = '1') then
					w_departed_ack <= '1';
					e_rst <= '1', '0' after 1 ns;
					--injt_dataGood <= '0';
					ns_switch_handler <= depart_w_sw5;
				elsif(s_pkt_in_flg_set = '1') then
					w_departed_ack <= '1';
					s_rst <= '1', '0' after 1 ns;
					--w_vc_deq <= '1', '0' after 1 ns;		-- "11" West FIFO
					sw_sSel <= "000";
					ns_switch_handler <= north_sw1;
					--injt_dataGood <= '0';
					--ns_switch_handler <= depart_w_sw5;
				elsif(w_pkt_in_flg_set = '1') then
					w_departed_ack <= '1';
					w_rst <= '1', '0' after 1 ns;
					--injt_dataGood <= '0';
					ns_switch_handler <= depart_w_sw5;
				else
					ns_switch_handler <= depart_w_sw3;
				end if;
			when depart_w_sw5 =>
				--Dequeue
				--w_vc_deq <= '1', '0' after 1 ns;		-- "11" West FIFO
				
				ns_switch_handler <= north_sw1;
			when others =>
				ns_switch_handler <= north_sw1;
		end case;
	end process;
	
	--************************************************************************
	--north_signal_handler: Handles synchronization signals with neighbor
	--************************************************************************
	north_signal_handler:process(n_rst, n_CTRinFlg)
	begin
		if(n_rst = '1') then
			n_pkt_in_flg_set <= '0';
		end if;
				
		if(n_CTRinFlg = '1') then		--ACK back from SOUTH port (receiver)
			n_pkt_in_flg_set <= '1';
		end if;
	
	end process;
	
	--************************************************************************
	--east_signal_handler: Handles synchronization signals with neighbor
	--************************************************************************
	east_signal_handler:process(e_rst, e_CTRinFlg)
	begin
		if(e_rst = '1') then
			e_pkt_in_flg_set <= '0';
		end if;
				
		if(e_CTRinFlg = '1') then		--ACK back from WEST port (receiver)
			e_pkt_in_flg_set <= '1';
		end if;
	
	end process;
	
	--************************************************************************
	--south_signal_handler: Handles synchronization signals with neighbor
	--************************************************************************
	south_signal_handler:process(s_rst, s_CTRinFlg)
	begin
		if(s_rst = '1') then
			s_pkt_in_flg_set <= '0';
		end if;
				
		if(s_CTRinFlg = '1') then		--ACK back from NORTH port (receiver)
			s_pkt_in_flg_set <= '1';
		end if;
	
	end process;
	
	--************************************************************************
	--west_signal_handler: Handles synchronization signals with neighbor
	--************************************************************************
	west_signal_handler:process(w_rst, w_CTRinFlg)
	begin
		if(w_rst = '1') then
			w_pkt_in_flg_set <= '0';
		end if;
				
		if(w_CTRinFlg = '1') then		--ACK back from EAST port (receiver)
			w_pkt_in_flg_set <= '1';
		end if;
	
	end process;
	
	--************************************************************************
	--inject_signal_handler: Handles synchronization signals for injection
	--************************************************************************
	injection_signal_sync:process(i_rst, sw_injt_ack)
	begin
		if(i_rst = '1') then
			i_pkt_in_flg_set <= '0';
		end if;
				
		if(sw_injt_ack = '1') then		--ACK from within
			i_pkt_in_flg_set <= '1';
		end if;
	
	end process;
	
	
	--************************************************************************
	--north_signal_sync: Handles synchronization signals for north
	--************************************************************************
	north_signal_sync:process(n_sync_rst, sw_n_rna_ack)
	begin
		if(n_sync_rst = '1') then
			n_sync_signal <= '0';
		end if;
		
		if(sw_n_rna_ack = '1') then
			n_sync_signal <= '1';
		end if;
	end process;
	
	--************************************************************************
	--east_signal_sync: Handles synchronization signals for north
	--************************************************************************
	east_signal_sync:process(e_sync_rst, sw_e_rna_ack)
	begin
		if(e_sync_rst = '1') then
			e_sync_signal <= '0';
		end if;
		
		if(sw_e_rna_ack = '1') then
			e_sync_signal <= '1';
		end if;
	end process;
	
	--************************************************************************
	--south_signal_sync: Handles synchronization signals for north
	--************************************************************************
	south_signal_sync:process(s_sync_rst, sw_s_rna_ack)
	begin
		if(s_sync_rst = '1') then
			s_sync_signal <= '0';
		end if;
		
		if(sw_s_rna_ack = '1') then
			s_sync_signal <= '1';
		end if;
	end process;
	
	--************************************************************************
	--west_signal_sync: Handles synchronization signals for north
	--************************************************************************
	west_signal_sync:process(w_sync_rst, sw_w_rna_ack)
	begin
		if(w_sync_rst = '1') then
			w_sync_signal <= '0';
		end if;
		
		if(sw_w_rna_ack = '1') then
			w_sync_signal <= '1';
		end if;
	end process;
	
	--************************************************************************
	--west_pktarrived_sync: Handles dpkt arrived signal for west
	--************************************************************************
	west_pktarrived_sync:process(w_pktarr_rst, w_dpkt_arrived)
	begin
		if(w_pktarr_rst = '1') then
			w_pktarr_signal <= '0';
		end if;
		
		if(w_dpkt_arrived = '1') then
			w_pktarr_signal <= '1';
		end if;
	end process;
	
	--************************************************************************
	--west_pktpurge_sync: Handles purge signal for west
	--************************************************************************
	west_pktpurge_sync:process(w_pktprg_rst, w_purge_sch_job)
	begin
		if(w_pktprg_rst = '1') then
			w_pktprg_signal <= '0';
		end if;
		
		if(w_purge_sch_job = '1') then
			w_pktprg_signal <= '1';
		end if;
	end process;
	
	--************************************************************************
	--west_jobready_sync: Handles job ready signal for west
	--************************************************************************
	west_jobready_sync:process(w_jobrdy_rst, w_new_job_ready)
	begin
		if(w_jobrdy_rst = '1') then
			w_jobrdy_signal <= '0';
		end if;
		
		if(w_new_job_ready = '1') then
			w_jobrdy_signal <= '1';
		end if;
	end process;
end Behavioral;
