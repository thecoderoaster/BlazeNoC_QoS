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
	signal router_start 		: std_logic;
	signal stim_start 		: std_logic;
	signal reset_all 			: std_logic;
	
	--Router 0
	signal router0_setup_done : std_logic;
	signal trigger_0 			: std_logic;
	signal tid_RT0 			: std_logic_vector(15 downto 0);
	signal rsv_port_RT0		: std_logic_vector(2 downto 0);
	signal dst_address_RT0	: std_logic_vector(3 downto 0);
	
	--Router 1
	signal router1_setup_done : std_logic;
	signal trigger_1 			: std_logic;
	signal tid_RT1 			: std_logic_vector(15 downto 0);
	signal rsv_port_RT1		: std_logic_vector(2 downto 0);
	signal dst_address_RT1	: std_logic_vector(3 downto 0);
	
	--Router 2
	signal router2_setup_done : std_logic;
	signal trigger_2 			: std_logic;
	signal tid_RT2 			: std_logic_vector(15 downto 0);
	signal rsv_port_RT2		: std_logic_vector(2 downto 0);
	signal dst_address_RT2	: std_logic_vector(3 downto 0);
	
	--Router 3
	signal router3_setup_done : std_logic;
	signal trigger_3 			: std_logic;
	signal tid_RT3 			: std_logic_vector(15 downto 0);
	signal rsv_port_RT3		: std_logic_vector(2 downto 0);
	signal dst_address_RT3	: std_logic_vector(3 downto 0);
	
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
		  
	
	-- Stimulus can start once all routers are done with setup.
	--stim_start <= '1' when (router0_setup_done = '1' and router1_setup_done = '1' and router2_setup_done = '1' and router3_setup_done = '1') else '0';	  

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
		router_start <= '0';
      reset <= '0';
		
		--Initiate a Reset		
		wait for clk_period*2;
		reset <= '1', '0' after clk_period;
	
      wait for clk_period*10;
		
		router_start <= '1', '0' after clk_period*4;
		
		wait;
		
	end process;
 
--******************-- 
--**ROUTER 0 SETUP**--
--******************--
	router0_setup: process
	begin
		if (router_start = '1') then
			--******************************--
			--**Setup Router Watchdog Seed**--
			--******************************--
			
			--PAYLOAD = 0x000F (SEED: 15) : MID = 0x00 (DST ADDRESS) : PID = 0x00 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE0 <= "0000000000001111" & "0000" & "0000" & "000" & "0000" & "11" & "1";
			sm_triggerPE0 <= '1';
			
			if(done_PE0 = '0') then					--Handshaking
				wait until done_PE0 = '1';
			end if;
			
			sm_triggerPE0 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE0 = '1') then
				wait until full_PE0 = '0';
			end if;
		
			--***********************--
			--**Setup Routing Table**--
			--***********************--
			
			--PAYLOAD = 0x000F (PORT - Ejection) : MID = 0x00 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE0 <= "0000000000001111" & "0000" & "0001" & "000" & "0000" & "10" & "1";
			sm_triggerPE0 <= '1';
			
			if(done_PE0 = '0') then					--Handshaking
				wait until done_PE0 = '1';
			end if;
			
			sm_triggerPE0 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE0 = '1') then
				wait until full_PE0 = '0';
			end if;
			
			--PAYLOAD = 0x0003 (PORT - East) : MID = 0x01 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE0 <= "0000000000000011" & "0001" & "0001" & "000" & "0000" & "10" & "1";
			sm_triggerPE0 <= '1';
			
			if(done_PE0 = '0') then					--Handshaking
				wait until done_PE0 = '1';
			end if;
			
			sm_triggerPE0 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE0 = '1') then
				wait until full_PE0 = '0';
			end if;
			
			--PAYLOAD = 0x0005 (PORT - South) : MID = 0x02 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE0 <= "0000000000000101" & "0010" & "0001" & "000" & "0000" & "10" & "1";
			sm_triggerPE0 <= '1';
			
			if(done_PE0 = '0') then					--Handshaking
				wait until done_PE0 = '1';
			end if;
			
			sm_triggerPE0 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE0 = '1') then
				wait until full_PE0 = '0';
			end if;
			
			--PAYLOAD = 0x0003 (PORT - East) : MID = 0x03 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE0 <= "0000000000000011" & "0011" & "0001" & "000" & "0000" & "10" & "1";
			sm_triggerPE0 <= '1';
			
			if(done_PE0 = '0') then					--Handshaking
				wait until done_PE0 = '1';
			end if;
			
			sm_triggerPE0 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE0 = '1') then
				wait until full_PE0 = '0';
			end if;
			
			--************************--
			--**Setup Router Address**--
			--************************--
			
			--PAYLOAD = 0x0101 (Address - 0) : MID = 0x0F	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE0 <= "0000000000000000" & "0001" & "0001" & "000" & "0000" & "01" & "1";
			sm_triggerPE0 <= '1';
			
			if(done_PE0 = '0') then					--Handshaking
				wait until done_PE0 = '1';
			end if;
			
			sm_triggerPE0 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE0 = '1') then
				wait until full_PE0 = '0';
			end if;
			
			--Done!
			router0_setup_done <= '1';
		else
			wait for clk_period*2;
		end if;
		
	end process;

