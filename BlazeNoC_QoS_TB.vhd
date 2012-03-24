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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
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
         data_inject_PE0 : IN  std_logic_vector(33 downto 0);
         data_inject_PE1 : IN  std_logic_vector(33 downto 0);
         data_inject_PE2 : IN  std_logic_vector(33 downto 0);
         data_inject_PE3 : IN  std_logic_vector(33 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_rte : std_logic := '0';
	signal clk_pe : std_logic := '0';
   signal reset : std_logic := '0';
   signal sm_triggerPE0 : std_logic := '0';
   signal sm_triggerPE1 : std_logic := '0';
   signal sm_triggerPE2 : std_logic := '0';
   signal sm_triggerPE3 : std_logic := '0';
   signal data_inject_PE0 : std_logic_vector(33 downto 0) := (others => '0');
   signal data_inject_PE1 : std_logic_vector(33 downto 0) := (others => '0');
   signal data_inject_PE2 : std_logic_vector(33 downto 0) := (others => '0');
   signal data_inject_PE3 : std_logic_vector(33 downto 0) := (others => '0');

 	--Outputs
   signal full_PE0 : std_logic;
   signal full_PE1 : std_logic;
   signal full_PE2 : std_logic;
   signal full_PE3 : std_logic;
   signal done_PE0 : std_logic;
   signal done_PE1 : std_logic;
   signal done_PE2 : std_logic;
   signal done_PE3 : std_logic;
	
	--Signals for Testing
	signal router_setup 		: std_logic;
	
	--Router 0
	signal reset_RT0			: std_logic;
	signal trigger_0_cp 		: std_logic;
	signal trigger_0_dp	   : std_logic;
	signal pe0_Ready			: std_logic;
	signal tid_RT0 			: std_logic_vector(15 downto 0);
	signal rsv_port_RT0		: std_logic_vector(2 downto 0);
	signal dst_address_RT0	: std_logic_vector(3 downto 0);
	signal packet_type_RT0	: std_logic_vector(1 downto 0);
	
	--Router 1
	signal reset_RT1			: std_logic;
	signal trigger_1_cp 		: std_logic;
	signal trigger_1_dp	   : std_logic;
	signal pe1_Ready			: std_logic;
	signal tid_RT1 			: std_logic_vector(15 downto 0);
	signal rsv_port_RT1		: std_logic_vector(2 downto 0);
	signal dst_address_RT1	: std_logic_vector(3 downto 0);
	signal packet_type_RT1	: std_logic_vector(1 downto 0);
	
	--Router 2
	signal reset_RT2			: std_logic;
	signal trigger_2_cp 		: std_logic;
	signal trigger_2_dp	   : std_logic;
	signal pe2_Ready			: std_logic;
	signal tid_RT2 			: std_logic_vector(15 downto 0);
	signal rsv_port_RT2		: std_logic_vector(2 downto 0);
	signal dst_address_RT2	: std_logic_vector(3 downto 0);
	signal packet_type_RT2	: std_logic_vector(1 downto 0);
	
	--Router 3
	signal reset_RT3			: std_logic;
	signal trigger_3_cp 		: std_logic;
	signal trigger_3_dp	   : std_logic;
	signal pe3_Ready			: std_logic;
	signal tid_RT3 			: std_logic_vector(15 downto 0);
	signal rsv_port_RT3		: std_logic_vector(2 downto 0);
	signal dst_address_RT3	: std_logic_vector(3 downto 0);
	signal packet_type_RT3	: std_logic_vector(1 downto 0);
	
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
          data_inject_PE0 => data_inject_PE0,
          data_inject_PE1 => data_inject_PE1,
          data_inject_PE2 => data_inject_PE2,
          data_inject_PE3 => data_inject_PE3
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
	begin
		if(router_setup = '1') then
			trigger_0_cp <= '0';
			trigger_0_dp <= '0';
			router_start := '0';
			
			-- Resets Internal Counters			
			reset_RT0 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*2;
			
			--******************************--
			--**Setup Router Watchdog Seed**--
			--******************************--
			tid_RT0 <= "0000000000001111";				--Router 0
			rsv_port_RT0 <= "000";
			dst_address_RT0 <= "0000";
			packet_type_RT0 <= "11";
			trigger_0_cp <= '1', '0' after 1 ns;
			
			wait until pe0_Ready = '1';
			wait for clk_period_pe*2;
			
			-- Resets Internal Counters
			reset_RT0 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*4;
			
			--***********************--
			--**Setup Routing Table**--
			--***********************--
			
			--**Routing Table[0]**--
			tid_RT0 <= "0000000000001111";				--Router 0 [Direction for: RT0 (Go Ejection)]
			packet_type_RT0 <= "10";
			trigger_0_cp <= '1', '0' after 1 ns;
			
			wait until pe0_Ready = '1';
			wait for clk_period_pe*2;
			
			--**Routing Table[1]**--
			tid_RT0 <= "0000000000000011";				--Router 0 [Direction for: RT1 (Go East)]
			packet_type_RT0 <= "10";
			trigger_0_cp <= '1', '0' after 1 ns;
			
			wait until pe0_Ready = '1';
			wait for clk_period_pe*2;
			
			--**Routing Table[2]**--
			tid_RT0 <= "0000000000000101";				--Router 0 [Direction for: RT2 (Go South)]
			packet_type_RT0 <= "10";
			trigger_0_cp <= '1', '0' after 1 ns;
			
			wait until pe0_Ready = '1';
			wait for clk_period_pe*2;
			
			--**Routing Table[3]**--
			tid_RT0 <= "0000000000000011";				--Router 0 [Direction for: RT3 (Go East)]
			packet_type_RT0 <= "10";
			trigger_0_cp <= '1', '0' after 1 ns;
			
			wait until pe0_Ready = '1';
			wait for clk_period_pe*2;
			
			reset_RT0 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*4;

			--************************--
			--**Setup Router Address**--
			--************************--
			tid_RT0 <= "0000000000000000";				--Router 0 [Address: 0]
			packet_type_RT0 <= "01";
			trigger_0_cp <= '1', '0' after 1 ns;
	
			wait until pe0_Ready = '1';						
			wait for clk_period_pe*2;
			
			-- Resets Internal Counters			
			reset_RT0 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*2;
			
			router_start := '1';
		end if;
	
		if(router_start = '1') then
			
			--Send a control packet
			tid_RT0 <= "0000000100000011";
			rsv_port_RT0 <= "010";
			dst_address_RT0 <= "0001";
			packet_type_RT0 <= "00";
			trigger_0_cp <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*2;
			
			-- Resets Internal Counters			
			reset_RT0 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*2;
			
			--Send a control packet
			tid_RT0 <= "1100000110000011";
			rsv_port_RT0 <= "111";
			dst_address_RT0 <= "0011";
			packet_type_RT0 <= "00";
			trigger_0_cp <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*2;
			
			-- Resets Internal Counters			
			reset_RT0 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*20;
			
			--Send its data packet
			rsv_port_RT0 <= "010";
			dst_address_RT0 <= "0001";
			packet_type_RT0 <= "00";
			trigger_0_dp <= '1', '0' after 1 ns;
			
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
	begin
		if(router_setup = '1') then
			trigger_1_cp <= '0';
			trigger_1_dp <= '0';
			router_start := '0';
			
			-- Resets Internal Counters			
			reset_RT1 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*2;
			
			--******************************--
			--**Setup Router Watchdog Seed**--
			--******************************--
			tid_RT1 <= "0000000001000000";				--Router 1
			rsv_port_RT1 <= "000";
			dst_address_RT1 <= "0000";
			packet_type_RT1 <= "11";
			trigger_1_cp <= '1', '0' after 1 ns;
			
			wait until pe1_Ready = '1';
			wait for clk_period_pe*2;
			
			-- Resets Internal Counters
			reset_RT1<= '1', '0' after 1 ns;
			
			wait for clk_period_pe*4;
			
			--***********************--
			--**Setup Routing Table**--
			--***********************--
			
			--**Routing Table[0]**--
			tid_RT1 <= "0000000000000111";				--Router 1 [Direction for: RT0 (Go West)]
			packet_type_RT1 <= "10";
			trigger_1_cp <= '1', '0' after 1 ns;
			
			wait until pe1_Ready = '1';
			wait for clk_period_pe*2;
			
			--**Routing Table[1]**--
			tid_RT1 <= "0000000000001111";				--Router 1 [Direction for: RT1 (Go Ejection)]
			packet_type_RT1 <= "10";
			trigger_1_cp <= '1', '0' after 1 ns;
			
			wait until pe1_Ready = '1';
			wait for clk_period_pe*2;
			
			--**Routing Table[2]**--		
			tid_RT1 <= "0000000000000111";				--Router 1 [Direction for: RT2 (Go West)]
			packet_type_RT1 <= "10";
			trigger_1_cp <= '1', '0' after 1 ns;
			
			wait until pe1_Ready = '1';
			wait for clk_period_pe*2;
			
			--**Routing Table[3]**--	
			tid_RT1 <= "0000000000000101";				--Router 1 [Direction for: RT3 (Go South)]
			packet_type_RT1 <= "10";
			trigger_1_cp <= '1', '0' after 1 ns;
			
			wait until pe1_Ready = '1';
			wait for clk_period_pe*2;
			
			reset_RT1 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*4;

			--************************--
			--**Setup Router Address**--
			--************************--
			tid_RT1 <= "0000000000000001";				--Router 1 [Address: 1]
			packet_type_RT1 <= "01";
			trigger_1_cp <= '1', '0' after 1 ns;
		
			wait until pe1_Ready = '1';						
			wait for clk_period_pe*2;
			
			-- Resets Internal Counters			
			reset_RT1 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*2;
			
			router_start := '1';
		end if;
	
		if(router_start = '1') then
			
			reset_RT1 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*2;
			
			loop
				--Send GARBAGE data to Router 3
				rsv_port_RT1 <= "010";
				dst_address_RT1 <= "0011";
				packet_type_RT1 <= "00";
				trigger_1_dp <= '1', '0' after 1 ns;
				wait until pe1_Ready = '1';
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
	begin
		if(router_setup = '1') then
			trigger_2_cp <= '0';
			trigger_2_dp <= '0';
			router_start := '0';
			
			-- Resets Internal Counters			
			reset_RT2 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*2;
			
			--******************************--
			--**Setup Router Watchdog Seed**--
			--******************************--
			tid_RT2 <= "0000000000001001";				--Router 2
			rsv_port_RT2 <= "000";
			dst_address_RT2 <= "0000";
			packet_type_RT2 <= "11";
			trigger_2_cp <= '1', '0' after 1 ns;
			
			wait until pe2_Ready = '1';
			wait for clk_period_pe*2;
			
			-- Resets Internal Counters
			reset_RT2 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*4;
			
			--***********************--
			--**Setup Routing Table**--
			--***********************--
			
			--**Routing Table[0]**--
			tid_RT2 <= "0000000000000001";				--Router 2 [Direction for: RT0 (Go North)]
			packet_type_RT2 <= "10";
			trigger_2_cp <= '1', '0' after 1 ns;
			
			wait until pe2_Ready = '1';
			wait for clk_period_pe*2;
			
			--**Routing Table[1]**--
			tid_RT2 <= "0000000000000011";				--Router 2 [Direction for: RT1 (Go East)]
			packet_type_RT2 <= "10";
			trigger_2_cp <= '1', '0' after 1 ns;
			
			wait until pe2_Ready = '1';
			wait for clk_period_pe*2;
			
			--**Routing Table[2]**--
			tid_RT2 <= "0000000000001111";				--Router 2 [Direction for: RT2 (Go Ejection)]
			packet_type_RT2 <= "10";
			trigger_2_cp <= '1', '0' after 1 ns;
			
			wait until pe2_Ready = '1';
			wait for clk_period_pe*2;
			
			--**Routing Table[3]**--
			tid_RT2 <= "0000000000000011";				--Router 2 [Direction for: RT3 (Go East)]
			packet_type_RT2 <= "10";
			trigger_2_cp <= '1', '0' after 1 ns;
	
			wait until pe2_Ready = '1';
			wait for clk_period_pe*2;
			
			reset_RT2 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*4;

			--************************--
			--**Setup Router Address**--
			--************************--
			tid_RT2 <= "0000000000000010";				--Router 2 [Address: 2]
			packet_type_RT2 <= "01";
			trigger_2_cp <= '1', '0' after 1 ns;
			
			wait until pe2_Ready = '1';						
			wait for clk_period_pe*2;
			
			-- Resets Internal Counters			
			reset_RT2 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*2;
			
			router_start := '1';
		end if;
	
		if(router_start = '1') then
						
			loop
				--Send GARBAGE data to Router 3
				rsv_port_RT2 <= "010";
				dst_address_RT2 <= "0000";
				packet_type_RT2 <= "00";
				trigger_2_dp <= '1', '0' after 1 ns;
				wait until pe2_Ready = '1';
			end loop;
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
	begin
		if(router_setup = '1') then
			trigger_3_cp <= '0';
			trigger_3_dp <= '0';
			router_start := '0';
			
			-- Resets Internal Counters			
			reset_RT3 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*2;
			
			--******************************--
			--**Setup Router Watchdog Seed**--
			--******************************--
			tid_RT3 <= "0000000000011001";				--Router 3
			rsv_port_RT3 <= "000";
			dst_address_RT3 <= "0000";
			packet_type_RT3 <= "11";
			trigger_3_cp <= '1', '0' after 1 ns;
			
			wait until pe3_Ready = '1';
			wait for clk_period_pe*2;
			
			-- Resets Internal Counters
			reset_RT3 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*4;
			
			--***********************--
			--**Setup Routing Table**--
			--***********************--
			
			--**Routing Table[0]**--	
			tid_RT3 <= "0000000000000001";				--Router 3 [Direction for: RT0 (Go North)]
			packet_type_RT3 <= "10";
			trigger_3_cp <= '1', '0' after 1 ns;
			
			wait until pe3_Ready = '1';
			wait for clk_period_pe*2;
			
			--**Routing Table[1]**--
			tid_RT3 <= "0000000000000001";				--Router 3 [Direction for: RT1 (Go North)]
			packet_type_RT3 <= "10";
			trigger_3_cp <= '1', '0' after 1 ns;
			
			wait until pe3_Ready = '1';
			wait for clk_period_pe*2;
			
			--**Routing Table[2]**--
			tid_RT3 <= "0000000000000111";				--Router 3 [Direction for: RT2 (Go West)]
			packet_type_RT3 <= "10";
			trigger_3_cp <= '1', '0' after 1 ns;
			
			wait until pe3_Ready = '1';
			wait for clk_period_pe*2;
			
			--**Routing Table[3]**--	
			tid_RT3 <= "0000000000001111";				--Router 3 [Direction for: RT3 (Go West)]
			packet_type_RT3 <= "10";
			trigger_3_cp <= '1', '0' after 1 ns;
			
			wait until pe3_Ready = '1';
			wait for clk_period_pe*2;
			
			reset_RT3 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*4;

			--************************--
			--**Setup Router Address**--
			--************************--
			tid_RT3 <= "0000000000000011";				--Router 3 [Address: 3]
			packet_type_RT3 <= "01";
			trigger_3_cp <= '1', '0' after 1 ns;
			
			wait until pe3_Ready = '1';						
			wait for clk_period_pe*2;
			
			-- Resets Internal Counters			
			reset_RT3 <= '1', '0' after 1 ns;
			
			wait for clk_period_pe*2;
			
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

--*************************--
--**HOT INJECTION PROCESS**--
--*************************--
--	hot_inject: process(stim_start)
--	begin
--		if (stim_start = '1') then
--		
--		end if;
--	end process;

--*****************************--
--**ROUTER 0 STIMULUS PROCESS**--
--*****************************--
   router0_stim_proc: process (reset_RT0, trigger_0_cp, trigger_0_dp, done_PE0, full_PE0)
		variable c_pid		: std_logic_vector(3 downto 0) := "0000";
		variable d_pid		: std_logic_vector(3 downto 0) := "0000";
	begin		
     	
		
		--Reset Condition
		if (reset_RT0 = '1') then
			c_pid := "0000";
			d_pid := "0000";
			pe0_Ready <= '0';
		end if;
		
		--Handshaking
		if(done_PE0 = '1') then	
			sm_triggerPE0 <= '0';
			pe0_Ready <= '1', '0' after 1 ns;
		end if;
		
		
		if (trigger_0_cp = '1' and done_PE0 = '0' and full_PE0 = '0') then
			--**************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0xUUU (TID) : MID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0xUUU (RESERVE SOUTH) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE0 <= tid_RT0 & "0000" & c_pid & rsv_port_RT0 & dst_address_RT0 & packet_type_RT0 & "1";
			sm_triggerPE0 <= '1';
			
			c_pid := c_pid + "0001";
		
		end if;
		
		if (trigger_0_dp = '1' and done_PE0 = '0' and full_PE0 = '0') then
			--**************************************************************************************************************************************************--
			--DATA PACKET
			--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0xUUU (SOUTH RESERVED) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE0 <= "0000000000000000" & "0000" & d_pid & rsv_port_RT0 & dst_address_RT0 & packet_type_RT0 & "0";
			sm_triggerPE0 <= '1';
			
			
			--Increment PID
			d_pid := d_pid + "0001";
		end if;	
		
end process;
		
		
--*****************************--
--**ROUTER 1 STIMULUS PROCESS**--
--*****************************--
   router1_stim_proc: process (reset_RT1, trigger_1_cp, trigger_1_dp, done_PE1, full_PE1)
		variable c_pid		: std_logic_vector(3 downto 0) := "0000";
		variable d_pid		: std_logic_vector(3 downto 0) := "0000";
	begin		
     	
		
		--Reset Condition
		if (reset_RT1 = '1') then
			c_pid := "0000";
			d_pid := "0000";
			pe1_Ready <= '0';
		end if;
		
		--Handshaking
		if(done_PE1 = '1') then	
			sm_triggerPE1 <= '0';
			pe1_Ready <= '1', '0' after 1 ns;
		end if;
		
		
		if (trigger_1_cp = '1' and done_PE1 = '0' and full_PE1 = '0') then
			--**************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0xUUU (TID) : MID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0xUUU (RESERVE SOUTH) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE1 <= tid_RT1 & "0000" & c_pid & rsv_port_RT1 & dst_address_RT1 & packet_type_RT1 & "1";
			sm_triggerPE1 <= '1';
			
			c_pid := c_pid + "0001";
		
		end if;
		
		if (trigger_1_dp = '1' and done_PE1 = '0' and full_PE1 = '0') then
			--**************************************************************************************************************************************************--
			--DATA PACKET
			--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0xUUU (SOUTH RESERVED) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE1 <= "0000000000000000" & "0000" & d_pid & rsv_port_RT1 & dst_address_RT1 & packet_type_RT1 & "0";
			sm_triggerPE1 <= '1';
			
			
			--Increment PID
			d_pid := d_pid + "0001";
		end if;	
		
end process;
	
--*****************************--
--**ROUTER 2 STIMULUS PROCESS**--
--*****************************--
    router2_stim_proc: process (reset_RT2, trigger_2_cp, trigger_2_dp, done_PE2, full_PE2)
		variable c_pid		: std_logic_vector(3 downto 0) := "0000";
		variable d_pid		: std_logic_vector(3 downto 0) := "0000";
	begin		
     	
		
		--Reset Condition
		if (reset_RT2 = '1') then
			c_pid := "0000";
			d_pid := "0000";
			pe2_Ready <= '0';
		end if;
		
		--Handshaking
		if(done_PE2 = '1') then	
			sm_triggerPE2 <= '0';
			pe2_Ready <= '1', '0' after 1 ns;
		end if;
		
		
		if (trigger_2_cp = '1' and done_PE2 = '0' and full_PE2 = '0') then
			--**************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0xUUU (TID) : MID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0xUUU (RESERVE SOUTH) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE2 <= tid_RT2 & "0000" & c_pid & rsv_port_RT2 & dst_address_RT2 & packet_type_RT2 & "1";
			sm_triggerPE2 <= '1';
			
			c_pid := c_pid + "0001";
		
		end if;
		
		if (trigger_2_dp = '1' and done_PE2 = '0' and full_PE2 = '0') then
			--**************************************************************************************************************************************************--
			--DATA PACKET
			--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0xUUU (SOUTH RESERVED) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE2 <= "0000000000000000" & "0000" & d_pid & rsv_port_RT2 & dst_address_RT2 & packet_type_RT2 & "0";
			sm_triggerPE2 <= '1';
			
			
			--Increment PID
			d_pid := d_pid + "0001";
		end if;	
		
end process;
	
--*****************************--
--**ROUTER 3 STIMULUS PROCESS**--
--*****************************--
   router3_stim_proc: process (reset_RT3, trigger_3_cp, trigger_3_dp, done_PE3, full_PE3)
		variable c_pid		: std_logic_vector(3 downto 0) := "0000";
		variable d_pid		: std_logic_vector(3 downto 0) := "0000";
	begin		
     	
		
		--Reset Condition
		if (reset_RT3 = '1') then
			c_pid := "0000";
			d_pid := "0000";
			pe3_Ready <= '0';
		end if;
		
		--Handshaking
		if(done_PE3 = '1') then	
			sm_triggerPE3 <= '0';
			pe3_Ready <= '1', '0' after 1 ns;
		end if;
		
		
		if (trigger_3_cp = '1' and done_PE3 = '0' and full_PE3 = '0') then
			--**************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0xUUU (TID) : MID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0xUUU (RESERVE SOUTH) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE3 <= tid_RT3 & "0000" & c_pid & rsv_port_RT3 & dst_address_RT3 & packet_type_RT3 & "1";
			sm_triggerPE3 <= '1';
			
			c_pid := c_pid + "0001";
		
		end if;
		
		if (trigger_3_dp = '1' and done_PE3 = '0' and full_PE3 = '0') then
			--**************************************************************************************************************************************************--
			--DATA PACKET
			--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0xUUU (SOUTH RESERVED) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE3 <= "0000000000000000" & "0000" & d_pid & rsv_port_RT3 & dst_address_RT3 & packet_type_RT3 & "0";
			sm_triggerPE3 <= '1';
			
			
			--Increment PID
			d_pid := d_pid + "0001";
		end if;	
		
end process;
END;
