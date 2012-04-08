--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:30:50 10/08/2011
-- Design Name:   
-- Module Name:   C:/Users/kor/Documents/BlazeRouter_M/BlazeRouter_TB.vhd
-- Project Name:  BlazeRouter_M
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BlazeRouter
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
 
ENTITY BlazeRouter_TB IS
END BlazeRouter_TB;
 
ARCHITECTURE behavior OF BlazeRouter_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BlazeRouter
    PORT(
         north_data_in : IN  std_logic_vector(33 downto 0);
         north_din_good : IN  std_logic;
         north_CTR_in : IN  std_logic;
         north_data_out : OUT  std_logic_vector(33 downto 0);
         north_dout_good : OUT  std_logic;
         north_CTR_out : OUT  std_logic;
         east_data_in : IN  std_logic_vector(33 downto 0);
         east_din_good : IN  std_logic;
         east_CTR_in : IN  std_logic;
         east_data_out : OUT  std_logic_vector(33 downto 0);
         east_dout_good : OUT  std_logic;
         east_CTR_out : OUT  std_logic;
         south_data_in : IN  std_logic_vector(33 downto 0);
         south_din_good : IN  std_logic;
         south_CTR_in : IN  std_logic;
         south_data_out : OUT  std_logic_vector(33 downto 0);
         south_dout_good : OUT  std_logic;
         south_CTR_out : OUT  std_logic;
         west_data_in : IN  std_logic_vector(33 downto 0);
         west_din_good : IN  std_logic;
         west_CTR_in : IN  std_logic;
         west_data_out : OUT  std_logic_vector(33 downto 0);
         west_dout_good : OUT  std_logic;
         west_CTR_out : OUT  std_logic;
         injection_data : IN  std_logic_vector(33 downto 0);
         injection_enq : IN  std_logic;
         injection_status : OUT  std_logic_vector(1 downto 0);
         ejection_data : OUT  std_logic_vector(33 downto 0);
         ejection_deq : IN  std_logic;
         ejection_status : OUT  std_logic_vector(1 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal north_data_in : std_logic_vector(33 downto 0) := (others => '0');
   signal north_din_good : std_logic := '0';
   signal north_CTR_in : std_logic := '0';
   signal east_data_in : std_logic_vector(33 downto 0) := (others => '0');
   signal east_din_good : std_logic := '0';
   signal east_CTR_in : std_logic := '0';
   signal south_data_in : std_logic_vector(33 downto 0) := (others => '0');
   signal south_din_good : std_logic := '0';
   signal south_CTR_in : std_logic := '0';
   signal west_data_in : std_logic_vector(33 downto 0) := (others => '0');
   signal west_din_good : std_logic := '0';
   signal west_CTR_in : std_logic := '0';
   signal injection_data : std_logic_vector(33 downto 0) := (others => '0');
   signal injection_enq : std_logic := '0';
   signal ejection_deq : std_logic := '0';
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal north_data_out : std_logic_vector(33 downto 0);
   signal north_dout_good : std_logic;
   signal north_CTR_out : std_logic;
   signal east_data_out : std_logic_vector(33 downto 0);
   signal east_dout_good : std_logic;
   signal east_CTR_out : std_logic;
   signal south_data_out : std_logic_vector(33 downto 0);
   signal south_dout_good : std_logic;
   signal south_CTR_out : std_logic;
   signal west_data_out : std_logic_vector(33 downto 0);
   signal west_dout_good : std_logic;
   signal west_CTR_out : std_logic;
   signal injection_status : std_logic_vector(1 downto 0);
   signal ejection_data : std_logic_vector(33 downto 0);
   signal ejection_status : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BlazeRouter PORT MAP (
          north_data_in => north_data_in,
          north_din_good => north_din_good,
          north_CTR_in => north_CTR_in,
          north_data_out => north_data_out,
          north_dout_good => north_dout_good,
          north_CTR_out => north_CTR_out,
          east_data_in => east_data_in,
          east_din_good => east_din_good,
          east_CTR_in => east_CTR_in,
          east_data_out => east_data_out,
          east_dout_good => east_dout_good,
          east_CTR_out => east_CTR_out,
          south_data_in => south_data_in,
          south_din_good => south_din_good,
          south_CTR_in => south_CTR_in,
          south_data_out => south_data_out,
          south_dout_good => south_dout_good,
          south_CTR_out => south_CTR_out,
          west_data_in => west_data_in,
          west_din_good => west_din_good,
          west_CTR_in => west_CTR_in,
          west_data_out => west_data_out,
          west_dout_good => west_dout_good,
          west_CTR_out => west_CTR_out,
          injection_data => injection_data,
          injection_enq => injection_enq,
          injection_status => injection_status,
          ejection_data => ejection_data,
          ejection_deq => ejection_deq,
          ejection_status => ejection_status,
          clk => clk,
          reset => reset
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

		--***STEP 1: Update Routing Table***
		
		--PAYLOAD = 0x0001 (PORT - West) : GID = 0x00 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		injection_data <= "0000000000000111" & "0000" & "0001" & "000" & "0000" & "10" & "1";
		injection_enq <= '1', '0' after 1 ns;
		
		wait for clk_period*20;
		
		--PAYLOAD = 0x0007 (PORT - North) : GID = 0x01 (DST ADDRESS) : PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		injection_data <= "0000000000000001" & "0001" & "0001" & "000" & "0000" & "10" & "1";
		injection_enq <= '1', '0' after 1 ns;
		
		wait for clk_period*20;
		
		--PAYLOAD = 0x0001 (PORT - East) : GID = 0x02 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		injection_data <= "0000000000000011" & "0010" & "0001" & "000" & "0000" & "10" & "1";
		injection_enq <= '1', '0' after 1 ns;
		
		wait for clk_period*20;
		
		--PAYLOAD = 0x0002 (PORT - East) : GID = 0x03 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		injection_data <= "0000000000000011" & "0011" & "0001" & "000" & "0000" & "10" & "1";
		injection_enq <= '1', '0' after 1 ns;
		
		wait for clk_period*20;
		
		--PAYLOAD = 0x0003 (PORT - West) : GID = 0x04 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		injection_data <= "0000000000000111" & "0100" & "0001" & "000" & "0000" & "10" & "1";
		injection_enq <= '1', '0' after 1 ns;
		
		wait for clk_period*20;
		
		--PAYLOAD = 0x0002 (PORT - Ejection) : GID = 0x05 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		injection_data <= "0000000000001111" & "0101" & "0001" & "000" & "0000" & "10" & "1";
		injection_enq <= '1', '0' after 1 ns;
		
		wait for clk_period*20;
		
		--PAYLOAD = 0x0003 (PORT - East) : GID = 0x06 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		injection_data <= "0000000000000011" & "0110" & "0001" & "000" & "0000" & "10" & "1";
		injection_enq <= '1', '0' after 1 ns;
		
		wait for clk_period*20;
		
		--PAYLOAD = 0x0000 (PORT - East) : GID = 0x07 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		injection_data <= "0000000000000011" & "0111" & "0001" & "000" & "0000" & "10" & "1";
		injection_enq <= '1', '0' after 1 ns;
		
		wait for clk_period*20;
		
		--PAYLOAD = 0x0001 (PORT - South) : GID = 0x08	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		injection_data <= "0000000000000101" & "1000" & "0001" & "000" & "0000" & "10" & "1";
		injection_enq <= '1', '0' after 1 ns;
		
		wait for clk_period*20;
		
		--PAYLOAD = 0x0002 (PORT - South) : GID = 0x09	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		injection_data <= "0000000000000101" & "1001" & "0001" & "000" & "0000" & "10" & "1";
		injection_enq <= '1', '0' after 1 ns;
		
		wait for clk_period*20;
		
		--PAYLOAD = 0x0000 (PORT - East) : GID = 0x0A	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		injection_data <= "0000000000000011" & "1010" & "0001" & "000" & "0000" & "10" & "1";
		injection_enq <= '1', '0' after 1 ns;
		
		wait for clk_period*20;
		
		--PAYLOAD = 0x0001 (PORT - South) : GID = 0x0B	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		injection_data <= "0000000000000101" & "1011" & "0001" & "000" & "0000" & "10" & "1";
		injection_enq <= '1', '0' after 1 ns;
		
		wait for clk_period*20;
		
		--PAYLOAD = 0x0002 (PORT - West) : GID = 0x0C	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		injection_data <= "0000000000000111" & "1100" & "0001" & "000" & "0000" & "10" & "1";
		injection_enq <= '1', '0' after 1 ns;
		
		wait for clk_period*20;
		
		--PAYLOAD = 0x0003 (PORT - South) : GID = 0x0D	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		injection_data <= "0000000000000101" & "1101" & "0001" & "000" & "0000" & "10" & "1";
		injection_enq <= '1', '0' after 1 ns;
		
		wait for clk_period*20;
		
		--PAYLOAD = 0x0002 (PORT - East) : GID = 0x0E	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		injection_data <= "0000000000000011" & "1110" & "0001" & "000" & "0000" & "10" & "1";
		injection_enq <= '1', '0' after 1 ns;
		
		wait for clk_period*20;
		
		--PAYLOAD = 0x0000 (PORT - East) : GID = 0x0F	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		injection_data <= "0000000000000011" & "1111" & "0001" & "000" & "0000" & "10" & "1";
		injection_enq <= '1', '0' after 1 ns;
		
		wait for clk_period*20;
		
		--***STEP 2: Update Router Address***
		
		--PAYLOAD = 0x0101 (Address - 5) : GID = 0x0F	 (DST ADDRESS): PID = 0x01 (PKT ID) : DIR = 0x00 : ADDR = 0x00 (SRC ADDRESS) : COND = 0x01
		injection_data <= "0000000000000101" & "0001" & "0001" & "000" & "0000" & "01" & "1";
		injection_enq <= '1', '0' after 1 ns;
		
		wait for clk_period*20;
		
		--***STEP 3: Inject a control packet*** (#1)
		
		--PAYLOAD = 1200 Cycles (TID) : GID = 0x01 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0x011 (WEST) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000010010110000" & "0001" & "0001" & "011" & "0101" & "00" & "1";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a data packet (LEGIT PACKET #1)
		--PAYLOAD = DON'T CARE (ANYTHING) : GID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (WEST) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000000000000000" & "0001" & "0001" & "011" & "0101" & "00" & "0";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a data packet (JUNK PACKET #1)
		--PAYLOAD = DON'T CARE (ANYTHING) : GID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (WEST) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000000000000000" & "0101" & "0010" & "001" & "0101" & "00" & "0";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a data packet (JUNK PACKET #2)
		--PAYLOAD = DON'T CARE (ANYTHING) : GID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (WEST) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000000000010000" & "0001" & "0011" & "001" & "0101" & "00" & "0";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a control packet*** (#2)
		--PAYLOAD = 4500 Cycles (TID) : GID = 0x02 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0x010 (SOUTH) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x01
		north_data_in <= "0001000110010100" & "0010" & "0001" & "010" & "0101" & "00" & "1";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a data packet (JUNK PACKET #3)
		--PAYLOAD = DON'T CARE (ANYTHING) : GID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (WEST) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000000000000000" & "0111" & "0110" & "001" & "0101" & "00" & "0";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a data packet (LEGIT PACKET #2)
		--PAYLOAD = DON'T CARE (ANYTHING) : GID = 0x02 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x010 (SOUTH) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000000000000000" & "0010" & "0001" & "010" & "0101" & "00" & "0";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a data packet (JUNK PACKET #4)
		--PAYLOAD = DON'T CARE (ANYTHING) : GID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (WEST) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000000000010000" & "1111" & "1110" & "001" & "0101" & "00" & "0";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a control packet*** (#3)
		--PAYLOAD = 450 Cycles (TID) : GID = 0x01 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x011 (WEST) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000000111000010" & "0001" & "0010" & "011" & "0101" & "00" & "1";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a data packet (JUNK PACKET #5)
		--PAYLOAD = DON'T CARE (ANYTHING) : GID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (WEST) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000000000010000" & "0010" & "1010" & "001" & "0101" & "00" & "0";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a data packet (JUNK PACKET #6)
		--PAYLOAD = DON'T CARE (ANYTHING) : GID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (WEST) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000000000010000" & "0010" & "1010" & "001" & "0101" & "00" & "0";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a control packet*** (#4)
		--PAYLOAD = 1725 Cycles (TID) : GID = 0x00 (SOURCE)	: PID = 0x01 (PKT ID) :	DIR = 0x001 (EAST) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000011010111101" & "0000" & "0001" & "001" & "0101" & "00" & "1";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a data packet (LEGIT PACKET #3)
		--PAYLOAD = DON'T CARE (ANYTHING) : GID = 0x01 (SOURCE) : PID = 0x02 (PKT ID) : DIR = 0x011 (WEST) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000000000000000" & "0001" & "0010" & "011" & "0101" & "00" & "0";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a data packet (JUNK PACKET #7)
		--PAYLOAD = DON'T CARE (ANYTHING) : GID = 0x01 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x011 (WEST) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000000000010000" & "1101" & "1010" & "001" & "0101" & "00" & "0";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a control packet*** (#5)
		--PAYLOAD = 2350 Cycles (TID) : GID = 0x01 (SOURCE)	: PID = 0x03 (PKT ID) :	DIR = 0x011 (WEST) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000100100101110" & "0001" & "0011" & "011" & "0101" & "00" & "1";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a data packet (LEGIT PACKET #4)
		--PAYLOAD = DON'T CARE (ANYTHING) : GID = 0x00 (SOURCE) : PID = 0x01 (PKT ID) : DIR = 0x001 (EAST) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000000000000000" & "0000" & "0001" & "001" & "0101" & "00" & "0";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a control packet*** (#6)
		--PAYLOAD = 45 Cycles (TID) : GID = 0x00 (SOURCE)	: PID = 0x02 (PKT ID) :	DIR = 0x001 (EAST) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000000000101101" & "0000" & "0010" & "001" & "0101" & "00" & "1";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a data packet (LEGIT PACKET #6)
		--PAYLOAD = DON'T CARE (ANYTHING) : GID = 0x00 (SOURCE) : PID = 0x02 (PKT ID) : DIR = 0x001 (EAST) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000000000000000" & "0000" & "0010" & "001" & "0101" & "00" & "0";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
		--Inject a data packet (LEGIT PACKET #5)
		--PAYLOAD = DON'T CARE (ANYTHING) : GID = 0x01 (SOURCE) : PID = 0x03 (PKT ID) : DIR = 0x011 (WEST) : ADDR = 0x05 (ROUTER ADDRESS) : COND = 0x00
		north_data_in <= "0000000000000000" & "0001" & "0011" & "011" & "0101" & "00" & "0";
		north_din_good <= '1';
		
		wait until north_CTR_out = '1';
		north_din_good <= '0';
		
      wait;
   end process;

END;
