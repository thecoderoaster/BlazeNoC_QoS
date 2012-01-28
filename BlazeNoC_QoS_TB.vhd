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
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
