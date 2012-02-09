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
	generic(cp_size		: natural;
			  address_size : natural;
			  rsv_size 		: natural;
			  rte_size		: natural;
			  sch_size		: natural;
			  adr_size		: natural);
	port(
			clk				   : in 	std_logic;
			rst					: in 	std_logic;
			rsv_data_in			: in 	std_logic_vector (rsv_size-1 downto 0);
			rsv_data_out		: out std_logic_vector (rsv_size-1 downto 0);
			rte_data_in			: in 	std_logic_vector (rte_size-1 downto 0);
			rte_data_out		: out std_logic_vector (rte_size-1 downto 0);
			sch_data_in			: in 	std_logic_vector (sch_size-1 downto 0);
			sch_data_out		: out std_logic_vector (sch_size-1 downto 0);
			adr_data_in			: in 	std_logic_vector (adr_size-1 downto 0);
			adr_data_out		: out std_logic_vector (adr_size-1 downto 0);
			address				: out std_logic_vector (address_size-1 downto 0);
			rsv_en				: out std_logic;
			rte_en				: out std_logic;
			sch_en 				: out std_logic;
			adr_en				: out std_logic;
			adr_search			: out std_logic;
			adr_nf				: in  std_logic;
			adr_nf_ack			: out std_logic;
			adr_result			: in 	std_logic_vector (address_size-1 downto 0);
			n_vc_deq 			: out std_logic;
			n_vc_rnaSelI 		: out std_logic_vector (1 downto 0);		 
			n_vc_rnaSelO 		: out std_logic_vector (1 downto 0);		
			n_vc_rnaSelS		: out	std_logic_vector (1 downto 0);		
			n_vc_strq 			: out std_logic;									
			n_vc_status 		: in 	std_logic_vector (1 downto 0);		
			e_vc_deq 			: out std_logic;									
			e_vc_rnaSelI 		: out std_logic_vector (1 downto 0);		
			e_vc_rnaSelO 		: out std_logic_vector (1 downto 0);		 
			e_vc_rnaSelS		: out	std_logic_vector (1 downto 0);
			e_vc_strq 			: out std_logic;
			e_vc_status 		: in 	std_logic_vector (1 downto 0);
			s_vc_deq 			: out std_logic;							
			s_vc_rnaSelI 		: out std_logic_vector (1 downto 0); 
			s_vc_rnaSelO 		: out std_logic_vector (1 downto 0); 
			s_vc_rnaSelS		: out	std_logic_vector (1 downto 0);
			s_vc_strq 			: out std_logic;							
			s_vc_status 		: in 	std_logic_vector (1 downto 0);
			w_vc_deq 			: out std_logic;
			w_vc_rnaSelI 		: out std_logic_vector (1 downto 0); 
			w_vc_rnaSelO 		: out std_logic_vector (1 downto 0); 
			w_vc_rnaSelS		: out	std_logic_vector (1 downto 0);
			w_vc_strq 			: out std_logic;
			w_vc_status 		: in 	std_logic_vector (1 downto 0);
			n_CTRinFlg			: in  std_logic;
			n_CTRflg				: out std_logic;
			n_CtrlFlg			: in 	std_logic;
			n_DataFlg			: in  std_logic;
			n_arbEnq				: out std_logic;
			n_rnaCtrl			: in 	std_logic_vector(cp_size-1 downto 0);
			e_CTRinFlg			: in  std_logic;
			e_CTRflg				: out std_logic;
			e_CtrlFlg			: in 	std_logic;
			e_DataFlg			: in  std_logic;
			e_arbEnq				: out std_logic;
			e_rnaCtrl			: in 	std_logic_vector(cp_size-1 downto 0);
			s_CTRinFlg			: in  std_logic;
			s_CTRflg				: out std_logic;
			s_CtrlFlg			: in 	std_logic;
			s_DataFlg			: in  std_logic;
			s_arbEnq				: out std_logic;
			s_rnaCtrl			: in 	std_logic_vector(cp_size-1 downto 0);
			w_CTRinFlg			: in  std_logic;
			w_CTRflg				: out std_logic;
			w_CtrlFlg			: in 	std_logic;
			w_DataFlg			: in  std_logic;
			w_arbEnq				: out std_logic;
			w_rnaCtrl			: in 	std_logic_vector(cp_size-1 downto 0);
			sw_nSel				: out std_logic_vector(2 downto 0);
			sw_eSel				: out std_logic_vector(2 downto 0);
			sw_sSel				: out std_logic_vector(2 downto 0);
			sw_wSel				: out std_logic_vector(2 downto 0);
			sw_ejectSel			: out std_logic_vector(2 downto 0);
			sw_rnaCtFl			: in 	std_logic;
			sw_rnaCtDeq			: out std_logic;
			rna_ctrlPkt			: out std_logic_vector(cp_size-1 downto 0);
			injt_ctrlPkt		: in 	std_logic_vector (cp_size-1 downto 0)
		);
end ControlUnit;

