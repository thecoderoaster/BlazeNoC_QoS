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
 

 -- Stimulus process
   stim_proc: process
   begin		
       -- hold reset state for 100 ns.
      reset <= '0';
		
		--Initiate a Reset		
		wait for clk_period*2;
		reset <= '1', '0' after clk_period;
	
      wait for clk_period*10;

--**ROUTER 0 INFORMATION**--
		--PAYLOAD = 0x0001 (PORT - Ejection) : MID = 0x00 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE0 <= "0000000000001111" & "0000" & "0001" & "000" & "0000" & "10" & "1";
		--sm_triggerPE0 <= '1', '0' after 1 ns;
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		--PAYLOAD = 0x0001 (PORT - East) : MID = 0x01 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0001 (PORT - East) : MID = 0x02 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE0 <= "0000000000000011" & "0010" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		--PAYLOAD = 0x0002 (PORT - East) : MID = 0x03 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0003 (PORT - West) : MID = 0x04 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE0 <= "0000000000000111" & "0100" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		--PAYLOAD = 0x0002 (PORT - Ejection) : MID = 0x05 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE0 <= "0000000000001111" & "0101" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		--PAYLOAD = 0x0003 (PORT - East) : MID = 0x06 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE0 <= "0000000000000011" & "0110" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		--PAYLOAD = 0x0000 (PORT - East) : MID = 0x07 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE0 <= "0000000000000011" & "0111" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		--PAYLOAD = 0x0001 (PORT - South) : MID = 0x08	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE0 <= "0000000000000101" & "1000" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		--PAYLOAD = 0x0002 (PORT - South) : MID = 0x09	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE0 <= "0000000000000101" & "1001" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		--PAYLOAD = 0x0000 (PORT - East) : MID = 0x0A	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE0 <= "0000000000000011" & "1010" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		--PAYLOAD = 0x0001 (PORT - South) : MID = 0x0B	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE0 <= "0000000000000101" & "1011" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		--PAYLOAD = 0x0002 (PORT - West) : MID = 0x0C	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE0 <= "0000000000000111" & "1100" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		--PAYLOAD = 0x0003 (PORT - South) : MID = 0x0D	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE0 <= "0000000000000101" & "1101" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		--PAYLOAD = 0x0002 (PORT - East) : MID = 0x0E	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE0 <= "0000000000000011" & "1110" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		--PAYLOAD = 0x0000 (PORT - East) : MID = 0x0F	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE0 <= "0000000000000011" & "1111" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		--***STEP 2: Update Router Address***
		
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
		
--**ROUTER 1 INFORMATION**--
		
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
		
		--PAYLOAD = 0x000F (PORT - EJECT) : MID = 0x01 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0001 (PORT - East) : MID = 0x02 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000011" & "0010" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0002 (PORT - East) : MID = 0x03 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000011" & "0011" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0005 (PORT - South) : MID = 0x04 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000101" & "0100" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0005 (PORT - South) : MID = 0x05 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000101" & "0101" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0003 (PORT - East) : MID = 0x06 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000011" & "0110" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0003 (PORT - East) : MID = 0x07 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000011" & "0111" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0005 (PORT - South) : MID = 0x08	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000101" & "1000" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0005 (PORT - South) : MID = 0x09	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000101" & "1001" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0003 (PORT - East) : MID = 0x0A	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000011" & "1010" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0003 (PORT - East) : MID = 0x0B	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000011" & "1011" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0005 (PORT - South) : MID = 0x0C	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000101" & "1100" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0005 (PORT - South) : MID = 0x0D	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000101" & "1101" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0003 (PORT - East) : MID = 0x0E	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000011" & "1110" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0005 (PORT - South) : MID = 0x0F	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000101" & "1111" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--***STEP 2: Update Router Address***
		
		--PAYLOAD = 0x0101 (Address - 1) : MID = 0x0F	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
--***********************************************--
		--***STEP 3: Inject control packets***  ROUTER 0
