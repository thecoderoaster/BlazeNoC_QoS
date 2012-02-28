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
         clk : IN  std_logic;
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
   signal clk : std_logic := '0';
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
	signal router_start 		: std_logic;
	signal reset_all 			: std_logic;
	
	--Router 0
	signal trigger_0 			: std_logic;
	signal setup_trigger_0  : std_logic;
	signal tid_RT0 			: std_logic_vector(15 downto 0);
	signal rsv_port_RT0		: std_logic_vector(2 downto 0);
	signal dst_address_RT0	: std_logic_vector(3 downto 0);
	signal packet_type_RT0	: std_logic_vector(1 downto 0);
	
	--Router 1
	signal trigger_1 			: std_logic;
	signal setup_trigger_1  : std_logic;
	signal tid_RT1 			: std_logic_vector(15 downto 0);
	signal rsv_port_RT1		: std_logic_vector(2 downto 0);
	signal dst_address_RT1	: std_logic_vector(3 downto 0);
	signal packet_type_RT1	: std_logic_vector(1 downto 0);
	
	--Router 2
	signal trigger_2 			: std_logic;
	signal setup_trigger_2  : std_logic;
	signal tid_RT2 			: std_logic_vector(15 downto 0);
	signal rsv_port_RT2		: std_logic_vector(2 downto 0);
	signal dst_address_RT2	: std_logic_vector(3 downto 0);
	signal packet_type_RT2	: std_logic_vector(1 downto 0);
	
	--Router 3
	signal trigger_3 			: std_logic;
	signal setup_trigger_3  : std_logic;
	signal tid_RT3 			: std_logic_vector(15 downto 0);
	signal rsv_port_RT3		: std_logic_vector(2 downto 0);
	signal dst_address_RT3	: std_logic_vector(3 downto 0);
	signal packet_type_RT3	: std_logic_vector(1 downto 0);
	
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BlazeNoC PORT MAP (
          clk => clk,
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
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
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
		wait for clk_period*2;
		reset <= '1', '0' after clk_period;
	
      wait for clk_period*10;
		
		router_setup <= '1', '0' after clk_period*4;
		
		wait;
		
	end process;
 
	
--******************--	
--** MAIN PROCESS **--
--******************-- 
	main_proc: process
	begin
		if(router_setup = '1') then
			setup_trigger_0 <= '0';
			setup_trigger_1 <= '0';
			setup_trigger_2 <= '0';
			setup_trigger_3 <= '0';
			router_start <= '0';
			
			wait for clk_period*2;
			
			--******************************--
			--**Setup Router Watchdog Seed**--
			--******************************--
			tid_RT0 <= "0000000000001111";				--Router 0
			rsv_port_RT0 <= "000";
			dst_address_RT0 <= "0000";
			packet_type_RT0 <= "11";
			setup_trigger_0 <= '1', '0' after 1 ns;
			
			tid_RT1 <= "0000000001000000";				--Router 1
			rsv_port_RT1 <= "000";
			dst_address_RT1 <= "0000";
			packet_type_RT1 <= "11";
			setup_trigger_1 <= '1', '0' after 1 ns;
			
			tid_RT2 <= "0000000000001001";				--Router 2
			rsv_port_RT2 <= "000";
			dst_address_RT2 <= "0000";
			packet_type_RT2 <= "11";
			setup_trigger_2 <= '1', '0' after 1 ns;
			
			tid_RT3 <= "0000000000011001";				--Router 3
			rsv_port_RT3 <= "000";
			dst_address_RT3 <= "0000";
			packet_type_RT3 <= "11";
			setup_trigger_3 <= '1', '0' after 1 ns;
			
			wait for clk_period*4;							-- Resets Internal Counters
			
			reset_all <= '1', '0' after 1 ns;
			
			wait for clk_period*4;
			
			--***********************--
			--**Setup Routing Table**--
			--***********************--
			
			--**Routing Table[0]**--
			tid_RT0 <= "0000000000001111";				--Router 0 [Direction for: RT0 (Go Ejection)]
			packet_type_RT0 <= "10";
			setup_trigger_0 <= '1', '0' after 1 ns;
			
			tid_RT1 <= "0000000000000111";				--Router 1 [Direction for: RT0 (Go West)]
			packet_type_RT1 <= "10";
			setup_trigger_1 <= '1', '0' after 1 ns;
			
			tid_RT2 <= "0000000000000001";				--Router 2 [Direction for: RT0 (Go North)]
			packet_type_RT2 <= "10";
			setup_trigger_2 <= '1', '0' after 1 ns;
			
			tid_RT3 <= "0000000000000001";				--Router 3 [Direction for: RT0 (Go North)]
			packet_type_RT3 <= "10";
			setup_trigger_3 <= '1', '0' after 1 ns;
			
			--**Routing Table[1]**--
			tid_RT0 <= "0000000000000011";				--Router 0 [Direction for: RT1 (Go East)]
			packet_type_RT0 <= "10";
			setup_trigger_0 <= '1', '0' after 1 ns;
			
			tid_RT1 <= "0000000000001111";				--Router 1 [Direction for: RT1 (Go Ejection)]
			packet_type_RT1 <= "10";
			setup_trigger_1 <= '1', '0' after 1 ns;
			
			tid_RT2 <= "0000000000000011";				--Router 2 [Direction for: RT1 (Go East)]
			packet_type_RT2 <= "10";
			setup_trigger_2 <= '1', '0' after 1 ns;
			
			tid_RT3 <= "0000000000000001";				--Router 3 [Direction for: RT1 (Go North)]
			packet_type_RT3 <= "10";
			setup_trigger_3 <= '1', '0' after 1 ns;
			
			--**Routing Table[2]**--
			tid_RT0 <= "0000000000000101";				--Router 0 [Direction for: RT2 (Go South)]
			packet_type_RT0 <= "10";
			setup_trigger_0 <= '1', '0' after 1 ns;
			
			tid_RT1 <= "0000000000000111";				--Router 1 [Direction for: RT2 (Go West)]
			packet_type_RT1 <= "10";
			setup_trigger_1 <= '1', '0' after 1 ns;
			
			tid_RT2 <= "0000000000001111";				--Router 2 [Direction for: RT2 (Go Ejection)]
			packet_type_RT2 <= "10";
			setup_trigger_2 <= '1', '0' after 1 ns;
			
			tid_RT3 <= "0000000000000111";				--Router 3 [Direction for: RT2 (Go West)]
			packet_type_RT3 <= "10";
			setup_trigger_3 <= '1', '0' after 1 ns;
			
			--**Routing Table[3]**--
			tid_RT0 <= "0000000000000011";				--Router 0 [Direction for: RT3 (Go East)]
			packet_type_RT0 <= "10";
			setup_trigger_0 <= '1', '0' after 1 ns;
			
			tid_RT1 <= "0000000000000101";				--Router 1 [Direction for: RT3 (Go South)]
			packet_type_RT1 <= "10";
			setup_trigger_1 <= '1', '0' after 1 ns;
			
			tid_RT2 <= "0000000000000011";				--Router 2 [Direction for: RT3 (Go East)]
			packet_type_RT2 <= "10";
			setup_trigger_2 <= '1', '0' after 1 ns;
			
			tid_RT3 <= "0000000000001111";				--Router 3 [Direction for: RT3 (Go West)]
			packet_type_RT3 <= "10";
			setup_trigger_3 <= '1', '0' after 1 ns;
			
			wait for clk_period*4;							-- Resets Internal Counters
			
			reset_all <= '1', '0' after 1 ns;
			
			wait for clk_period*4;

			--************************--
			--**Setup Router Address**--
			--************************--
			tid_RT0 <= "0000000000000000";				--Router 0 [Address: 0]
			packet_type_RT0 <= "01";
			setup_trigger_0 <= '1', '0' after 1 ns;
	
			tid_RT1 <= "0000000000000001";				--Router 1 [Address: 1]
			packet_type_RT1 <= "01";
			setup_trigger_1 <= '1', '0' after 1 ns;
			
			tid_RT2 <= "0000000000000010";				--Router 2 [Address: 2]
			packet_type_RT2 <= "01";
			setup_trigger_2 <= '1', '0' after 1 ns;
			
			tid_RT3 <= "0000000000000011";				--Router 3 [Address: 3]
			packet_type_RT3 <= "01";
			setup_trigger_3 <= '1', '0' after 1 ns;
			
			wait for clk_period*4;							-- Resets Internal Counters
			
			reset_all <= '1', '0' after 1 ns;
			
			wait for clk_period*4;
			
			router_start <= '1';
		end if;
	
		if(router_start = '1') then
			
			--Send a test packet
			rsv_port_RT0 <= "010";
			dst_address_RT0 <= "0001";
			trigger_0 <= '1', '0' after 1 ns;
			
		else
			wait for clk_period;
			
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
   router0_stim_proc: process
		variable pid		: std_logic_vector(3 downto 0) := "0000";
	begin		
     	
		--Reset Condition
		if (reset_all = '1') then
			pid := "0000";
		end if;
		
		--Used only for setting up the router at boot
		if(setup_trigger_0 = '1') then
			
			--**************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0xUUU (TID) : MID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0xUUU (RESERVE SOUTH) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE0 <= tid_RT0 & "0000" & pid & rsv_port_RT0 & dst_address_RT0 & packet_type_RT0 & "1";
			sm_triggerPE0 <= '1';
			
			if(done_PE0 = '0') then					--Handshaking
				wait until done_PE0 = '1';
			end if;
			
			sm_triggerPE0 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE0 = '1') then
				wait until full_PE0 = '0';
			end if;
		
			--Increment PID
			pid := pid + "0001";
			
		end if;
		
		
		if (trigger_0 = '1') then
			--**************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0xUUU (TID) : MID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0xUUU (RESERVE SOUTH) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE0 <= tid_RT0 & "0000" & pid & rsv_port_RT0 & dst_address_RT0 & packet_type_RT0 & "1";
			sm_triggerPE0 <= '1';
			
			if(done_PE0 = '0') then					--Handshaking
				wait until done_PE0 = '1';
			end if;
			
			sm_triggerPE0 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE0 = '1') then
				wait until full_PE0 = '0';
			end if;
		
			wait for clk_period*20;
		
			--**************************************************************************************************************************************************--
			--DATA PACKET
			--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0xUUU (SOUTH RESERVED) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE0 <= "0000000000000000" & "0000" & pid & rsv_port_RT0 & dst_address_RT0 & packet_type_RT0 & "0";
			sm_triggerPE0 <= '1';
			
			if(done_PE0 = '0') then					--Handshaking
				wait until done_PE0 = '1';
			end if;
			
			sm_triggerPE0 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE0 = '1') then
				wait until full_PE0 = '0';
			end if;
			
			--Increment PID
			pid := pid + "0001";
		else
			wait for clk_period;
		end if;	
		
