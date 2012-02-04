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
		--PAYLOAD = 0x0001 (PORT - Ejection) : GID = 0x00 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0001 (PORT - East) : GID = 0x01 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0001 (PORT - East) : GID = 0x02 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0002 (PORT - East) : GID = 0x03 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0003 (PORT - West) : GID = 0x04 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0002 (PORT - Ejection) : GID = 0x05 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0003 (PORT - East) : GID = 0x06 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0000 (PORT - East) : GID = 0x07 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0001 (PORT - South) : GID = 0x08	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0002 (PORT - South) : GID = 0x09	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0000 (PORT - East) : GID = 0x0A	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0001 (PORT - South) : GID = 0x0B	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0002 (PORT - West) : GID = 0x0C	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0003 (PORT - South) : GID = 0x0D	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0002 (PORT - East) : GID = 0x0E	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0000 (PORT - East) : GID = 0x0F	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0101 (Address - 0) : GID = 0x0F	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0001 (PORT - West) : GID = 0x00 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0007 (PORT - North) : GID = 0x01 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000001" & "0001" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0001 (PORT - East) : GID = 0x02 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0002 (PORT - East) : GID = 0x03 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0003 (PORT - West) : GID = 0x04 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000111" & "0100" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0002 (PORT - Ejection) : GID = 0x05 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000001111" & "0101" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0003 (PORT - East) : GID = 0x06 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0000 (PORT - East) : GID = 0x07 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0001 (PORT - South) : GID = 0x08	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0002 (PORT - South) : GID = 0x09	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0000 (PORT - East) : GID = 0x0A	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0001 (PORT - South) : GID = 0x0B	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000101" & "1011" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0002 (PORT - West) : GID = 0x0C	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000111" & "1100" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerPE1 <= '1';
		
		if(done_PE1 = '0') then					--Handshaking
			wait until done_PE1 = '1';
		end if;
		
		sm_triggerPE1 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE1 = '1') then
			wait until full_PE1 = '0';
		end if;
		
		--PAYLOAD = 0x0003 (PORT - South) : GID = 0x0D	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0002 (PORT - East) : GID = 0x0E	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		--PAYLOAD = 0x0000 (PORT - East) : GID = 0x0F	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_PE1 <= "0000000000000011" & "1111" & "0001" & "000" & "0000" & "10" & "1";
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
		
		--PAYLOAD = 0x0101 (Address - 1) : GID = 0x0F	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
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
		
		
		--***STEP 3: Inject a control packet*** (#1)
		
		--PAYLOAD = 1200 Cycles (TID) : GID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0x010 (RESERVE SOUTH) : ADDR = 0x06 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0000010010110000" & "0001" & "0001" & "010" & "0001" & "00" & "1";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		
		wait for clk_period*100;
		
		--Inject a data packet (LEGIT PACKET #1)
		--PAYLOAD = DON'T CARE (ANYTHING) : GID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (SOUTH RESERVED) : ADDR = 0x06 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_PE0 <= "0101010101010101" & "0001" & "0001" & "010" & "0001" & "00" & "0";
		sm_triggerPE0 <= '1';
		
		if(done_PE0 = '0') then					--Handshaking
			wait until done_PE0 = '1';
		end if;
		
		sm_triggerPE0 <= '0';
			
		wait for clk_period*2;
	
		if(full_PE0 = '1') then
			wait until full_PE0 = '0';
		end if;
		

      wait;
   end process;

END;