--******************--
--**ROUTER 1 SETUP**--
--******************--
	router1_setup: process
	begin
		if (router_start = '1') then
		
			--******************************--
			--**Setup Router Watchdog Seed**--
			--******************************--
			
			--PAYLOAD = 0x0040 (SEED - 64) : MID = 0x00 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE1 <= "0000000001000000" & "0000" & "0000" & "000" & "0000" & "11" & "1";
			sm_triggerPE1 <= '1';
			
			if(done_PE1 = '0') then					--Handshaking
				wait until done_PE1 = '1';
			end if;
			
			sm_triggerPE1 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE1 = '1') then
				wait until full_PE1 = '0';
			end if;
			
			--***********************--
			--**Setup Routing Table**--
			--***********************--
			
			--PAYLOAD = 0x0007 (PORT - West) : MID = 0x00 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE1 <= "0000000000000111" & "0000" & "0001" & "000" & "0000" & "10" & "1";
			sm_triggerPE1 <= '1';
			
			if(done_PE1 = '0') then					--Handshaking
				wait until done_PE1 = '1';
			end if;
			
			sm_triggerPE1 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE1 = '1') then
				wait until full_PE1 = '0';
			end if;
			
			--PAYLOAD = 0x000F (PORT - Ejection) : MID = 0x01 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE1 <= "0000000000001111" & "0001" & "0001" & "000" & "0000" & "10" & "1";
			sm_triggerPE1 <= '1';
			
			if(done_PE1 = '0') then					--Handshaking
				wait until done_PE1 = '1';
			end if;
			
			sm_triggerPE1 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE1 = '1') then
				wait until full_PE1 = '0';
			end if;
			
			--PAYLOAD = 0x0007 (PORT - West) : MID = 0x02 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE1 <= "0000000000000111" & "0010" & "0001" & "000" & "0000" & "10" & "1";
			sm_triggerPE1 <= '1';
			
			if(done_PE1 = '0') then					--Handshaking
				wait until done_PE1 = '1';
			end if;
			
			sm_triggerPE1 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE1 = '1') then
				wait until full_PE1 = '0';
			end if;
			
			--PAYLOAD = 0x0005 (PORT - South) : MID = 0x03 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE1 <= "0000000000000101" & "0011" & "0001" & "000" & "0000" & "10" & "1";
			sm_triggerPE1 <= '1';
			
			if(done_PE1 = '0') then					--Handshaking
				wait until done_PE1 = '1';
			end if;
			
			sm_triggerPE1 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE1 = '1') then
				wait until full_PE1 = '0';
			end if;
		
			
			--************************--
			--**Setup Router Address**--
			--************************--
			
			--PAYLOAD = 0x0001 (Address - 1) : MID = 0x0F	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE1 <= "0000000000000001" & "0001" & "0001" & "000" & "0000" & "01" & "1";
			sm_triggerPE1 <= '1';
			
			if(done_PE1 = '0') then					--Handshaking
				wait until done_PE1 = '1';
			end if;
			
			sm_triggerPE1 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE1 = '1') then
				wait until full_PE1 = '0';
			end if;
			
			--Done!
			router1_setup_done <= '1';
		else
			wait for clk_period*2;
		end if;
		
	end process;