end process;
		
		
--*****************************--
--**ROUTER 1 STIMULUS PROCESS**--
--*****************************--
   router1_stim_proc: process
		variable pid		: std_logic_vector(3 downto 0) := "0000";
   begin		
     	
		--Reset Condition
		if (reset_all = '1') then
			pid := "0000";
		end if;
		
		--Used only for setting up the router at boot
		if (setup_trigger_1) then
			--**************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0xUUU (TID) : MID = 0x01 (SOURCE)	: PID = 0xUU (PKT ID) :	DIR = 0xUUU (RESERVE SOUTH) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE1 <= tid_RT1 & "0000" & pid & rsv_port_RT1 & dst_address_RT1 & packet_type_RT1 & "1";
			sm_triggerPE1 <= '1';
			
			if(done_PE1 = '0') then					--Handshaking
				wait until done_PE1 = '1';
			end if;
			
			sm_triggerPE1 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE1 = '1') then
				wait until full_PE1 = '0';
			end if;
		
			--Increment PID
			pid := pid + "0001";
			
		end if;
		
		if (trigger_1 = '1') then
			--**************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0xUUU (TID) : MID = 0x01 (SOURCE)	: PID = 0xUU (PKT ID) :	DIR = 0xUUU (RESERVE SOUTH) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE1 <= tid_RT1 & "0000" & pid & rsv_port_RT1 & dst_address_RT1 & packet_type_RT1 & "1";
			sm_triggerPE1 <= '1';
			
			if(done_PE1 = '0') then					--Handshaking
				wait until done_PE1 = '1';
			end if;
			
			sm_triggerPE1 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE1 = '1') then
				wait until full_PE1 = '0';
			end if;
		
			wait for clk_period*20;
		
			--**************************************************************************************************************************************************--
			--DATA PACKET
			--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0xUUU (SOUTH RESERVED) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE1 <= "0000000000000001" & "0000" & pid & rsv_port_RT1 & dst_address_RT1 & packet_type_RT1 & "0";
			sm_triggerPE1 <= '1';
			
			if(done_PE1 = '0') then					--Handshaking
				wait until done_PE1 = '1';
			end if;
			
			sm_triggerPE1 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE1 = '1') then
				wait until full_PE1 = '0';
			end if;
			
			--Increment PID
			pid := pid + "0001";
		else
			wait for clk_period;
		end if;
	end process;
	
	
