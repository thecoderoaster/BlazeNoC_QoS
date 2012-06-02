		--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:06:01 02/03/2012
-- Design Name:   
-- Module Name:   C:/Users/kor/Documents/BlazeNoC_QoS/BlazeNoC_QoS_TB.vhd
-- Project Name:  BlazeNoC_QoS
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BlazeNoC
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.router_library.all;

use std.textio.all;
 

ENTITY BlazeNoC_QoS_TB IS
END BlazeNoC_QoS_TB;
 
ARCHITECTURE behavior OF BlazeNoC_QoS_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BlazeNoC
    PORT(
         clk_rte : IN  std_logic;
         clk_pe : IN std_logic;
			reset : IN  std_logic;
         sm_triggerPE0 : IN  std_logic;
         sm_triggerPE1 : IN  std_logic;
         sm_triggerPE2 : IN  std_logic;
         sm_triggerPE3 : IN  std_logic;
         full_PE0 : OUT  std_logic;
         full_PE1 : OUT  std_logic;
         full_PE2 : OUT  std_logic;
         full_PE3 : OUT  std_logic;
         done_PE0 : OUT  std_logic;
         done_PE1 : OUT  std_logic;
         done_PE2 : OUT  std_logic;
         done_PE3 : OUT  std_logic;
			ej_readyPE0 : OUT std_logic;
			ej_readyPE1 : OUT std_logic;
			ej_readyPE2 : OUT std_logic;
			ej_readyPE3 : OUT std_logic;
         data_inject_PE0 : IN  std_logic_vector(57 downto 0);
         data_inject_PE1 : IN  std_logic_vector(57 downto 0);
         data_inject_PE2 : IN  std_logic_vector(57 downto 0);
         data_inject_PE3 : IN  std_logic_vector(57 downto 0);
			data_eject_PE0	 : OUT std_logic_vector(57 downto 0);
			data_eject_PE1	 : OUT std_logic_vector(57 downto 0);
			data_eject_PE2	 : OUT std_logic_vector(57 downto 0);
			data_eject_PE3	 : OUT std_logic_vector(57 downto 0)
        );
    END COMPONENT;
    
	-- function to convert vector to string
	FUNCTION vec2str(vec : std_logic_vector) RETURN string IS
		VARIABLE stmp : string(vec'LEFT+1 DOWNTO 1); 
	BEGIN
		FOR i IN vec'REVERSE_RANGE LOOP 
			IF vec(i) = '1' THEN
				stmp(i+1) := '1';
			ELSIF vec(i) = '0' THEN
				stmp(i+1) := '0';
			ELSE
				stmp(i+1) := 'X';
			END IF;
		END LOOP;
		RETURN stmp;
	END vec2str;



   --Inputs
   signal clk_rte : std_logic := '0';
	signal clk_pe : std_logic := '0';
   signal reset : std_logic := '0';
   signal sm_triggerPE0 : std_logic := '0';
   signal sm_triggerPE1 : std_logic := '0';
   signal sm_triggerPE2 : std_logic := '0';
   signal sm_triggerPE3 : std_logic := '0';
   signal data_inject_PE0 : std_logic_vector(57 downto 0) := (others => '0');
   signal data_inject_PE1 : std_logic_vector(57 downto 0) := (others => '0');
   signal data_inject_PE2 : std_logic_vector(57 downto 0) := (others => '0');
   signal data_inject_PE3 : std_logic_vector(57 downto 0) := (others => '0');

 	--Outputs
   signal full_PE0 : std_logic;
   signal full_PE1 : std_logic;
   signal full_PE2 : std_logic;
   signal full_PE3 : std_logic;
   signal done_PE0 : std_logic;
   signal done_PE1 : std_logic;
   signal done_PE2 : std_logic;
   signal done_PE3 : std_logic;
	signal ej_readyPE0 : std_logic;
	signal ej_readyPE1 : std_logic;
	signal ej_readyPE2 : std_logic;
	signal ej_readyPE3 : std_logic;
	signal data_eject_PE0 : std_logic_vector(57 downto 0);
   signal data_eject_PE1 : std_logic_vector(57 downto 0);
   signal data_eject_PE2 : std_logic_vector(57 downto 0);
   signal data_eject_PE3 : std_logic_vector(57 downto 0);
	
	--Signals for Testing
	signal router_setup 		: std_logic;
	
	--Router 0
	signal reset_RT0			: std_logic;
	signal trigger_0_cp 		: std_logic;
	signal trigger_0_dp	   : std_logic;
	signal pe0_Ready			: std_logic;
	signal tid_RT0 			: std_logic_vector(SCH_WIDTH-1 downto 0);
	signal dir_3_RT0			: std_logic_vector(RSV_WIDTH-1 downto 0);
	signal dir_2_RT0			: std_logic_vector(RSV_WIDTH-1 downto 0);
	signal dir_1_RT0			: std_logic_vector(RSV_WIDTH-1 downto 0);
	signal dir_0_RT0			: std_logic_vector(RSV_WIDTH-1 downto 0);
	signal count_RT0			: std_logic_vector(1 downto 0);
	signal pid_RT0				: std_logic_vector(5 downto 0);
	signal packet_type_RT0	: std_logic_vector(1 downto 0);
	signal priority_RT0		: std_logic;
	
	--Router 1
	signal reset_RT1			: std_logic;
	signal trigger_1_cp 		: std_logic;
	signal trigger_1_dp	   : std_logic;
	signal pe1_Ready			: std_logic;
	signal tid_RT1 			: std_logic_vector(SCH_WIDTH-1 downto 0);
	signal dir_3_RT1			: std_logic_vector(RSV_WIDTH-1 downto 0);
	signal dir_2_RT1			: std_logic_vector(RSV_WIDTH-1 downto 0);
	signal dir_1_RT1			: std_logic_vector(RSV_WIDTH-1 downto 0);
	signal dir_0_RT1			: std_logic_vector(RSV_WIDTH-1 downto 0);
	signal count_RT1			: std_logic_vector(1 downto 0);
	signal pid_RT1				: std_logic_vector(5 downto 0);
	signal packet_type_RT1	: std_logic_vector(1 downto 0);
	signal priority_RT1		: std_logic;
	
	--Router 2
	signal reset_RT2			: std_logic;
	signal trigger_2_cp 		: std_logic;
	signal trigger_2_dp	   : std_logic;
	signal pe2_Ready			: std_logic;
	signal tid_RT2 			: std_logic_vector(SCH_WIDTH-1 downto 0);
	signal dir_3_RT2			: std_logic_vector(RSV_WIDTH-1 downto 0);
	signal dir_2_RT2			: std_logic_vector(RSV_WIDTH-1 downto 0);
	signal dir_1_RT2			: std_logic_vector(RSV_WIDTH-1 downto 0);
	signal dir_0_RT2			: std_logic_vector(RSV_WIDTH-1 downto 0);
	signal count_RT2			: std_logic_vector(1 downto 0);
	signal pid_RT2				: std_logic_vector(5 downto 0);
	signal packet_type_RT2	: std_logic_vector(1 downto 0);
	signal priority_RT2		: std_logic;
	
	--Router 3
	signal reset_RT3			: std_logic;
	signal trigger_3_cp 		: std_logic;
	signal trigger_3_dp	   : std_logic;
	signal pe3_Ready			: std_logic;
	signal tid_RT3 			: std_logic_vector(SCH_WIDTH-1 downto 0);
	signal dir_3_RT3			: std_logic_vector(RSV_WIDTH-1 downto 0);
	signal dir_2_RT3			: std_logic_vector(RSV_WIDTH-1 downto 0);
	signal dir_1_RT3			: std_logic_vector(RSV_WIDTH-1 downto 0);
	signal dir_0_RT3			: std_logic_vector(RSV_WIDTH-1 downto 0);
	signal count_RT3			: std_logic_vector(1 downto 0);
	signal pid_RT3				: std_logic_vector(5 downto 0);
	signal packet_type_RT3	: std_logic_vector(1 downto 0);
	signal priority_RT3		: std_logic;
	
	--Result Files for each Router
	file rt0_results_file : text open write_mode is "rt0_results_file.txt";
	file rt1_results_file : text open write_mode is "rt1_results_file.txt";
	file rt2_results_file : text open write_mode is "rt2_results_file.txt";
	file rt3_results_file : text open write_mode is "rt3_results_file.txt";
	
   -- Clock period definitions
   constant clk_period : time := 10 ns;
	constant clk_period_pe : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BlazeNoC PORT MAP (
          clk_rte => clk_rte,
			 clk_pe => clk_pe,
          reset => reset,
          sm_triggerPE0 => sm_triggerPE0,
          sm_triggerPE1 => sm_triggerPE1,
          sm_triggerPE2 => sm_triggerPE2,
          sm_triggerPE3 => sm_triggerPE3,
          full_PE0 => full_PE0,
          full_PE1 => full_PE1,
          full_PE2 => full_PE2,
          full_PE3 => full_PE3,
          done_PE0 => done_PE0,
          done_PE1 => done_PE1,
          done_PE2 => done_PE2,
          done_PE3 => done_PE3,
			 ej_readyPE0 => ej_readyPE0,
			 ej_readyPE1 => ej_readyPE1,
			 ej_readyPE2 => ej_readyPE2,
			 ej_readyPE3 => ej_readyPE3,
          data_inject_PE0 => data_inject_PE0,
          data_inject_PE1 => data_inject_PE1,
          data_inject_PE2 => data_inject_PE2,
          data_inject_PE3 => data_inject_PE3,
			 data_eject_PE0 => data_eject_PE0,
          data_eject_PE1 => data_eject_PE1,
          data_eject_PE2 => data_eject_PE2,
          data_eject_PE3 => data_eject_PE3
        );
		  
	
   -- Clock process definitions
   clk_rte_process :process
   begin
		clk_rte <= '0';
		wait for clk_period/2;
		clk_rte <= '1';
		wait for clk_period/2;
   end process;
 
 
	-- Clock process definitions
   clk_pe_process :process
   begin
		clk_pe <= '0';
		wait for clk_period_pe/2;
		clk_pe <= '1';
		wait for clk_period_pe/2;
   end process;
 
--******************--
--**NOC SETUP**--
--******************-- 
	noc_setup: process
	begin
		-- hold reset state for 100 ns.
		router_setup <= '0';
      reset <= '0';
		
		--Initiate a Reset		
		wait for clk_period_pe*2;
		reset <= '1', '0' after clk_period_pe;
	
      wait for clk_period_pe*10;
		
		router_setup <= '1', '0' after clk_period_pe*4;
		
		wait;
		
	end process;
 
	
--**********************--	
--** MAIN PROCESS_RT0 **--
--**********************-- 
	main_proc_RT0: process
		variable router_start		: std_logic;
		variable my_pid : std_logic_vector(5 downto 0) := "000000";
		variable buf_out : line;
		variable buf_file : line;
	begin
		if(router_setup = '1') then
			trigger_0_cp <= '0';
			trigger_0_dp <= '0';
			reset_RT0 <= '0';
			router_start := '0';
			
			--Wait
			wait for clk_period_pe*2;
			
			-- Resets Internal Counters			
			reset_RT0 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*2;
			
--			--******************************--
--			--**Setup Router Watchdog Seed**--
--			--******************************--
--			tid_RT0 <= "0000000000001111";				--Router 0
--			rsv_port_RT0 <= "000";
--			dst_address_RT0 <= "0000";
--			packet_type_RT0 <= "11";
--			trigger_0_cp <= '1', '0' after 1 ns;
--			
--			wait until pe0_Ready = '1';
--			wait for clk_period_pe*2;
--			
--			-- Resets Internal Counters
--			reset_RT0 <= '1', '0' after 1 ns;
--			
--			wait for clk_period_pe*4;
			
			--Write to file
			write(buf_out, string'("--------------------------------------------------------------------"));
			write(buf_file, string'("--------------------------------------------------------------------"));
			writeline(output, buf_out);
			writeline(rt0_results_file, buf_file);
			write(buf_out, string'("Router 0 Testbench Results"));
			write(buf_file, string'("Router 0 Testbench Results"));
			writeline(output, buf_out);
			writeline(rt0_results_file, buf_file);
			write(buf_out, string'("Setup completed @ t = "));
			write(buf_out, now);
			write(buf_file, string'("Setup completed @ t = "));
			write(buf_file, now);
			writeline(output, buf_out);
			writeline(rt0_results_file, buf_file);
			write(buf_out, string'("--------------------------------------------------------------------"));
			write(buf_file, string'("--------------------------------------------------------------------"));
			writeline(output, buf_out);
			writeline(rt0_results_file, buf_file);
			
			
			router_start := '1';
		end if;
	
		if(router_start = '1') then
			
			--Send a control packet	
			tid_RT0 <= "00000000000000000000000010000011";
			dir_3_RT0 <= "000";		--Not used
			dir_2_RT0 <= "111";		--Eject
			dir_1_RT0 <= "010";		--South
			dir_0_RT0 <= "001";		--East
			count_RT0 <= "00";		--Default
			pid_RT0 <= "000000";		--Packet ID
			packet_type_RT0 <= "00";
			priority_RT0 <= '0';
			trigger_0_cp <= '1', '0' after 1 ns;
			
				
			wait for clk_period_pe*5;
			
			--Send a control packet
			tid_RT0 <= "00000000000000000000000010011011";
			dir_3_RT0 <= "000";		--Not used
			dir_2_RT0 <= "111";		--Eject
			dir_1_RT0 <= "010";		--South
			dir_0_RT0 <= "001";		--East
			count_RT0 <= "00";		--Default
			pid_RT0 <= "000001";		--Packet ID
			packet_type_RT0 <= "00";
			priority_RT0 <= '0';
			trigger_0_cp <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*10;
						
			-- Resets Internal Counters			
			reset_RT0 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*20;
			
			--Send its data packet (Low Priority)
			tid_RT0 <= "00000000000000000000000000000000";
			dir_3_RT0 <= "000";		--Not used
			dir_2_RT0 <= "111";		--Eject
			dir_1_RT0 <= "010";		--South
			dir_0_RT0 <= "001";		--East
			count_RT0 <= "00";		--Default
			pid_RT0 <= "000000";		--Packet ID
			packet_type_RT0 <= "00";
			priority_RT0 <= '0';
			trigger_0_dp <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*20;
			
			--Send its data packet (Low Priority)
			tid_RT0 <= "00000100000000000000000000000000";
			dir_3_RT0 <= "000";		--Not used
			dir_2_RT0 <= "111";		--Eject
			dir_1_RT0 <= "010";		--South
			dir_0_RT0 <= "001";		--East
			count_RT0 <= "00";		--Default
			pid_RT0 <= "000001";		--Packet ID
			packet_type_RT0 <= "00";
			priority_RT0 <= '0';
			trigger_0_dp <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*20;
			
			--Send control packet
			tid_RT0 <= "00000000000000000000011110001000";
			dir_3_RT0 <= "000";		--Not used
			dir_2_RT0 <= "111";		--Eject
			dir_1_RT0 <= "010";		--South
			dir_0_RT0 <= "001";		--East
			count_RT0 <= "00";		--Default
			pid_RT0 <= "000010";		--Packet ID
			packet_type_RT0 <= "00";
			priority_RT0 <= '0';
			trigger_0_cp <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*20;
				
			--Send control packet
			tid_RT0 <= "00000000000000000000000111110000";
			dir_3_RT0 <= "000";		--Not used
			dir_2_RT0 <= "111";		--Eject
			dir_1_RT0 <= "010";		--South
			dir_0_RT0 <= "001";		--East
			count_RT0 <= "00";		--Default
			pid_RT0 <= "000011";		--Packet ID
			packet_type_RT0 <= "00";
			priority_RT0 <= '0';
			trigger_0_cp <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*20;

			--Send its data packet (Low Priority)
			tid_RT0 <= "00001000000000000000000000000000";
			dir_3_RT0 <= "000";		--Not used
			dir_2_RT0 <= "111";		--Eject
			dir_1_RT0 <= "010";		--South
			dir_0_RT0 <= "001";		--East
			count_RT0 <= "00";		--Default
			pid_RT0 <= "000010";		--Packet ID
			packet_type_RT0 <= "00";
			priority_RT0 <= '0';
			trigger_0_dp <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*20;
			
			--Send its data packet (High Priority)
			tid_RT0 <= "00001100000000000000000000000111";
			dir_3_RT0 <= "000";		--Not used
			dir_2_RT0 <= "111";		--Eject
			dir_1_RT0 <= "010";		--South
			dir_0_RT0 <= "001";		--East
			count_RT0 <= "00";		--Default
			pid_RT0 <= "000011";		--Packet ID
			packet_type_RT0 <= "00";
			priority_RT0 <= '1';
			trigger_0_dp <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*20;

			--Send control packet
			tid_RT0 <= "00000000000000000000000111111000";
			dir_3_RT0 <= "000";		--Not used
			dir_2_RT0 <= "111";		--Eject
			dir_1_RT0 <= "010";		--South
			dir_0_RT0 <= "001";		--East
			count_RT0 <= "00";		--Default
			pid_RT0 <= "000100";		--Packet ID
			packet_type_RT0 <= "00";
			priority_RT0 <= '0';
			trigger_0_cp <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*20;
			
			--Send control packet
			tid_RT0 <= "00000000000000000000111010001111";
			dir_3_RT0 <= "000";		--Not used
			dir_2_RT0 <= "111";		--Eject
			dir_1_RT0 <= "010";		--South
			dir_0_RT0 <= "001";		--East
			count_RT0 <= "00";		--Default
			pid_RT0 <= "001000";		--Packet ID
			packet_type_RT0 <= "00";
			priority_RT0 <= '0';
			trigger_0_cp <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*20;
			
			--Send its data packet (Low Priority)
			tid_RT0 <= "00100100000000000000000000000000";
			dir_3_RT0 <= "000";		--Not used
			dir_2_RT0 <= "111";		--Eject
			dir_1_RT0 <= "010";		--South
			dir_0_RT0 <= "001";		--East
			count_RT0 <= "00";		--Default
			pid_RT0 <= "001000";		--Packet ID
			packet_type_RT0 <= "00";
			priority_RT0 <= '1';
			trigger_0_dp <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*10;
			
			--Send its data packet (Low Priority)
			tid_RT0 <= "00100100000000000000000000000000";
			dir_3_RT0 <= "000";		--Not used
			dir_2_RT0 <= "111";		--Eject
			dir_1_RT0 <= "010";		--South
			dir_0_RT0 <= "001";		--East
			count_RT0 <= "00";		--Default
			pid_RT0 <= "000100";		--Packet ID
			packet_type_RT0 <= "00";
			priority_RT0 <= '1';
			trigger_0_dp <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*20;
			
			--Send control packet
			tid_RT0 <= "00000000000000000000001101100001";
			dir_3_RT0 <= "000";		--Not used
			dir_2_RT0 <= "111";		--Eject
			dir_1_RT0 <= "010";		--South
			dir_0_RT0 <= "001";		--East
			count_RT0 <= "00";		--Default
			pid_RT0 <= "000111";		--Packet ID
			packet_type_RT0 <= "00";
			priority_RT0 <= '0';
			trigger_0_cp <= '1', '0' after 1 ns;
		
			wait for clk_period_pe*40;
			
			--Send its data packet (High Priority)
			tid_RT0 <= "10000000000000000000000000000001";
			dir_3_RT0 <= "000";		--Not used
			dir_2_RT0 <= "111";		--Eject
			dir_1_RT0 <= "010";		--South
			dir_0_RT0 <= "001";		--East
			count_RT0 <= "00";		--Default
			pid_RT0 <= "000111";		--Packet ID
			packet_type_RT0 <= "00";
			priority_RT0 <= '1';
			trigger_0_dp <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*20;
			
			--Done
			router_start := '0';	
		else
			wait for clk_period_pe*2;
			
		end if;
		
	end process;
	
--**********************--	
--** MAIN PROCESS_RT1 **--
--**********************-- 
	main_proc_RT1: process
		variable router_start		: std_logic;
		variable my_pid : std_logic_vector(5 downto 0) := "000000";
		variable buf_out : line;
		variable buf_file : line;
	begin
		if(router_setup = '1') then
			trigger_1_cp <= '0';
			trigger_1_dp <= '0';
			reset_RT1 <= '0';
			router_start := '0';
			
			--Wait
			wait for clk_period_pe*2;
			
			-- Resets Internal Counters			
			reset_RT1 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*2;
			
--			--******************************--
--			--**Setup Router Watchdog Seed**--
--			--******************************--
--			tid_RT1 <= "0000000001000000";				--Router 1
--			rsv_port_RT1 <= "000";
--			dst_address_RT1 <= "0000";
--			packet_type_RT1 <= "11";
--			trigger_1_cp <= '1', '0' after 1 ns;
--			
--			wait until pe1_Ready = '1';
--			wait for clk_period_pe*2;
--			
--			-- Resets Internal Counters
--			reset_RT1<= '1', '0' after 1 ns;
--			
--			wait for clk_period_pe*4;
			
			
			--Write to file
			write(buf_out, string'("--------------------------------------------------------------------"));
			write(buf_file, string'("--------------------------------------------------------------------"));
			writeline(output, buf_out);
			writeline(rt1_results_file, buf_file);
			write(buf_out, string'("Router 1 Testbench Results"));
			write(buf_file, string'("Router 1 Testbench Results"));
			writeline(output, buf_out);
			writeline(rt1_results_file, buf_file);
			write(buf_out, string'("Setup completed @ t = "));
			write(buf_out, now);
			write(buf_file, string'("Setup completed @ t = "));
			write(buf_file, now);
			writeline(output, buf_out);
			writeline(rt1_results_file, buf_file);
			write(buf_out, string'("--------------------------------------------------------------------"));
			write(buf_file, string'("--------------------------------------------------------------------"));
			writeline(output, buf_out);
			writeline(rt1_results_file, buf_file);
			
			router_start := '1';
		end if;
	
		if(router_start = '1') then
			
			reset_RT1 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*2;
			
			loop
				if(full_PE1 = '0') then
					--Send GARBAGE data to Router 3
					--Send control packet
					tid_RT1 <= "00000000000000100000000000001110";
					dir_3_RT1 <= "000";		--Not used
					dir_2_RT1 <= "000";		--Not used
					dir_1_RT1 <= "111";		--Eject
					dir_0_RT1 <= "010";		--South
					count_RT1 <= "00";		--Default
					pid_RT1 <= my_pid;		--Packet ID
					packet_type_RT1 <= "01";
					priority_RT1 <= '0';
					trigger_1_cp <= '1', '0' after 1 ns;
				
					wait for clk_period_pe*20000;

					--Send its data packet (Low Priority)
					tid_RT1 <= "00001000000000000000000000000000";
					dir_3_RT1 <= "000";		--Not used
					dir_2_RT1 <= "000";		--Not used
					dir_1_RT1 <= "111";		--Eject
					dir_0_RT1 <= "010";		--South
					count_RT1 <= "00";		--Default
					pid_RT1 <= my_pid;		--Packet ID
					packet_type_RT1 <= "01";
					priority_RT1 <= '0';
					trigger_1_dp <= '1', '0' after 1 ns;
					
					wait for clk_period_pe*20;
					
					--wait until pe1_Ready = '1';
					
					--reset_RT1 <= '1', '0' after 1 ns;
					
					wait for clk_period_pe*750;
					
					my_pid := my_pid + 1;
				else
					write(buf_out, string'("Router 1 Loop (BLOCKED): PE1 reports FULL BUFFER!"));
					writeline(output, buf_out);
					wait for clk_period_pe*20;
				end if;
				end loop;
			--Done
			router_start := '0';	
			
		else
			wait for clk_period_pe*2;
			
		end if;
		
	end process;

--**********************--	
--** MAIN PROCESS_RT2 **--
--**********************-- 
	main_proc_RT2: process
		variable router_start		: std_logic;
		variable buf_out : line;
		variable buf_file : line;
	begin
		if(router_setup = '1') then
			trigger_2_cp <= '0';
			trigger_2_dp <= '0';
			reset_RT2 <= '0';
			router_start := '0';
			
			--Wait
			wait for clk_period_pe*2;
			
			-- Resets Internal Counters			
			reset_RT2 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*2;
			
--			--******************************--
--			--**Setup Router Watchdog Seed**--
--			--******************************--
--			tid_RT2 <= "0000000000001001";				--Router 2
--			rsv_port_RT2 <= "000";
--			dst_address_RT2 <= "0000";
--			packet_type_RT2 <= "11";
--			trigger_2_cp <= '1', '0' after 1 ns;
--			
--			wait until pe2_Ready = '1';
--			wait for clk_period_pe*2;
--			
--			-- Resets Internal Counters
--			reset_RT2 <= '1', '0' after 1 ns;
--			
--			wait for clk_period_pe*4;
	
			--Write to file
			write(buf_out, string'("--------------------------------------------------------------------"));
			write(buf_file, string'("--------------------------------------------------------------------"));
			writeline(output, buf_out);
			writeline(rt2_results_file, buf_file);
			write(buf_out, string'("Router 2 Testbench Results"));
			write(buf_file, string'("Router 2 Testbench Results"));
			writeline(output, buf_out);
			writeline(rt2_results_file, buf_file);
			write(buf_out, string'("Setup completed @ t = "));
			write(buf_out, now);
			write(buf_file, string'("Setup completed @ t = "));
			write(buf_file, now);
			writeline(output, buf_out);
			writeline(rt2_results_file, buf_file);
			write(buf_out, string'("--------------------------------------------------------------------"));
			write(buf_file, string'("--------------------------------------------------------------------"));
			writeline(output, buf_out);
			writeline(rt2_results_file, buf_file);
			
			router_start := '1';
		end if;
	
		if(router_start = '1') then
						
--			loop
--				--Send GARBAGE data to Router 3
--				rsv_port_RT2 <= "010";
--				dst_address_RT2 <= "0000";
--				packet_type_RT2 <= "00";
--				trigger_2_dp <= '1', '0' after 1 ns;
--				wait until pe2_Ready = '1';
--			end loop;
			--Done
			router_start := '0';	
			
		else
			wait for clk_period_pe*2;
			
		end if;
		
	end process;
	
--**********************--	
--** MAIN PROCESS_RT3 **--
--**********************-- 
	main_proc_RT3: process
		variable router_start		: std_logic;
		variable buf_out : line;
		variable buf_file : line;
	begin
		if(router_setup = '1') then
			trigger_3_cp <= '0';
			trigger_3_dp <= '0';
			reset_RT2 <= '0';
			router_start := '0';
			
			--Wait
			wait for clk_period_pe*2;
			
			-- Resets Internal Counters			
			reset_RT3 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*2;
			
--			--******************************--
--			--**Setup Router Watchdog Seed**--
--			--******************************--
--			tid_RT3 <= "0000000000011001";				--Router 3
--			rsv_port_RT3 <= "000";
--			dst_address_RT3 <= "0000";
--			packet_type_RT3 <= "11";
--			trigger_3_cp <= '1', '0' after 1 ns;
--			
--			wait until pe3_Ready = '1';
--			wait for clk_period_pe*2;
--			
--			-- Resets Internal Counters
--			reset_RT3 <= '1', '0' after 1 ns;
--			
--			wait for clk_period_pe*4;
			
			--Write to file
			write(buf_out, string'("--------------------------------------------------------------------"));
			write(buf_file, string'("--------------------------------------------------------------------"));
			writeline(output, buf_out);
			writeline(rt3_results_file, buf_file);
			write(buf_out, string'("Router 3 Testbench Results"));
			write(buf_file, string'("Router 3 Testbench Results"));
			writeline(output, buf_out);
			writeline(rt3_results_file, buf_file);
			write(buf_out, string'("Setup completed @ t = "));
			write(buf_out, now);
			write(buf_file, string'("Setup completed @ t = "));
			write(buf_file, now);
			writeline(output, buf_out);
			writeline(rt3_results_file, buf_file);
			write(buf_out, string'("--------------------------------------------------------------------"));
			write(buf_file, string'("--------------------------------------------------------------------"));
			writeline(output, buf_out);
			writeline(rt3_results_file, buf_file);
			
			
			router_start := '1';
		end if;
	
		if(router_start = '1') then
			
--			--Send a control packet
--			tid_RT3 <= "0000000100000011";
--			rsv_port_RT3 <= "010";
--			dst_address_RT3 <= "0010";
--			packet_type_RT3 <= "00";
--			trigger_3_cp <= '1', '0' after 1 ns;
--			
--			wait for clk_period_pe*20;
--			
--			--Send its data packet
--			rsv_port_RT3 <= "010";
--			dst_address_RT3 <= "0010";
--			packet_type_RT3 <= "00";
--			trigger_3_dp <= '1', '0' after 1 ns;
			
			--Done
			router_start := '0';	
			
		else
			wait for clk_period_pe*2;
			
		end if;
		
	end process;


--*****************************--
--**ROUTER 0 STIMULUS PROCESS**--
--*****************************--
   router0_stim_proc: process (reset_RT0, trigger_0_cp, trigger_0_dp, done_PE0, full_PE0)
		variable buf_out : line;
		variable buf_file : line;
		variable injected_data : std_logic_vector(57 downto 0) := (others => '0');
	begin		
     	
		
		--Reset Condition
		if (reset_RT0 = '1') then
			pe0_Ready <= '0';
		end if;
		
		--Handshaking
		if(done_PE0 = '1') then	
			sm_triggerPE0 <= '0';
			pe0_Ready <= '1', '0' after 1 ns;
		end if;
		
		if (trigger_0_cp = '1' and done_PE0 = '0' and full_PE0 = '0') then
			--*******************************************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0x0000 (TID) : DIR3 = 0x00 : DIR2 = 0x00 : DIR1 = 0x00 : DIR0 = 0x00 : COUNT = 0x00 : PID = 0x00 : MID = 0x01 (ROUTER ADDRESS) : COND = 0x00 : PRIORITY = N/A : C/D = 1
			--*******************************************************************************************************************************************************************************--
			data_inject_PE0 <= tid_RT0 & dir_3_RT0 & dir_2_RT0 & dir_1_RT0 & dir_0_RT0 & count_RT0 & "00" & pid_RT0 & packet_type_RT0 & priority_RT0 & "1";
			sm_triggerPE0 <= '1';
			
			--Test: Display to console/file
			injected_data := tid_RT0 & dir_3_RT0 & dir_2_RT0 & dir_1_RT0 & dir_0_RT0 & count_RT0 & "00" & pid_RT0 & packet_type_RT0 & priority_RT0 & "1";
			write(buf_out, string'("@ t = "));
			write(buf_out, now);
			write(buf_out, string'(" RT0 sending CP:" & vec2str(injected_data)));
			write(buf_out, string'(" :: PIDMID = " & vec2str(pid_RT0) & vec2str(packet_type_RT0)));
			write(buf_out, string'(" :: TID = "));
			write(buf_out, conv_integer(injected_data(57 downto 26)));
			writeline(output, buf_out);
			
			write(buf_file, string'("@ t = "));
			write(buf_file, now);
			write(buf_file, string'(" RT0 sending CP:" & vec2str(injected_data)));
			write(buf_file, string'(" :: PIDMID = " & vec2str(pid_RT0) & vec2str(packet_type_RT0)));
			write(buf_file, string'(" :: TID = "));
			write(buf_file, conv_integer(injected_data(57 downto 26)));
			writeline(rt0_results_file, buf_file);
			
		end if;
		
		if (trigger_0_dp = '1' and done_PE0 = '0' and full_PE0 = '0') then
			--*******************************************************************************************************************************************************************************--
			--DATA PACKET
			--PAYLOAD = 0x0000 (TID) : DIR3 = 0x00 : DIR2 = 0x00 : DIR1 = 0x00 : DIR0 = 0x00 : COUNT = 0x00 : PID = 0x00 : MID = 0x01 (ROUTER ADDRESS) : COND = 0x00 : PRIORITY = 1|0 : C/D = 1
			--*******************************************************************************************************************************************************************************--
			data_inject_PE0 <= tid_RT0 & dir_3_RT0 & dir_2_RT0 & dir_1_RT0 & dir_0_RT0 & count_RT0 & "00" & pid_RT0 & packet_type_RT0 & priority_RT0 & "0";
			sm_triggerPE0 <= '1';
			
			--Test: Display to console/file
			injected_data := tid_RT0 & dir_3_RT0 & dir_2_RT0 & dir_1_RT0 & dir_0_RT0 & count_RT0 & "00" & pid_RT0 & packet_type_RT0 & priority_RT0 & "0";
			write(buf_out, string'("@ t = "));
			write(buf_out, now);
			write(buf_out, string'(" RT0 sending DP:" & vec2str(injected_data)));
			write(buf_out, string'(" :: PIDMID = " & vec2str(pid_RT0) & vec2str(packet_type_RT0)));
			writeline(output, buf_out);
			
			write(buf_file, string'("@ t = "));
			write(buf_file, now);
			write(buf_file, string'(" RT0 sending DP:" & vec2str(injected_data)));
			write(buf_file, string'(" :: PIDMID = " & vec2str(pid_RT0) & vec2str(packet_type_RT0)));
			writeline(rt0_results_file, buf_file);
		
		end if;	
		
end process;
		
		
--*****************************--
--**ROUTER 1 STIMULUS PROCESS**--
--*****************************--
   router1_stim_proc: process (reset_RT1, trigger_1_cp, trigger_1_dp, done_PE1, full_PE1)
		variable buf_out : line;
		variable buf_file : line;
		variable injected_data : std_logic_vector(57 downto 0) := (others => '0');
	begin		
     	
		
		--Reset Condition
		if (reset_RT1 = '1') then
			pe1_Ready <= '0';
		end if;
		
		--Handshaking
		if(done_PE1 = '1') then	
			sm_triggerPE1 <= '0';
			pe1_Ready <= '1', '0' after 1 ns;
		end if;
		
		if (trigger_1_cp = '1' and done_PE1 = '0' and full_PE1 = '0') then
			--*******************************************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0x0000 (TID) : DIR3 = 0x00 : DIR2 = 0x00 : DIR1 = 0x00 : DIR0 = 0x00 : COUNT = 0x00 : PID = 0x00 : MID = 0x01 (ROUTER ADDRESS) : COND = 0x00 : PRIORITY = N/A : C/D = 1
			--*******************************************************************************************************************************************************************************--
			data_inject_PE1 <= tid_RT1 & dir_3_RT1 & dir_2_RT1 & dir_1_RT1 & dir_0_RT1 & count_RT1 & "01" & pid_RT1 & packet_type_RT1 & priority_RT1 & "1";
			sm_triggerPE1 <= '1';
			
			--Test: Display to console/file
			injected_data := tid_RT1 & dir_3_RT1 & dir_2_RT1 & dir_1_RT1 & dir_0_RT1 & count_RT1 & "01" & pid_RT1 & packet_type_RT1 & priority_RT1 & "1";
			write(buf_out, string'("@ t = "));
			write(buf_out, now);
			write(buf_out, string'(" RT1 sending CP:" & vec2str(injected_data)));
			write(buf_out, string'(" :: PIDMID = " & vec2str(pid_RT1) & vec2str(packet_type_RT1)));
			write(buf_out, string'(" :: TID = "));
			write(buf_out, conv_integer(injected_data(57 downto 26)));
			writeline(output, buf_out);
			
			write(buf_file, string'("@ t = "));
			write(buf_file, now);
			write(buf_file, string'(" RT1 sending CP:" & vec2str(injected_data)));
			write(buf_file, string'(" :: PIDMID = " & vec2str(pid_RT1) & vec2str(packet_type_RT1)));
			write(buf_file, string'(" :: TID = "));
			write(buf_file, conv_integer(injected_data(57 downto 26)));
			writeline(rt1_results_file, buf_file);
			
		end if;
		
		if (trigger_1_dp = '1' and done_PE1 = '0' and full_PE1 = '0') then
			--*******************************************************************************************************************************************************************************--
			--DATA PACKET
			--PAYLOAD = 0x0000 (TID) : DIR3 = 0x00 : DIR2 = 0x00 : DIR1 = 0x00 : DIR0 = 0x00 : COUNT = 0x00 : PID = 0x00 : MID = 0x01 (ROUTER ADDRESS) : COND = 0x00 : PRIORITY = 1|0 : C/D = 1
			--*******************************************************************************************************************************************************************************--
			data_inject_PE1 <= tid_RT1 & dir_3_RT1 & dir_2_RT1 & dir_1_RT1 & dir_0_RT1 & count_RT1 & "01" & pid_RT1 & packet_type_RT1 & priority_RT1 & "0";
			sm_triggerPE1 <= '1';
			
			--Test: Display to console/file
			injected_data := tid_RT1 & dir_3_RT1 & dir_2_RT1 & dir_1_RT1 & dir_0_RT1 & count_RT1 & "01" & pid_RT1 & packet_type_RT1 & priority_RT1 & "0";
			write(buf_out, string'("@ t = "));
			write(buf_out, now);
			write(buf_out, string'(" RT1 sending DP:" & vec2str(injected_data)));
			write(buf_out, string'(" :: PIDMID = " & vec2str(pid_RT1) & vec2str(packet_type_RT1)));
			writeline(output, buf_out);
			
			write(buf_file, string'("@ t = "));
			write(buf_file, now);
			write(buf_file, string'(" RT1 sending DP:" & vec2str(injected_data)));
			write(buf_file, string'(" :: PIDMID = " & vec2str(pid_RT1) & vec2str(packet_type_RT1)));
			writeline(rt1_results_file, buf_file);
			
		end if;			
end process;
	
--*****************************--
--**ROUTER 2 STIMULUS PROCESS**--
--*****************************--
   router2_stim_proc: process (reset_RT2, trigger_2_cp, trigger_2_dp, done_PE2, full_PE2)
		variable buf_out : line;
		variable buf_file : line;
		variable injected_data : std_logic_vector(57 downto 0) := (others => '0');
	begin		
     	
		
		--Reset Condition
		if (reset_RT2 = '1') then
			pe2_Ready <= '0';
		end if;
		
		--Handshaking
		if(done_PE2 = '1') then	
			sm_triggerPE2 <= '0';
			pe2_Ready <= '1', '0' after 1 ns;
		end if;
		
		if (trigger_2_cp = '1' and done_PE2 = '0' and full_PE2 = '0') then
			--*******************************************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0x0000 (TID) : DIR3 = 0x00 : DIR2 = 0x00 : DIR1 = 0x00 : DIR0 = 0x00 : COUNT = 0x00 : PID = 0x00 : MID = 0x01 (ROUTER ADDRESS) : COND = 0x00 : PRIORITY = N/A : C/D = 1
			--*******************************************************************************************************************************************************************************--
			data_inject_PE2 <= tid_RT2 & dir_3_RT2 & dir_2_RT2 & dir_1_RT2 & dir_0_RT2 & count_RT2 & "10" & pid_RT2 & packet_type_RT2 & priority_RT2 & "1";
			sm_triggerPE2 <= '1';
			
			--Test: Display to console/file
			injected_data := tid_RT2 & dir_3_RT2 & dir_2_RT2 & dir_1_RT2 & dir_0_RT2 & count_RT2 & "10" & pid_RT2 & packet_type_RT2 & priority_RT2 & "1";
			write(buf_out, string'("@ t = "));
			write(buf_out, now);
			write(buf_out, string'(" RT2 sending CP:" & vec2str(injected_data)));
			write(buf_out, string'(" :: PIDMID = " & vec2str(pid_RT2) & vec2str(packet_type_RT2)));
			write(buf_out, string'(" :: TID = "));
			write(buf_out, conv_integer(injected_data(57 downto 26)));
			writeline(output, buf_out);
			
			write(buf_file, string'("@ t = "));
			write(buf_file, now);
			write(buf_file, string'(" RT2 sending CP:" & vec2str(injected_data)));
			write(buf_file, string'(" :: PIDMID = " & vec2str(pid_RT2) & vec2str(packet_type_RT2)));
			write(buf_file, string'(" :: TID = "));
			write(buf_file, conv_integer(injected_data(57 downto 26)));
			writeline(rt2_results_file, buf_file);
			
		end if;
		
		if (trigger_2_dp = '1' and done_PE2 = '0' and full_PE2 = '0') then
			--*******************************************************************************************************************************************************************************--
			--DATA PACKET
			--PAYLOAD = 0x0000 (TID) : DIR3 = 0x00 : DIR2 = 0x00 : DIR1 = 0x00 : DIR0 = 0x00 : COUNT = 0x00 : PID = 0x00 : MID = 0x01 (ROUTER ADDRESS) : COND = 0x00 : PRIORITY = 1|0 : C/D = 1
			--*******************************************************************************************************************************************************************************--
			data_inject_PE2 <= tid_RT2 & dir_3_RT2 & dir_2_RT2 & dir_1_RT2 & dir_0_RT2 & count_RT2 & "10" & pid_RT2 & packet_type_RT2 & priority_RT2 & "0";
			sm_triggerPE2 <= '1';
			
			--Test: Display to console/file
			injected_data := tid_RT2 & dir_3_RT2 & dir_2_RT2 & dir_1_RT2 & dir_0_RT2 & count_RT2 & "10" & pid_RT2 & packet_type_RT2 & priority_RT2 & "0";
			write(buf_out, string'("@ t = "));
			write(buf_out, now);
			write(buf_out, string'(" RT2 sending DP:" & vec2str(injected_data)));
			write(buf_out, string'(" :: PIDMID = " & vec2str(pid_RT2) & vec2str(packet_type_RT2)));
			writeline(output, buf_out);
			
			write(buf_file, string'("@ t = "));
			write(buf_file, now);
			write(buf_file, string'(" RT2 sending DP:" & vec2str(injected_data)));
			write(buf_file, string'(" :: PIDMID = " & vec2str(pid_RT2) & vec2str(packet_type_RT2)));
			writeline(rt1_results_file, buf_file);
			
		end if;	
		
end process;
	
--*****************************--
--**ROUTER 3 STIMULUS PROCESS**--
--*****************************--
   router3_stim_proc: process (reset_RT3, trigger_3_cp, trigger_3_dp, done_PE3, full_PE3)
		variable buf_out : line;
		variable buf_file : line;
		variable injected_data : std_logic_vector(57 downto 0) := (others => '0');
	begin		
     	
		
		--Reset Condition
		if (reset_RT3 = '1') then
			pe3_Ready <= '0';
		end if;
		
		--Handshaking
		if(done_PE3 = '1') then	
			sm_triggerPE3 <= '0';
			pe3_Ready <= '1', '0' after 1 ns;
		end if;
		
		if (trigger_3_cp = '1' and done_PE3 = '0' and full_PE3 = '0') then
			--*******************************************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0x0000 (TID) : DIR3 = 0x00 : DIR2 = 0x00 : DIR1 = 0x00 : DIR0 = 0x00 : COUNT = 0x00 : PID = 0x00 : MID = 0x01 (ROUTER ADDRESS) : COND = 0x00 : PRIORITY = N/A : C/D = 1
			--*******************************************************************************************************************************************************************************--
			data_inject_PE3 <= tid_RT3 & dir_3_RT3 & dir_2_RT3 & dir_1_RT3 & dir_0_RT3 & count_RT3 & "11" & pid_RT3 & packet_type_RT3 & priority_RT3 & "1";
			sm_triggerPE3 <= '1';
			
			--Test: Display to console/file
			injected_data := tid_RT3 & dir_3_RT3 & dir_2_RT3 & dir_1_RT3 & dir_0_RT3 & count_RT3 & "11" & pid_RT3 & packet_type_RT3 & priority_RT3 & "1";
			write(buf_out, string'("@ t = "));
			write(buf_out, now);
			write(buf_out, string'(" RT3 sending CP:" & vec2str(injected_data)));
			write(buf_out, string'(" :: PIDMID = " & vec2str(pid_RT3) & vec2str(packet_type_RT3)));
			write(buf_out, string'(" :: TID = "));
			write(buf_out, conv_integer(injected_data(57 downto 26)));
			writeline(output, buf_out);
			
			write(buf_file, string'("@ t = "));
			write(buf_file, now);
			write(buf_file, string'(" RT3 sending CP:" & vec2str(injected_data)));
			write(buf_file, string'(" :: PIDMID = " & vec2str(pid_RT3) & vec2str(packet_type_RT3)));
			write(buf_file, string'(" :: TID = "));
			write(buf_file, conv_integer(injected_data(57 downto 26)));
			writeline(rt3_results_file, buf_file);
			
		end if;
		
		if (trigger_3_dp = '1' and done_PE3 = '0' and full_PE3 = '0') then
			--*******************************************************************************************************************************************************************************--
			--DATA PACKET
			--PAYLOAD = 0x0000 (TID) : DIR3 = 0x00 : DIR2 = 0x00 : DIR1 = 0x00 : DIR0 = 0x00 : COUNT = 0x00 : PID = 0x00 : MID = 0x01 (ROUTER ADDRESS) : COND = 0x00 : PRIORITY = 1|0 : C/D = 1
			--*******************************************************************************************************************************************************************************--
			data_inject_PE3 <= tid_RT3 & dir_3_RT3 & dir_2_RT3 & dir_1_RT3 & dir_0_RT3 & count_RT3 & "11" & pid_RT3 & packet_type_RT3 & priority_RT3 & "0";
			sm_triggerPE3 <= '1';
			
			--Test: Display to console/file
			injected_data := tid_RT3 & dir_3_RT3 & dir_2_RT3 & dir_1_RT3 & dir_0_RT3 & count_RT3 & "11" & pid_RT3 & packet_type_RT3 & priority_RT3 & "0";
			write(buf_out, string'("@ t = "));
			write(buf_out, now);
			write(buf_out, string'(" RT3 sending DP:" & vec2str(injected_data)));
			write(buf_out, string'(" :: PIDMID = " & vec2str(pid_RT3) & vec2str(packet_type_RT3)));
			writeline(output, buf_out);
			
			write(buf_file, string'("@ t = "));
			write(buf_file, now);
			write(buf_file, string'(" RT3 sending DP:" & vec2str(injected_data)));
			write(buf_file, string'(" :: PIDMID = " & vec2str(pid_RT3) & vec2str(packet_type_RT3)));
			writeline(rt3_results_file, buf_file);
			
		end if;	
	
		
end process;

--*****************************--
--**ROUTER 3 EJECTION PROCESS**--
--*****************************--
   router3_eject_proc: process (ej_readyPE3)
		variable buf_out : line;
		variable buf_file : line;
	begin		
     	
		
		--Reset Condition
		if (ej_readyPE3 = '1') then
			
			if(data_eject_PE3(0) = '1') then
				write(buf_file, string'("@ t = "));
				write(buf_file, now);
				write(buf_file, string'(" RT3 ejected CP:" & vec2str(data_eject_PE3)));
				write(buf_file, string'(" :: PIDMID = " & vec2str(data_eject_PE3(9 downto 2))));
				if(data_eject_PE3(11 downto 10) = "00") then
					write(buf_file, string'(" :: Source = RT0"));
				elsif(data_eject_PE3(11 downto 10) = "01") then
					write(buf_file, string'(" :: Source = RT1"));
				elsif(data_eject_PE3(11 downto 10) = "10") then
					write(buf_file, string'(" :: Source = RT2"));
				end if;
				writeline(rt3_results_file, buf_file);
			else
				write(buf_file, string'("@ t = "));
				write(buf_file, now);
				write(buf_file, string'(" RT3 ejected DP:" & vec2str(data_eject_PE3)));
				write(buf_file, string'(" :: PIDMID = " & vec2str(data_eject_PE3(9 downto 2))));
				if(data_eject_PE3(11 downto 10) = "00") then
					write(buf_file, string'(" :: Source = RT0"));
				elsif(data_eject_PE3(11 downto 10) = "01") then
					write(buf_file, string'(" :: Source = RT1"));
				elsif(data_eject_PE3(11 downto 10) = "10") then
					write(buf_file, string'(" :: Source = RT2"));
				end if;
				writeline(rt3_results_file, buf_file);
			end if;
		end if;
		
end process;

END;
