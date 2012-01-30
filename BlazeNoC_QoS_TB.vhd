--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:31:08 01/27/2012
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
         sm_triggerNPort : IN  std_logic;
         sm_triggerEPort : IN  std_logic;
         sm_triggerSPort : IN  std_logic;
         sm_triggerWPort : IN  std_logic;
         sm_triggerIPort : IN  std_logic;
         data_inject_NPort : IN  std_logic_vector(33 downto 0);
         data_inject_EPort : IN  std_logic_vector(33 downto 0);
         data_inject_SPort : IN  std_logic_vector(33 downto 0);
         data_inject_WPort : IN  std_logic_vector(33 downto 0);
         data_inject_IPort : IN  std_logic_vector(33 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal sm_triggerNPort : std_logic := '0';
   signal sm_triggerEPort : std_logic := '0';
   signal sm_triggerSPort : std_logic := '0';
   signal sm_triggerWPort : std_logic := '0';
   signal sm_triggerIPort : std_logic := '0';
   signal data_inject_NPort : std_logic_vector(33 downto 0) := (others => '0');
   signal data_inject_EPort : std_logic_vector(33 downto 0) := (others => '0');
   signal data_inject_SPort : std_logic_vector(33 downto 0) := (others => '0');
   signal data_inject_WPort : std_logic_vector(33 downto 0) := (others => '0');
   signal data_inject_IPort : std_logic_vector(33 downto 0) := (others => '0');

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BlazeNoC PORT MAP (
          clk => clk,
          reset => reset,
          sm_triggerNPort => sm_triggerNPort,
          sm_triggerEPort => sm_triggerEPort,
          sm_triggerSPort => sm_triggerSPort,
          sm_triggerWPort => sm_triggerWPort,
          sm_triggerIPort => sm_triggerIPort,
          data_inject_NPort => data_inject_NPort,
          data_inject_EPort => data_inject_EPort,
          data_inject_SPort => data_inject_SPort,
          data_inject_WPort => data_inject_WPort,
          data_inject_IPort => data_inject_IPort
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

      -- insert stimulus here 
		--PAYLOAD = 0x0001 (PORT - West) : GID = 0x00 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_IPort <= "0000000000000111" & "0000" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		wait for clk_period*5;
		
		--PAYLOAD = 0x0007 (PORT - North) : GID = 0x01 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_IPort <= "0000000000000001" & "0001" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		wait for clk_period*5;
		
		--PAYLOAD = 0x0001 (PORT - East) : GID = 0x02 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_IPort <= "0000000000000011" & "0010" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		wait for clk_period*5;
		
		--PAYLOAD = 0x0002 (PORT - East) : GID = 0x03 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_IPort <= "0000000000000011" & "0011" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		wait for clk_period*5;
		
		--PAYLOAD = 0x0003 (PORT - West) : GID = 0x04 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_IPort <= "0000000000000111" & "0100" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		wait for clk_period*5;
		
		--PAYLOAD = 0x0002 (PORT - Ejection) : GID = 0x05 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_IPort <= "0000000000001111" & "0101" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		wait for clk_period*5;
		
		--PAYLOAD = 0x0003 (PORT - East) : GID = 0x06 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_IPort <= "0000000000000011" & "0110" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		wait for clk_period*5;
		
		--PAYLOAD = 0x0000 (PORT - East) : GID = 0x07 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_IPort <= "0000000000000011" & "0111" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		wait for clk_period*5;
		
		--PAYLOAD = 0x0001 (PORT - South) : GID = 0x08	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_IPort <= "0000000000000101" & "1000" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		wait for clk_period*5;
		
		--PAYLOAD = 0x0002 (PORT - South) : GID = 0x09	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_IPort <= "0000000000000101" & "1001" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		wait for clk_period*5;
		
		--PAYLOAD = 0x0000 (PORT - East) : GID = 0x0A	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_IPort <= "0000000000000011" & "1010" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		wait for clk_period*5;
		
		--PAYLOAD = 0x0001 (PORT - South) : GID = 0x0B	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_IPort <= "0000000000000101" & "1011" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		wait for clk_period*5;
		
		--PAYLOAD = 0x0002 (PORT - West) : GID = 0x0C	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_IPort <= "0000000000000111" & "1100" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		wait for clk_period*5;
		
		--PAYLOAD = 0x0003 (PORT - South) : GID = 0x0D	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_IPort <= "0000000000000101" & "1101" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		wait for clk_period*5;
		
		--PAYLOAD = 0x0002 (PORT - East) : GID = 0x0E	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_IPort <= "0000000000000011" & "1110" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		wait for clk_period*5;
		
		--PAYLOAD = 0x0000 (PORT - East) : GID = 0x0F	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_IPort <= "0000000000000011" & "1111" & "0001" & "000" & "0000" & "10" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		wait for clk_period*5;
		
		--***STEP 2: Update Router Address***
		
		--PAYLOAD = 0x0101 (Address - 5) : GID = 0x0F	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		data_inject_IPort <= "0000000000000101" & "0001" & "0001" & "000" & "0000" & "01" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		wait for clk_period*5;
		
		--***STEP 3: Inject a control packet*** (#1)
		
		--PAYLOAD = 1200 Cycles (TID) : GID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0x010 (RESERVE SOUTH) : ADDR = 0x06 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_IPort <= "0000010010110000" & "0001" & "0001" & "010" & "0110" & "00" & "1";
		sm_triggerIPort <= '1', '0' after 1 ns;
		
		--wait until north_CTR_out = '1';
		--north_din_good <= '0';
		wait for clk_period*5;
		
		--Inject a data packet (LEGIT PACKET #1)
		--PAYLOAD = DON'T CARE (ANYTHING) : GID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (SOUTH RESERVED) : ADDR = 0x06 (DST ROUTER ADDRESS) : COND = 0x00
		data_inject_IPort <= "0101010101010101" & "0001" & "0001" & "011" & "0110" & "00" & "0";
		sm_triggerIPort <= '1', '0' after 1 ns;
		

      wait;
   end process;

END;