--*****************************--
--**ROUTER 2 STIMULUS PROCESS**--
--*****************************--
   router2_stim_proc: process
		variable pid		: std_logic_vector(3 downto 0) := "0000";
   begin		
     	
		--Reset Condition
		if (reset_all = '1') then
			pid := "0000";
		end if;
		
		if (setup_trigger_2 = '1') then
			--**************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0xUUU (TID) : MID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0xUUU (RESERVE SOUTH) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE2 <= tid_RT2 & "0000" & pid & rsv_port_RT2 & dst_address_RT2 & packet_type_RT2 & "1";
			sm_triggerPE2 <= '1';
			
			if(done_PE2 = '0') then					--Handshaking
				wait until done_PE2 = '1';
			end if;
			
			sm_triggerPE2 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE2 = '1') then
				wait until full_PE2 = '0';
			end if;
			
			--Increment PID
			pid := pid + "0001";
			
		end if;
		
		if (trigger_2 = '1') then
			--**************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0xUUU (TID) : MID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0xUUU (RESERVE SOUTH) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE2 <= tid_RT2 & "0000" & pid & rsv_port_RT2 & dst_address_RT2 & packet_type_RT2 & "1";
			sm_triggerPE2 <= '1';
			
			if(done_PE2 = '0') then					--Handshaking
				wait until done_PE2 = '1';
			end if;
			
			sm_triggerPE2 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE2 = '1') then
				wait until full_PE2 = '0';
			end if;
		
			wait for clk_period*20;
		
			--**************************************************************************************************************************************************--
			--DATA PACKET
			--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0xUUU (SOUTH RESERVED) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE2 <= "0000000000000010" & "0000" & pid & rsv_port_RT2 & dst_address_RT2 & packet_type_RT2 & "0";
			sm_triggerPE2 <= '1';
			
			if(done_PE2 = '0') then					--Handshaking
				wait until done_PE2 = '1';
			end if;
			
			sm_triggerPE2 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE2 = '1') then
				wait until full_PE2 = '0';
			end if;
			
			--Increment PID
			pid := pid + "0001";
			
		else
			wait for clk_period;
		end if;
	end process;
	