--***********************************************--		
		--CONTROL PACKET (#1)
		--PAYLOAD = 1200 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0x010 (RESERVE SOUTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0000000000000001" & "0000" & "0000" & "010" & "0001" & "00" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		
		wait for clk_period*2;
		
		--CONTROL PACKET (#2)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0000000000000011" & "0000" & "0001" & "000" & "0001" & "00" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		--CONTROL PACKET (#3)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0000000000000111" & "0000" & "0010" & "000" & "0001" & "00" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;

		wait for clk_period*40;
		
		--CONTROL PACKET #4
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0000000000001111" & "0000" & "0011" & "000" & "0001" & "00" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*10;
		
		--CONTROL PACKET #5
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0000000000011111" & "0000" & "0100" & "001" & "0001" & "00" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*15;
		
		--CONTROL PACKET #6
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0000000000111111" & "0000" & "0101" & "011" & "0001" & "00" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;
		
		--CONTROL PACKET #7
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0000000001111111" & "0000" & "0110" & "011" & "0001" & "00" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		--CONTROL PACKET #8
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0000000011111111" & "0000" & "0111" & "000" & "0001" & "00" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;
		
		--CONTROL PACKET #9
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0000000111111111" & "0000" & "1000" & "000" & "0001" & "00" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;
		
		--CONTROL PACKET #10
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0000001111111111" & "0000" & "1001" & "010" & "0001" & "00" & "1";
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
		
		--CONTROL PACKET #11
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0000011111111111" & "0000" & "1010" & "001" & "0001" & "00" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;
		
		--CONTROL PACKET #12
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0000111111111111" & "0000" & "1011" & "000" & "0001" & "00" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;
		
		--CONTROL PACKET #13
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0001111111111111" & "0000" & "1100" & "111" & "0001" & "00" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;
		
		--CONTROL PACKET #14
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0011111111111111" & "0000" & "1101" & "001" & "0001" & "00" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;
		
		--CONTROL PACKET #15
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0111111111111111" & "0000" & "1110" & "010" & "0001" & "00" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;
		
		--CONTROL PACKET #16
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "1111111111111111" & "0000" & "1111" & "000" & "0001" & "00" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;
		
--		--CONTROL PACKET #17
--		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
--		data_inject_PE0 <= "0101010101010101" & "0000" & "0000" & "001" & "0001" & "00" & "1";
--		sm_triggerPE0 <= '1';
--		
--		if(done_PE0 = '0') then					--Handshaking
--			wait until done_PE0 = '1';
--		end if;
--		
--		sm_triggerPE0 <= '0';
--			
--		wait for clk_period*2;
--	
--		if(full_PE0 = '1') then
--			wait until full_PE0 = '0';
--		end if;
--		
--		wait for clk_period*2;
--		
--		--CONTROL PACKET #18
--		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
--		data_inject_PE0 <= "1010101010101010" & "0000" & "0001" & "010" & "0001" & "00" & "1";
--		sm_triggerPE0 <= '1';
--		
--		if(done_PE0 = '0') then					--Handshaking
--			wait until done_PE0 = '1';
--		end if;
--		
--		sm_triggerPE0 <= '0';
--			
--		wait for clk_period*2;
--	
--		if(full_PE0 = '1') then
--			wait until full_PE0 = '0';
--		end if;
--		
--		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #1)
		--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (SOUTH RESERVED) : ADDR = 0x06 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0101010101010101" & "0000" & "0000" & "010" & "0001" & "00" & "0";
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
		
		--Inject a data packet (LEGIT PACKET #2)
		--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (SOUTH RESERVED) : ADDR = 0x06 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "1101010101010111" & "0000" & "0001" & "000" & "0001" & "00" & "0";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*4;
		
		--Inject a data packet (LEGIT PACKET #3)
		--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (SOUTH RESERVED) : ADDR = 0x06 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "1111011101111111" & "0000" & "0010" & "000" & "0001" & "00" & "0";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;

		
		--Inject a data packet (LEGIT PACKET #4)
		--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (SOUTH RESERVED) : ADDR = 0x06 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "1111111101111111" & "0000" & "0011" & "000" & "0001" & "00" & "0";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;

--		--Inject a data packet (INVALID PACKET #4)
--		--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (SOUTH RESERVED) : ADDR = 0x06 (DST ROUTER ADDRESS) : COND = 0x00
--		data_inject_PE0 <= "1111111111111100" & "0000" & "0101" & "001" & "0010" & "00" & "0";
--		sm_triggerPE0 <= '1';
--		
--		if(done_PE0 = '0') then					--Handshaking
--			wait until done_PE0 = '1';
--		end if;
--		
--		sm_triggerPE0 <= '0';
--			
--		wait for clk_period*2;
--	
--		if(full_PE0 = '1') then
--			wait until full_PE0 = '0';
--		end if;

		--Inject a data packet (LEGIT PACKET #5)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "1111100000000000" & "0000" & "0100" & "001" & "0001" & "00" & "0";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*15;
		
		--Inject a data packet (LEGIT PACKET #6)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "1111110000000000" & "0000" & "0101" & "011" & "0001" & "00" & "0";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #7)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "1111111000000000" & "0000" & "0110" & "011" & "0001" & "00" & "0";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		--Inject a data packet (LEGIT PACKET #8)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "1111111100000000" & "0000" & "0111" & "000" & "0001" & "00" & "0";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #9)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "1111111110000000" & "0000" & "1000" & "000" & "0001" & "00" & "0";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #10)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "1111111111000000" & "0000" & "1001" & "010" & "0001" & "00" & "0";
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
		
		--Inject a data packet (LEGIT PACKET #11)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "1111111111100000" & "0000" & "1010" & "001" & "0001" & "00" & "0";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #12)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "1111111111110000" & "0000" & "1011" & "000" & "0001" & "00" & "0";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #13)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "1111111111111000" & "0000" & "1100" & "111" & "0001" & "00" & "0";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #14)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "1111111111111100" & "0000" & "1101" & "001" & "0001" & "00" & "0";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #15)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "1111111111111110" & "0000" & "1110" & "010" & "0001" & "00" & "0";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #16)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "1111111111111111" & "0000" & "1111" & "000" & "0001" & "00" & "0";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*2;



--***********************************************--
		--***STEP 3: Inject control packets***  ROUTER 1
--***********************************************--		
		--CONTROL PACKET (#1)
		--PAYLOAD = 1200 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0x010 (RESERVE SOUTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "0000000000000001" & "0001" & "0000" & "010" & "0000" & "00" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		
		wait for clk_period*2;
		
		--CONTROL PACKET (#2)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "0000000000000011" & "0001" & "0001" & "000" & "0000" & "00" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--CONTROL PACKET (#3)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "0000000000000111" & "0001" & "0010" & "000" & "0000" & "00" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;

		wait for clk_period*40;
		
		--CONTROL PACKET (#4)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "0000000000001111" & "0001" & "0011" & "000" & "0000" & "00" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*10;
		
		--CONTROL PACKET (#5)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "0000000000011111" & "0001" & "0100" & "001" & "0000" & "00" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*15;
		
		--CONTROL PACKET (#6)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "0000000000111111" & "0001" & "0101" & "011" & "0000" & "00" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;
		
		--CONTROL PACKET (#7)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "0000000001111111" & "0001" & "0110" & "011" & "0000" & "00" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--CONTROL PACKET (#8)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "0000000011111111" & "0001" & "0111" & "000" & "0000" & "00" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;
		
		--CONTROL PACKET (#9)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "0000000111111111" & "0001" & "1000" & "000" & "0000" & "00" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;
		
		--CONTROL PACKET (#10)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "0000001111111111" & "0001" & "1001" & "010" & "0000" & "00" & "1";
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
		
		--CONTROL PACKET (#11)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "0000011111111111" & "0001" & "1010" & "001" & "0000" & "00" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;
		
		--CONTROL PACKET (#12)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "0000111111111111" & "0001" & "1011" & "000" & "0000" & "00" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;
		
		--CONTROL PACKET (#13)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "0001111111111111" & "0001" & "1100" & "111" & "0000" & "00" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;
		
		--CONTROL PACKET (#14)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "0011111111111111" & "0001" & "1101" & "001" & "0000" & "00" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;
		
		--CONTROL PACKET (#15)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "0111111111111111" & "0001" & "1110" & "010" & "0000" & "00" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;
		
		--CONTROL PACKET (#16)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "1111111111111111" & "0001" & "1111" & "000" & "0000" & "00" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;
		
--		--CONTROL PACKET (#17)
--		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
--		data_inject_PE1 <= "0101010101010101" & "0001" & "0000" & "001" & "0000" & "00" & "1";
--		sm_triggerPE1 <= '1';
--		
--		if(done_PE1 = '0') then					--Handshaking
--			wait until done_PE1 = '1';
--		end if;
--		
--		sm_triggerPE1 <= '0';
--			
--		wait for clk_period*2;
--	
--		if(full_PE1 = '1') then
--			wait until full_PE1 = '0';
--		end if;
--		
--		wait for clk_period*2;
--		
--		--CONTROL PACKET (#18)
--		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
--		data_inject_PE1 <= "1010101010101010" & "0001" & "0001" & "010" & "0000" & "00" & "1";
--		sm_triggerPE1 <= '1';
--		
--		if(done_PE1 = '0') then					--Handshaking
--			wait until done_PE1 = '1';
--		end if;
--		
--		sm_triggerPE1 <= '0';
--			
--		wait for clk_period*2;
--	
--		if(full_PE1 = '1') then
--			wait until full_PE1 = '0';
--		end if;
--		
--		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #1)
		--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (SOUTH RESERVED) : ADDR = 0x06 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "0101010101010101" & "0001" & "0000" & "010" & "0000" & "00" & "0";
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
		
		--Inject a data packet (LEGIT PACKET #2)
		--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (SOUTH RESERVED) : ADDR = 0x06 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "1101010101010111" & "0001" & "0001" & "000" & "0000" & "00" & "0";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*4;
		
		--Inject a data packet (LEGIT PACKET #3)
		--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (SOUTH RESERVED) : ADDR = 0x06 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "1111011101111111" & "0001" & "0010" & "000" & "0000" & "00" & "0";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;

		
		--Inject a data packet (LEGIT PACKET #4)
		--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (SOUTH RESERVED) : ADDR = 0x06 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "1111111101111111" & "0001" & "0011" & "000" & "0000" & "00" & "0";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;

--		--Inject a data packet (INVALID PACKET #4)
--		--PAYLOAD = DON'T CARE (ANYTHING) : MID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (SOUTH RESERVED) : ADDR = 0x06 (DST ROUTER ADDRESS) : COND = 0x00
--		data_inject_PE1 <= "1111111111111100" & "0001" & "0101" & "001" & "0010" & "00" & "0";
--		sm_triggerPE1 <= '1';
--		
--		if(done_PE1 = '0') then					--Handshaking
--			wait until done_PE1 = '1';
--		end if;
--		
--		sm_triggerPE1 <= '0';
--			
--		wait for clk_period*2;
--	
--		if(full_PE1 = '1') then
--			wait until full_PE1 = '0';
--		end if;

		--Inject a data packet (LEGIT PACKET #5)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "1111100000000000" & "0001" & "0100" & "001" & "0000" & "00" & "0";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*15;
		
		--Inject a data packet (LEGIT PACKET #6)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "1111110000000000" & "0001" & "0101" & "011" & "0000" & "00" & "0";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #7)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "1111111000000000" & "0001" & "0110" & "011" & "0000" & "00" & "0";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--Inject a data packet (LEGIT PACKET #8)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "1111111100000000" & "0001" & "0111" & "000" & "0000" & "00" & "0";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #9)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "1111111110000000" & "0001" & "1000" & "000" & "0000" & "00" & "0";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #10)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "1111111111000000" & "0001" & "1001" & "010" & "0000" & "00" & "0";
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
		
		--Inject a data packet (LEGIT PACKET #11)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "1111111111100000" & "0001" & "1010" & "001" & "0000" & "00" & "0";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #12)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "1111111111110000" & "0001" & "1011" & "000" & "0000" & "00" & "0";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #13)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "1111111111111000" & "0001" & "1100" & "111" & "0000" & "00" & "0";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #14)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "1111111111111100" & "0001" & "1101" & "001" & "0000" & "00" & "0";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #15)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "1111111111111110" & "0001" & "1110" & "010" & "0000" & "00" & "0";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;
		
		--Inject a data packet (LEGIT PACKET #16)
		--PAYLOAD = 2000 Cycles (TID) : MID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x000 (RESERVE NORTH) : ADDR = 0x01 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE1 <= "1111111111111111" & "0001" & "1111" & "000" & "0000" & "00" & "0";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		wait for clk_period*2;



      wait;
   end process;

END;