--******************--
--**ROUTER 2 SETUP**--
--******************--
	router2_setup: process
	begin
		if (router_start = '1') then
			--******************************--
			--**Setup Router Watchdog Seed**--
			--******************************--
			
			--PAYLOAD = 0x0009 (Seed - 9) : MID = 0x00 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE2 <= "0000000000001001" & "0000" & "0000" & "000" & "0000" & "11" & "1";
			sm_triggerPE2 <= '1';
			
			if(done_PE2 = '0') then					--Handshaking
				wait until done_PE2 = '1';
			end if;
			
			sm_triggerPE2 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE2 = '1') then
				wait until full_PE2 = '0';
			end if;
			
			--***********************--
			--**Setup Routing Table**--
			--***********************--
			
			--PAYLOAD = 0x0001 (PORT - North) : MID = 0x00 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE2 <= "0000000000000001" & "0000" & "0001" & "000" & "0000" & "10" & "1";
			sm_triggerPE2 <= '1';
			
			if(done_PE2 = '0') then					--Handshaking
				wait until done_PE2 = '1';
			end if;
			
			sm_triggerPE2 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE2 = '1') then
				wait until full_PE2 = '0';
			end if;
			
			--PAYLOAD = 0x0002 (PORT - East) : MID = 0x01 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE2 <= "0000000000000011" & "0001" & "0001" & "000" & "0000" & "10" & "1";
			sm_triggerPE2 <= '1';
			
			if(done_PE2 = '0') then					--Handshaking
				wait until done_PE2 = '1';
			end if;
			
			sm_triggerPE2 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE2 = '1') then
				wait until full_PE2 = '0';
			end if;
			
			--PAYLOAD = 0x000F (PORT - Ejection) : MID = 0x02 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE2 <= "0000000000001111" & "0010" & "0001" & "000" & "0000" & "10" & "1";
			sm_triggerPE2 <= '1';
			
			if(done_PE2 = '0') then					--Handshaking
				wait until done_PE2 = '1';
			end if;
			
			sm_triggerPE2 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE2 = '1') then
				wait until full_PE2 = '0';
			end if;
			
			--PAYLOAD = 0x0003 (PORT - East) : MID = 0x03 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE2 <= "0000000000000011" & "0011" & "0001" & "000" & "0000" & "10" & "1";
			sm_triggerPE2 <= '1';
			
			if(done_PE2 = '0') then					--Handshaking
				wait until done_PE2 = '1';
			end if;
			
			sm_triggerPE2 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE2 = '1') then
				wait until full_PE2 = '0';
			end if;
			
			--************************--
			--**Setup Router Address**--
			--************************--
			
			--PAYLOAD = 0x0002 (Address - 2) : MID = 0x01 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE2 <= "0000000000000010" & "0001" & "0001" & "000" & "0000" & "01" & "1";
			sm_triggerPE2 <= '1';
			
			if(done_PE2 = '0') then					--Handshaking
				wait until done_PE2 = '1';
			end if;
			
			sm_triggerPE2 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE2 = '1') then
				wait until full_PE2 = '0';
			end if;
			
			--Done!
			router2_setup_done <= '1';
			
		else
			wait for clk_period*2;
		end if;

	end process;
	