--*****************************--
--**ROUTER 3 STIMULUS PROCESS**--
--*****************************--
   router3_stim_proc: process
		variable pid		: std_logic_vector(3 downto 0) := "0000";
   begin		
     	
		--Reset Condition
		if (reset_all = '1') then
			pid := "0000";
		end if;
		
		if (setup_trigger_3 = '1') then
			--**************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0xUUU (TID) : MID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0xUUU (RESERVE SOUTH) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE3 <= tid_RT3 & "0000" & pid & rsv_port_RT3 & dst_address_RT3 & packet_type_RT3 & "1";
			sm_triggerPE3 <= '1';
			
			if(done_PE3 = '0') then					--Handshaking
				wait until done_PE3 = '1';
			end if;
			
			sm_triggerPE3 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE3 = '1') then
				wait until full_PE3 = '0';
			end if;
			
			--Increment PID
			pid := pid + "0001";
		
		end if;
		
		if (trigger_3 = '1') then
			--**************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0xUUU (TID) : MID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0xUUU (RESERVE SOUTH) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE3 <= tid_RT3 & "0000" & pid & rsv_port_RT3 & dst_address_RT3 & packet_type_RT3 & "1";
			sm_triggerPE3 <= '1';
			
			if(done_PE3 = '0') then					--Handshaking
				wait until done_PE3 = '1';
			end if;
			
			sm_triggerPE3 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE3 = '1') then
				wait until full_PE3 = '0';
			end if;
		
			wait for clk_period*20;
		
			--**************************************************************************************************************************************************--
			--DATA PACKET
			--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0xUUU (SOUTH RESERVED) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE3 <= "0000000000000011" & "0000" & pid & rsv_port_RT3 & dst_address_RT3 & packet_type_RT3 & "0";
			sm_triggerPE3 <= '1';
			
			if(done_PE3 = '0') then					--Handshaking
				wait until done_PE3 = '1';
			end if;
			
			sm_triggerPE3 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE3 = '1') then
				wait until full_PE3 = '0';
			end if;
			
			--Increment PID
			pid := pid + "0001";
			
		else
			wait for clk_period;
		end if;
	end process;
END;