architecture Behavioral of ControlUnit is
	type state_type is (start, north1, north2, north3, north4, north5, north6, north7,
							  east1, east2, east3, east4, east5, east6, east7,
							  south1, south2, south3, south4, south5, south6, south7,
							  west1, west2, west3, west4, west5, west6, west7,
							  injection1, injection2, injection3, injection4, injection5,
							  injection6, injection7, injection8, injection9, injection10,
							  timer_check1, timer_check2, timer_check3, timer_check4,
							  departure1,
							  dp_arrivedOnNorth1, dp_arrivedOnNorth2, dp_arrivedOnNorth3, dp_arrivedOnNorth4, dp_arrivedOnNorth5, dp_arrivedOnNorth6, dp_arrivedOnNorth7,
							  dp_arrivedOnEast1, dp_arrivedOnEast2, dp_arrivedOnEast3, dp_arrivedOnEast4, dp_arrivedOnEast5, dp_arrivedOnEast6, dp_arrivedOnEast7,
							  dp_arrivedOnSouth1, dp_arrivedOnSouth2, dp_arrivedOnSouth3, dp_arrivedOnSouth4, dp_arrivedOnSouth5, dp_arrivedOnSouth6, dp_arrivedOnSouth7,
							  dp_arrivedOnWest1, dp_arrivedOnWest2, dp_arrivedOnWest3, dp_arrivedOnWest4, dp_arrivedOnWest5, dp_arrivedOnWest6, dp_arrivedOnWest7);   --73 State FSM
	signal state, next_state : state_type;
	
	signal router_address 	: std_logic_vector(PID_WIDTH-1 downto 0);

	--Timer Related Signals
	signal globaltime			: std_logic_vector(15 downto 0);
	signal counter 			: std_logic_vector(15 downto 0);
	signal timeunit1 			: std_logic_vector(15 downto 0);
	signal timeunit2 			: std_logic_vector(15 downto 0);
	signal start_timer 		: std_logic;
	signal time_expired  	: std_logic;
	
	--Departure Itinerary
	signal next_pkt_departing_from_gate	: std_logic_vector(rte_size-1 downto 0);
	signal next_pkt_in_vcc					: std_logic_vector(2 downto 0);
	signal next_pkt_in_vcell				: std_logic_vector(2 downto 0);
	signal next_pkt_expires_in				: std_logic_vector(15 downto 0);

	--Arrival Related Signals
	signal n_DpFlg				: std_logic;
	signal e_DpFlg				: std_logic;
	signal s_DpFlg				: std_logic;
	signal w_DpFlg				: std_logic;
	
	--Monitoring
	signal n_rst				: std_logic;
	signal n_data_flg_set	: std_logic;
	signal n_ctrl_flg_set	: std_logic;
	signal n_ctrl_in_flg_set : std_logic;
	signal n_buffer			: std_logic_vector(cp_size-1 downto 0);
	
	signal e_rst				: std_logic;
	signal e_data_flg_set	: std_logic;
	signal e_ctrl_flg_set	: std_logic;
	signal e_ctrl_in_flg_set : std_logic;
	signal e_buffer			: std_logic_vector(cp_size-1 downto 0);
	
	signal s_rst				: std_logic;
	signal s_data_flg_set	: std_logic;
	signal s_ctrl_flg_set	: std_logic;
	signal s_ctrl_in_flg_set : std_logic;
	signal s_buffer			: std_logic_vector(cp_size-1 downto 0);

	signal w_rst				: std_logic;
	signal w_data_flg_set	: std_logic;
	signal w_ctrl_flg_set	: std_logic;
	signal w_ctrl_in_flg_set : std_logic;
	signal w_buffer			: std_logic_vector(cp_size-1 downto 0);

	