--******************--
--**ROUTER 3 SETUP**--
--******************--
	router3_setup: process
	begin
		if (router_start = '1') then
		
			--******************************--
			--**Setup Router Watchdog Seed**--
			--******************************--
			
			--PAYLOAD = 0x0001 (Seed - 25) : MID = 0x00 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE3 <= "0000000000011001" & "0000" & "0000" & "000" & "0000" & "11" & "1";
			sm_triggerPE3 <= '1';
			
			if(done_PE3 = '0') then					--Handshaking
				wait until done_PE3 = '1';
			end if;
			
			sm_triggerPE3 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE3 = '1') then
				wait until full_PE3 = '0';
			end if;
				
			
			--***********************--
			--**Setup Routing Table**--
			--***********************--
			
			--PAYLOAD = 0x0001 (PORT - North) : MID = 0x00 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE3 <= "0000000000000001" & "0000" & "0001" & "000" & "0000" & "10" & "1";
			sm_triggerPE3 <= '1';
			
			if(done_PE3 = '0') then					--Handshaking
				wait until done_PE3 = '1';
			end if;
			
			sm_triggerPE3 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE3 = '1') then
				wait until full_PE3 = '0';
			end if;
			
			--PAYLOAD = 0x0001 (PORT - North) : MID = 0x01 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE3 <= "0000000000000001" & "0001" & "0001" & "000" & "0000" & "10" & "1";
			sm_triggerPE3 <= '1';
			
			if(done_PE3 = '0') then					--Handshaking
				wait until done_PE3 = '1';
			end if;
			
			sm_triggerPE3 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE3 = '1') then
				wait until full_PE3 = '0';
			end if;
			
			--PAYLOAD = 0x0007 (PORT - West) : MID = 0x02 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE3 <= "0000000000000111" & "0010" & "0001" & "000" & "0000" & "10" & "1";
			sm_triggerPE3 <= '1';
			
			if(done_PE3 = '0') then					--Handshaking
				wait until done_PE3 = '1';
			end if;
			
			sm_triggerPE3 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE3 = '1') then
				wait until full_PE3 = '0';
			end if;
			
			--PAYLOAD = 0x000F (PORT - Ejection) : MID = 0x03 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE3 <= "0000000000001111" & "0011" & "0001" & "000" & "0000" & "10" & "1";
			sm_triggerPE3 <= '1';
			
			if(done_PE3 = '0') then					--Handshaking
				wait until done_PE3 = '1';
			end if;
			
			sm_triggerPE3 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE3 = '1') then
				wait until full_PE3 = '0';
			end if;
			
			--************************--
			--**Setup Router Address**--
			--************************--
			
			--PAYLOAD = 0x0003 (Address - 3) : MID = 0x01 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
			data_inject_PE3 <= "0000000000000011" & "0001" & "0001" & "000" & "0000" & "01" & "1";
			sm_triggerPE3 <= '1';
			
			if(done_PE3 = '0') then					--Handshaking
				wait until done_PE3 = '1';
			end if;
			
			sm_triggerPE3 <= '0';
				
			wait for clk_period*2;
		
			if(full_PE3 = '1') then
				wait until full_PE3 = '0';
			end if;
				
			--Done!
			router3_setup_done <= '1';
			
		else
			wait for clk_period*2;
		end if;

	end process;
	
--******************--	
--** MAIN PROCESS **--
--******************-- 
	main_proc: process(stim_start)
	begin
		if(stim_start = '1') then
			
			--Send a test packet
			rsv_port_RT0 <= "010";
			dst_address_RT0 <= "0001";
			trigger_0 <= '1', '0' after 1 ns;
			
		end if;
		
	end process;

--*************************--
--**HOT INJECTION PROCESS**--
--*************************--
	hot_inject: process(stim_start)
	begin
		if (stim_start = '1') then
		
		end if;
	end process;

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
		
		if (trigger_0 = '1') then
			--**************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0xUUU (TID) : MID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0xUUU (RESERVE SOUTH) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE0 <= tid_RT0 & "0000" & pid & rsv_port_RT0 & dst_address_RT0 & "00" & "1";
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
			data_inject_PE0 <= "0000000000000000" & "0000" & pid & rsv_port_RT0 & dst_address_RT0 & "00" & "0";
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
			wait for clk_period*2;
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
		
		if (trigger_1 = '1') then
			--**************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0xUUU (TID) : MID = 0x01 (SOURCE)	: PID = 0xUU (PKT ID) :	DIR = 0xUUU (RESERVE SOUTH) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE1 <= tid_RT1 & "0000" & pid & rsv_port_RT1 & dst_address_RT1 & "00" & "1";
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
			data_inject_PE1 <= "0000000000000001" & "0000" & pid & rsv_port_RT1 & dst_address_RT1 & "00" & "0";
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
			wait for clk_period*2;
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
		
		if (trigger_2 = '1') then
			--**************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0xUUU (TID) : MID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0xUUU (RESERVE SOUTH) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE2 <= tid_RT2 & "0000" & pid & rsv_port_RT2 & dst_address_RT2 & "00" & "1";
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
			data_inject_PE2 <= "0000000000000010" & "0000" & pid & rsv_port_RT2 & dst_address_RT2 & "00" & "0";
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
			wait for clk_period*2;
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
		
		if (trigger_3 = '1') then
			--**************************************************************************************************************************************************--
			--CONTROL PACKET
			--PAYLOAD = 0xUUU (TID) : MID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0xUUU (RESERVE SOUTH) : ADDR = 0xUU (DST ROUTER ADDRESS) : COND = 0x00
			--**************************************************************************************************************************************************--
			data_inject_PE3 <= tid_RT3 & "0000" & pid & rsv_port_RT3 & dst_address_RT3 & "00" & "1";
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
			data_inject_PE3 <= "0000000000000011" & "0000" & pid & rsv_port_RT3 & dst_address_RT3 & "00" & "0";
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
			wait for clk_period*2;
		end if;
	end process;
END;