begin

	--globaltimer_process: This is the running timer (indefinitely)
	globaltimer_process: process(clk, rst)
	begin
		
		if rst = '1' then
			globaltime <= std_logic_vector(to_unsigned(0, globaltime'length));
			timeunit1 <= std_logic_vector(to_unsigned(0, timeunit1'length));
		
		elsif rising_edge(clk) then
			timeunit1 <= timeunit1 + "0000000000000001";
			if(timeunit1 = "000000111110") then
				globaltime <= globaltime + "0000000000000001";
				timeunit1 <= "0000000000000000";
			end if;
		end if;
	end process;


	--timebase_process: 	Creates a "stopwatch" for establishing a timebase that
	--							the packet transfers process requires to ensure QoS.
	timebase_process: process(clk, rst)
	begin
	
		if rst = '1' then
			counter <= std_logic_vector(to_unsigned(0, counter'length));
			time_expired <= '0';
			timeunit2 <= std_logic_vector(to_unsigned(0, timeunit2'length));
			
		elsif rising_edge(clk) then
			if(start_timer = '1' and time_expired = '0') then
				timeunit2 <= timeunit2 + "0000000000000001";
				time_expired <= '0';
				if(timeunit2 = "0000000000000110") then								-- was 1000 cycles 0000000000111110
					counter <= counter + "0000000000000001";		--increment the counter by 1 tick
					if(counter = next_pkt_expires_in) then
						counter <= "0000000000000000";
						time_expired <= '1';
					end if;
					timeunit2 <= "0000000000000000";
				end if;
			elsif(start_timer = '0' and time_expired = '1') then
				time_expired <= '0';
			end if;
		end if;
	end process;
	
	--cpStateHandler_process: These processes below are responsible for assigning the next_state

	process
	begin
		wait until rising_edge(clk);
		if rst = '1' then
			state <= start;
		else
			state <= next_state;
		end if;
	end process;
	
	process(state)
		  
		--Memory Related Variables (Routing/Reservation/Scheduler)
		variable w_address 			: std_logic_vector(address_size-1 downto 0);
		variable r_address			: std_logic_vector(address_size-1 downto 0);
		variable reserved_cnt		: std_logic_vector(address_size-1 downto 0);
		variable table_full 			: std_logic;
	
		begin
			case state is
				when start =>
					--Reset state
					w_address := std_logic_vector(to_unsigned(0, w_address'length));
					r_address := std_logic_vector(to_unsigned(0, r_address'length));
					reserved_cnt := std_logic_vector(to_unsigned(0, reserved_cnt'length));
					table_full := '0';
					
					router_address <= std_logic_vector(to_unsigned(0, router_address'length));
					start_timer <= '0';
					next_pkt_departing_from_gate <= std_logic_vector(to_unsigned(0, next_pkt_departing_from_gate'length));
					next_pkt_in_vcc <= std_logic_vector(to_unsigned(0, next_pkt_in_vcc'length));
					next_pkt_in_vcell <= std_logic_vector(to_unsigned(0, next_pkt_in_vcell'length));
					next_pkt_expires_in <= std_logic_vector(to_unsigned(0, next_pkt_expires_in'length));
			
					rsv_en <= '0';
					rte_en <= '0';
					sch_en <= '0';
					adr_en <= '0';
					
					adr_search <= '0';
					adr_nf_ack <= '0';
							
					sw_rnaCtDeq <= '0';
					
					--Drive signals to initial state
					n_vc_deq <= '0';
					n_vc_strq <= '0';
					e_vc_deq <= '0';
					e_vc_strq <= '0';
					s_vc_deq <= '0';
					s_vc_strq <= '0';
					w_vc_deq <= '0';
					w_vc_strq <= '0';
					
					n_CTRflg <= '0';
					n_arbEnq <= '0';
					e_CTRflg <= '0';
					e_arbEnq <= '0';
					s_CTRflg <= '0';
					s_arbEnq <= '0';
					w_CTRflg <= '0';
					w_arbEnq <= '0';
					
					sw_nSel <= "111";
					sw_eSel <= "111";
					sw_sSel <= "111";
					sw_wSel <= "111";
					
					n_rst <= '1', '0' after 1 ns;
					e_rst <= '1', '0' after 1 ns;
					s_rst <= '1', '0' after 1 ns;
					w_rst <= '1', '0' after 1 ns;
					
					next_state <= north1;
	--*NORTH*--
				when north1 =>
					--Check flag
					if(n_ctrl_flg_set = '1') then
						next_state <= north2;
					else
						next_state <= east1;
					end if;
				when north2 =>
					if(n_buffer(6 downto 3) = router_address) then
						next_state <= north3;	--It's for me!
					else
						next_state <= north4;	--Forward the control packet.
					end if;
				when north3 =>
					if(table_full = '0') then
						next_state <= north5;
					else
						next_state <= east1;
					end if;
				when north4 =>
					--Forward the Packet by checking routing table first
					address <= n_buffer(6 downto 3);
					rte_en <= '0';
					next_state <= north6;
				when north5 =>	
					--Reserve and schedule the incoming control packet
					--Ack!
					n_CTRflg <= '1', '0' after 1 ns;
					--Write bits to rsv_data_out
					rsv_data_out <= "000" & n_buffer(9 downto 7);
					--Write bits to sch_data_out
					sch_data_out <= (globaltime + n_buffer(cp_size-1 downto 18));
					--Store GID/PID in location w_address
					adr_data_out <= n_buffer(17 downto 10);
					
					--Send to reservation/scheduler/address tables
					address <= w_address;
					rsv_en <= '1';
					sch_en <= '1';
					adr_en <= '1';
					next_state <= north7;
				when north6 =>
					--Configure the switch
					sw_nSel <= rte_data_in(2 downto 0);				--North Neighbor (use Control from Arbiter)
					--Write to rna_ctrlPkt
					rna_ctrlPkt <= n_buffer;
					next_state <= east1;
				when north7 =>
					w_address := w_address + 1;
					reserved_cnt := reserved_cnt + 1;
					
					--Check table space
					if(reserved_cnt <= "1110") then
						table_full := '0';
					else
						table_full := '1';
					end if;
					
					rsv_en <= '0';
					sch_en <= '0';
					adr_en <= '0';
					next_state <= east1;
	--*EAST*--				
				when east1 =>
					--Check flag
					if(e_ctrl_flg_set = '1') then
						next_state <= east2;
					else
						next_state <= south1;
					end if;
				when east2 =>
					if(e_buffer(6 downto 3) = router_address) then
						next_state <= east3;	--It's for me!
					else
						next_state <= east4;	--Forward the control packet.
					end if;
				when east3 =>
					if(table_full = '0') then
						next_state <= east5;
					else
						next_state <= south1;
					end if;
				when east4 =>
					--Forward the Packet by checking routing table first
					address <= e_buffer(6 downto 3);
					rte_en <= '0';
					next_state <= east6;
				when east5 =>	
					--Reserve and schedule the incoming control packet
					--Ack!
					e_CTRflg <= '1', '0' after 1 ns;
					--Write bits to rsv_data_out
					rsv_data_out <= "001" & e_buffer(9 downto 7);
					--Write bits to sch_data_out
					sch_data_out <= (globaltime + e_buffer(cp_size-1 downto 18));
					--Store GID/PID in location w_address
					adr_data_out <= e_buffer(17 downto 10);
					--Send to reservation table
					address <= w_address;
					rsv_en <= '1';
					sch_en <= '1';
					adr_en <= '1';
					next_state <= east7;
				when east6 =>
					--Configure the switch
					sw_eSel <= rte_data_in(2 downto 0);				--North Neighbor (use Control from Arbiter)
					--Write to rna_ctrlPkt
					rna_ctrlPkt <= e_buffer;
					next_state <= south1;
				when east7 =>
					w_address := w_address + 1;
					reserved_cnt := reserved_cnt + 1;
					
					--Check table space
					if(reserved_cnt <= "1110") then
						table_full := '0';
					else
						table_full := '1';
					end if;
					
					rsv_en <= '0';
					sch_en <= '0';
					adr_en <= '0';
					next_state <= south1;	
	--*SOUTH*--
				when south1 =>
					--Check flag
					if(s_ctrl_flg_set = '1') then
						next_state <= south2;
					else
						next_state <= west1;
					end if;
				when south2 =>
					if(s_buffer(6 downto 3) = router_address) then
						next_state <= south3;	--It's for me!
					else
						next_state <= south4;	--Forward the control packet.
					end if;
				when south3 =>
					if(table_full = '0') then
						next_state <= south5;
					else
						next_state <= west1;
					end if;
				when south4 =>
					--Forward the Packet by checking routing table first
					address <= s_buffer(6 downto 3);
					rte_en <= '0';
					next_state <= south6;
				when south5 =>	
					--Reserve and schedule the incoming control packet
					--Ack!
					s_CTRflg <= '1', '0' after 1 ns;
					--Write bits to rsv_data_out
					rsv_data_out <= "010" & s_buffer(9 downto 7);
					--Write bits to sch_data_out
					sch_data_out <= (globaltime + s_buffer(cp_size-1 downto 18));
					--Store GID/PID in location w_address
					adr_data_out <= s_buffer(17 downto 10);
					--Send to reservation table
					address <= w_address;
					rsv_en <= '1';
					sch_en <= '1';
					adr_en <= '1';
					next_state <= south7;
				when south6 =>
					--Configure the switch
					sw_sSel <= rte_data_in(2 downto 0);				--North Neighbor (use Control from Arbiter)
					--Write to rna_ctrlPkt
					rna_ctrlPkt <= s_buffer;
					next_state <= west1;
				when south7 =>
					w_address := w_address + 1;
					reserved_cnt := reserved_cnt + 1;
					
					--Check table space
					if(reserved_cnt <= "1110") then
						table_full := '0';
					else
						table_full := '1';
					end if;
					
					rsv_en <= '0';
					sch_en <= '0';
					adr_en <= '0';
					next_state <= west1;	
	--*WEST*--
				when west1 =>
					--Check flag
					if(w_ctrl_flg_set = '1') then
						next_state <= west2;
					else
						next_state <= injection1;
					end if;
				when west2 =>
					--if(w_rnaCtrl(6 downto 3) = router_address) then
					if(w_buffer(6 downto 3) = router_address) then
						next_state <= west3;	--It's for me!
					else
						next_state <= west4;	--Forward the control packet.
					end if;
				when west3 =>
					if(table_full = '0') then
						next_state <= west5;
					else
						next_state <= injection1;
					end if;
				when west4 =>
					--Forward the Packet by checking routing table first
					--address <= w_rnaCtrl(6 downto 3);
					address <= w_buffer(6 downto 3);
					rte_en <= '0';
					next_state <= west6;
				when west5 =>	
					--Reserve and schedule the incoming control packet
					--Ack!
					w_CTRflg <= '1', '0' after 1 ns;
					--Write bits to rsv_data_out
					--rsv_data_out <= "011" & w_rnaCtrl(9 downto 7);
					rsv_data_out <= "011" & w_buffer(9 downto 7);
					--Write bits to sch_packet
					--sch_data_out <= (globaltime + w_rnaCtrl(cp_size-1 downto 18));
					sch_data_out <= (globaltime + w_buffer(cp_size-1 downto 18));
					--Store GID/PID in location w_address
					--adr_data_out <= w_rnaCtrl(17 downto 10);
					adr_data_out <= w_buffer(17 downto 10);
					--Send to reservation table
					address <= w_address;
					rsv_en <= '1';
					sch_en <= '1';
					adr_en <= '1';
					next_state <= west7;
				when west6 =>
					--Configure the switch
--					case rte_data_in(2 downto 0) is
--						when "000" =>
--							sw_nSel <= "111";			-- "00" North FIFO								
--						when "001" =>
--							sw_eSel <= "111";			-- "01" East FIFO
--						when "010" =>
--							sw_sSel <= "111";			-- "10" South FIFO
--						when "011" =>
--							sw_wSel <= "111";			-- "11" Ejection FIFO
--						when others =>												-- TO DO: Handle Ejection
--							null;
--					end case;
					
					sw_wSel <= rte_data_in(2 downto 0);				--North Neighbor (use Control from Arbiter)
					--Write to rna_ctrlPkt
					--rna_ctrlPkt <= w_rnaCtrl;
					rna_ctrlPkt <= w_buffer;
					next_state <= injection1;
				when west7 =>
					w_address := w_address + 1;
					reserved_cnt := reserved_cnt + 1;
					
					--Check table space
					if(reserved_cnt <= "1110") then
						table_full := '0';
					else
						table_full := '1';
					end if;
					
					rsv_en <= '0';
					sch_en <= '0';
					adr_en <= '0';
					w_rst <= '1', '0' after 1 ns;						--Reset flags
					next_state <= injection1;
	--*INJECTION*--
				when injection1 =>
					--Check flag
					if(sw_rnaCtFl = '1') then
						next_state <= injection2;
					else
						next_state <= timer_check1;
					end if;
				when injection2 =>
					if(injt_ctrlPkt(0) = '1') then
						next_state <= injection3;	--Control Packet
					else
						next_state <= injection6;	--Data Packet
					end if;
				when injection3 =>
					case injt_ctrlPkt(2 downto 1) is
						when "00" =>
							next_state <= injection6;	-- Condition: Normal Packet
						when "01" =>
							next_state <= injection4;	-- Condition: PE is re/assigning addresses
						when "10" =>
							next_state <= injection5;	-- Condition: PE is updating Routing Table
						when others =>
							sw_rnaCtDeq <= '1', '0' after 1 ns;		-- dequeue from FIFO
							next_state <= injection1;	-- Condition: Unknown, move to next state. (was timer_check1)
					end case;
				when injection4 =>
					router_address <= injt_ctrlPkt(21 downto 18);
					sw_rnaCtDeq <= '1', '0' after 1 ns;		-- dequeue from FIFO
					next_state <= injection1;								-- (was timer_check1)
				when injection5 =>
					address <= injt_ctrlPkt(17 downto 14);
					rte_data_out <= injt_ctrlPkt(21 downto 19);
					rte_en <= '1';
					sw_rnaCtDeq <= '1', '0' after 1 ns;		-- dequeue from FIFO
					next_state <= injection1;							-- (was timer_check1)
				when injection6 =>
					--Forward the Data Packet by checking routing table first
					address <= injt_ctrlPkt(6 downto 3);
					rte_en <= '0';
					if(injt_ctrlPkt(0) = '1') then
						next_state <= injection7;
					else
						next_state <= injection8;
					end if;
				when injection7 =>
					rna_ctrlPkt <= injt_ctrlPkt;
					--Configure the switch for CONTROL PACKETS
					case rte_data_in(2 downto 0) is
						when "000" =>
							sw_nSel <= "111";			-- "00" North FIFO								
						when "001" =>
							sw_eSel <= "111";			-- "01" East FIFO
						when "010" =>
							sw_sSel <= "111";			-- "10" South FIFO
						when "011" =>
							sw_wSel <= "111";			-- "11" West FIFO
						when others =>
							null;
					end case;
					next_state <= injection10;		--Determine if the packet registered
				when injection8 =>
					--Configure the switch for DATA PACKETS
					case rte_data_in(2 downto 0) is
						when "000" =>
							sw_nSel <= "101";			-- "00" North FIFO								
						when "001" =>
							sw_eSel <= "101";			-- "01" East FIFO
						when "010" =>
							sw_sSel <= "101";			-- "10" South FIFO
						when "011" =>
							sw_wSel <= "101";			-- "11" West FIFO
						when others =>
							null;
					end case;
					next_state <= injection10;		--Determine if the packet registered
				when injection9 =>
					next_state <= injection10;					--NOP
				when injection10 =>
					case rte_data_in(2 downto 0) is
						when "000" =>							
							if(s_ctrl_in_flg_set = '1') then				-- "10" South
								rna_CtrlPkt(0) <= '0';
								sw_sSel <= "000";
								s_rst <= '1', '0' after 1 ns;				--Reset signals
								sw_rnaCtDeq <= '1', '0' after 1 ns;		-- dequeue from FIFO
								next_state <= injection1;
							else
								next_state <= injection9;
							end if;						
						when "001" =>
							if(w_ctrl_in_flg_set = '1') then				-- "11" West
								rna_CtrlPkt(0) <= '0';
								sw_wSel <= "000";
								w_rst <= '1', '0' after 1 ns;				--Reset signals
								sw_rnaCtDeq <= '1', '0' after 1 ns;		-- dequeue from FIFO
								next_state <= injection1;
							else
								next_state <= injection9;
							end if;			
						when "010" =>
							if(n_ctrl_in_flg_set = '1') then				-- "00" North 
								rna_CtrlPkt(0) <= '0';
								sw_nSel <= "000";
								n_rst <= '1', '0' after 1 ns;				--Reset signals
								sw_rnaCtDeq <= '1', '0' after 1 ns;		-- dequeue from FIFO
								next_state <= injection1;
							else
								next_state <= injection9;
							end if;						
						when "011" =>
							if(e_ctrl_in_flg_set = '1') then				-- "01" East
								rna_CtrlPkt(0) <= '0';
								sw_eSel <= "000";
								e_rst <= '1', '0' after 1 ns;				--Reset signals
								sw_rnaCtDeq <= '1', '0' after 1 ns;		-- dequeue from FIFO
								next_state <= injection1;
							else
								next_state <= injection9;
							end if;			
						when others =>
							next_state <= injection1;
					end case;				
	--*TIMER_CHECK*--
				when timer_check1 =>
					--Check scheduled job and determine if departure is necessary.
					if(r_address /= w_address and start_timer = '0') then
						next_state <= timer_check2;
					else
						next_state <= timer_check4;
					end if;
					
					rte_en <= '0';
				when timer_check2 =>
					--Schedule the next job
					address <= r_address;
					sch_en <= '0';
					adr_en <= '0';
					rsv_en <= '0';
					next_state <= timer_check3;
				when timer_check3 =>
					--Grab time from scheduler
					next_pkt_expires_in <= sch_data_in(15 downto 0);
					
					--Grab resource reservation information that's vital for departure
					next_pkt_in_vcc <= rsv_data_in(5 downto 3);				--Which controller?
					next_pkt_in_vcell <= rsv_data_in(2 downto 0);			--Which cell within controller?
					next_pkt_departing_from_gate <= rsv_data_in(2 downto 0); --Which direction for switch? (same)
					
					start_timer <= '1';
					next_state <= dp_arrivedOnNorth1;
				when timer_check4 =>
					if(time_expired = '1') then
						start_timer <= '0';
						next_state <= departure1;
					else
						next_state <= dp_arrivedOnNorth1;
					end if;
	--*DEPARTURE*--
				when departure1 =>
					--Use the routing table info saved in next_pkt_departing_from_gate to control VCC
					case next_pkt_in_vcc is
						when "000" =>
							n_vc_rnaSelO <= next_pkt_in_vcell(1 downto 0);			-- "00" North FIFO 
							n_vc_deq <= '1', '0' after 1 ns;
							sw_nSel <= next_pkt_departing_from_gate;									
						when "001" =>
							e_vc_rnaSelO <= next_pkt_in_vcell(1 downto 0);			-- "01" East FIFO
							e_vc_deq <= '1', '0' after 1 ns;
							sw_eSel <= next_pkt_departing_from_gate;
						when "010" =>
							s_vc_rnaSelO <= next_pkt_in_vcell(1 downto 0);			-- "10" South FIFO
							s_vc_deq <= '1', '0' after 1 ns;
							sw_sSel <= next_pkt_departing_from_gate;
						when "011" =>
							w_vc_rnaSelO <= next_pkt_in_vcell(1 downto 0);			-- "11" West FIFO
							w_vc_deq <= '1', '0' after 1 ns;
							sw_wSel <= next_pkt_departing_from_gate;
						when others =>											-- TO DO: Handle Ejection
							null;
					end case;
							
					
					--Check CTR going high to low
					--wait until falling_edge(n_CTRflg);
					
					--Update Space in Reservation Table now that packet has departed
					r_address := r_address + 1;
					reserved_cnt := reserved_cnt - 1;
					
					--Check table space
					if(reserved_cnt <= "1110") then
						table_full := '0';
					else
						table_full := '1';
					end if;
					next_state <= dp_arrivedOnNorth1;
	--*NORTH ARRIVALS*--
				when dp_arrivedOnNorth1 =>
					--Any new data packets?
					if(n_DataFlg = '1') then
						next_state <= dp_arrivedOnNorth2;
					else
						next_state <= dp_arrivedOnEast1;
					end if;
				when dp_arrivedOnNorth2 =>
					--Search address table for matching GID/PID
					adr_search <= '1';
					adr_data_out <= n_rnaCtrl(17 downto 10);
					next_state <= dp_arrivedOnNorth3;
				when dp_arrivedOnNorth3 =>	
					if(adr_nf = '1') then
						next_state <= dp_arrivedOnNorth4;
					else
						next_state <= dp_arrivedOnNorth5;
					end if;
				when dp_arrivedOnNorth4 =>
					--Acknowledge back (discarding packet)
					adr_search <= '0';
					adr_nf_ack <= '1', '0' after 1 ns;
					n_CTRflg <= '1', '0' after 1 ns;
					next_state <= dp_arrivedOnEast1;
				when dp_arrivedOnNorth5 =>
					address <= adr_result;			--should be the address found above
					adr_search <= '0';
					rsv_en <= '0';
					next_state <= dp_arrivedOnNorth6;
				when dp_arrivedOnNorth6 =>
					--Control VCC
					n_vc_rnaSelI <= rsv_data_in(1 downto 0);			--Value from RSV TABLE (PATH)
					
					--Acknowledge
					n_CTRflg <= '1';
					n_arbEnq <= '1';
					next_state <= dp_arrivedOnNorth7;
				when dp_arrivedOnNorth7 =>
					n_CTRflg <= '0';
					n_arbEnq <= '0';
					next_state <= dp_arrivedOnEast1;
	--*EAST ARRIVALS*--
				when dp_arrivedOnEast1 =>
					--Any new data packets?
					if(e_DataFlg = '1') then
						next_state <= dp_arrivedOnEast2;
					else
						next_state <= dp_arrivedOnSouth1;
					end if;
				when dp_arrivedOnEast2 =>
					--Search address table for matching GID/PID
					adr_search <= '1';
					adr_data_out <= e_rnaCtrl(17 downto 10);
					next_state <= dp_arrivedOnEast3;
				when dp_arrivedOnEast3 =>	
					if(adr_nf = '1') then
						next_state <= dp_arrivedOnEast4;
					else
						next_state <= dp_arrivedOnEast5;
					end if;
				when dp_arrivedOnEast4 =>
					--Acknowledge back (discarding packet)
					adr_search <= '0';
					adr_nf_ack <= '1', '0' after 1 ns;
					e_CTRflg <= '1', '0' after 1 ns;
					next_state <= dp_arrivedOnSouth1;
				when dp_arrivedOnEast5 =>
					address <= adr_result;			--should be the address found above
					adr_search <= '0';
					rsv_en <= '0';
					next_state <= dp_arrivedOnEast6;
				when dp_arrivedOnEast6 =>
					--Control VCC
					e_vc_rnaSelI <= rsv_data_in(1 downto 0);			--Value from RSV TABLE (PATH)
					
					--Acknowledge
					e_CTRflg <= '1';
					e_arbEnq <= '1';
					next_state <= dp_arrivedOnEast7;
				when dp_arrivedOnEast7 =>
					e_CTRflg <= '0';
					e_arbEnq <= '0';
					next_state <= dp_arrivedOnSouth1;
	--*SOUTH ARRIVALS*--
				when dp_arrivedOnSouth1 =>
					--Any new data packets?
					if(s_DataFlg = '1') then
						next_state <= dp_arrivedOnSouth2;
					else
						next_state <= dp_arrivedOnWest1;
					end if;
				when dp_arrivedOnSouth2 =>
					--Search address table for matching GID/PID
					adr_search <= '1';
					adr_data_out <= s_rnaCtrl(17 downto 10);
					next_state <= dp_arrivedOnSouth3;
				when dp_arrivedOnSouth3 =>	
					if(adr_nf = '1') then
						next_state <= dp_arrivedOnSouth4;
					else
						next_state <= dp_arrivedOnSouth5;
					end if;
				when dp_arrivedOnSouth4 =>
					--Acknowledge back (discarding packet)
					adr_search <= '0';
					adr_nf_ack <= '1', '0' after 1 ns;
					s_CTRflg <= '1', '0' after 1 ns;
					next_state <= dp_arrivedOnWest1;
				when dp_arrivedOnSouth5 =>
					address <= adr_result;			--should be the address found above
					adr_search <= '0';
					rsv_en <= '0';
					next_state <= dp_arrivedOnSouth6;
				when dp_arrivedOnSouth6 =>
					--Control VCC
					s_vc_rnaSelI <= rsv_data_in(1 downto 0);			--Value from RSV TABLE (PATH)
					
					--Acknowledge
					s_CTRflg <= '1'; 
					s_arbEnq <= '1';
					next_state <= dp_arrivedOnSouth7;
				when dp_arrivedOnSouth7 =>
					s_CTRflg <= '0';
					s_arbEnq <= '0';
					next_state <= dp_arrivedOnWest1;
	--*WEST ARRIVALS*--
				when dp_arrivedOnWest1 =>
					--Any new data packets?
					if(w_data_flg_set = '1') then
						w_rst <= '1', '0' after 1 ns;
						next_state <= dp_arrivedOnWest2;
					else
						next_state <= north1;
					end if;
				when dp_arrivedOnWest2 =>
					--Search address table for matching GID/PID
					adr_search <= '1';
					--adr_data_out <= w_rnaCtrl(17 downto 10);
					adr_data_out <= w_buffer(17 downto 10);
					next_state <= dp_arrivedOnWest3;
				when dp_arrivedOnWest3 =>	
					if(adr_nf = '1') then
						next_state <= dp_arrivedOnWest4;
					else
						next_state <= dp_arrivedOnWest5;
					end if;
				when dp_arrivedOnWest4 =>
					--Acknowledge back (discarding packet)
					adr_search <= '0';
					adr_nf_ack <= '1', '0' after 1 ns;
					--w_CTRflg <= '1', '0' after 1 ns;
					next_state <= north1;
				when dp_arrivedOnWest5 =>
					address <= adr_result;			--should be the address found above
					adr_search <= '0';
					rsv_en <= '0';
					next_state <= dp_arrivedOnWest6;
				when dp_arrivedOnWest6 =>
					--Control VCC
					w_vc_rnaSelI <= rsv_data_in(1 downto 0);			--Value from RSV TABLE (PATH)
					
					--Acknowledge
					w_CTRflg <= '1'; --'0' after 1 ns;
					w_arbEnq <= '1'; --'0' after 1 ns;
					next_state <= dp_arrivedOnWest7;
				when dp_arrivedOnWest7 =>
					w_CTRflg <= '0';
					w_arbEnq <= '0';
					next_state <= north1;
				when others =>
					next_state <= north1;
			end case;
	end process;
	
	--Monitors signal activity on NORTH port
	north_monitor_process: process(n_rst, n_CtrlFlg, n_DataFlg, s_CTRinFlg)
	begin
		if(n_rst = '1') then
			n_data_flg_set <= '0';
			n_ctrl_flg_set <= '0';
			n_ctrl_in_flg_set <= '0';
		end if;
		
		if(n_DataFlg = '1') then
			n_data_flg_set <= '1';
			n_buffer <= n_rnaCtrl;
		end if;
		
		if(n_CtrlFlg = '1') then
			n_ctrl_flg_set <= '1';
			n_buffer <= w_rnaCtrl;
		end if;
		
		if(s_CTRinFlg = '1') then
			n_ctrl_in_flg_set <= '1';
		end if;
		
	end process;
	
	--Monitors signal activity on EAST port
	east_monitor_process: process(e_rst, e_CtrlFlg, e_DataFlg, w_CTRinFlg)
	begin
		if(e_rst = '1') then
			e_data_flg_set <= '0';
			e_ctrl_flg_set <= '0';
			e_ctrl_in_flg_set <= '0';
		end if;
		
		if(e_DataFlg = '1') then
			e_data_flg_set <= '1';
			e_buffer <= e_rnaCtrl;
		end if;
		
		if(e_CtrlFlg = '1') then
			e_ctrl_flg_set <= '1';
			e_buffer <= e_rnaCtrl;
		end if;
		
		if(w_CTRinFlg = '1') then
			e_ctrl_in_flg_set <= '1';
		end if;
		
	end process;
	
	--Monitors signal activity on SOUTH port
	south_monitor_process: process(s_rst, s_CtrlFlg, s_DataFlg, n_CTRinFlg)
	begin
		if(s_rst = '1') then
			s_data_flg_set <= '0';
			s_ctrl_flg_set <= '0';
			s_ctrl_in_flg_set <= '0';
		end if;
		
		if(s_DataFlg = '1') then
			s_data_flg_set <= '1';
			s_buffer <= s_rnaCtrl;
		end if;
		
		if(s_CtrlFlg = '1') then
			s_ctrl_flg_set <= '1';
			s_buffer <= s_rnaCtrl;
		end if;
		
		if(n_CTRinFlg = '1') then
			s_ctrl_in_flg_set <= '1';
		end if;
		
	end process;
	
	--Monitors signal activity on WEST port
	west_monitor_process: process(w_rst, w_CtrlFlg, w_DataFlg, e_CTRinFlg)
	begin
		if(w_rst = '1') then
			w_data_flg_set <= '0';
			w_ctrl_flg_set <= '0';
			w_ctrl_in_flg_set <= '0';
		end if;
		
		if(w_DataFlg = '1') then
			w_data_flg_set <= '1';
			w_buffer <= w_rnaCtrl;
		end if;
		
		if(w_CtrlFlg = '1') then
			w_ctrl_flg_set <= '1';
			w_buffer <= w_rnaCtrl;
		end if;
		
		if(e_CTRinFlg = '1') then
			w_ctrl_in_flg_set <= '1';
		end if;
		
	end process;
	
end Behavioral;

