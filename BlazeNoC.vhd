----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:58:54 01/08/2012 
-- Design Name: 
-- Module Name:    BlazeNoC - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BlazeNoC is
	port ( clk						: in std_logic; 	-- global clock
			 reset					: in std_logic;
			 
			 sm_triggerN			: in std_logic;
			 sm_triggerS			: in std_logic;
			 sm_triggerE			: in std_logic;
			 sm_triggerW			: in std_logic;
			 sm_triggerInject		: in std_logic);	-- global reset
end BlazeNoC;

architecture rtl of BlazeNoC is
	component BlazeRouter is
	 
	port ( north_data_in 		: in std_logic_vector (WIDTH downto 0);	-- Datalink from neighbor (to FCU)
	 		  north_din_good		: in std_logic;									-- Data good indicator from neighbor (to FCU)
			  north_CTR_in			: in std_logic;									-- CTR indicator from neighbor to arbiter indicating ready to recieve (to RNA) *** need implment in rna
			  north_data_out		: out std_logic_vector (WIDTH downto 0);	-- Datalink to neighbor (from SW)
			  north_dout_good		: out std_logic;									-- Data good indicator to neighbor (from SW)
			  north_CTR_out		: out std_logic;									-- CTR indicator from FCU to neighbor for accpeting data (from FCU)
			  
			  east_data_in 		: in std_logic_vector (WIDTH downto 0);
	 		  east_din_good		: in std_logic;
			  east_CTR_in			: in std_logic;
			  east_data_out		: out std_logic_vector (WIDTH downto 0);
			  east_dout_good		: out std_logic;
			  east_CTR_out			: out std_logic; 									
			  
			  south_data_in 		: in std_logic_vector (WIDTH downto 0);
	 		  south_din_good		: in std_logic;
			  south_CTR_in			: in std_logic;
			  south_data_out		: out std_logic_vector (WIDTH downto 0);
			  south_dout_good		: out std_logic;
			  south_CTR_out		: out std_logic;
			  
			  west_data_in 		: in std_logic_vector (WIDTH downto 0);
	 		  west_din_good		: in std_logic;
			  west_CTR_in			: in std_logic;
			  west_data_out		: out std_logic_vector (WIDTH downto 0);
			  west_dout_good		: out std_logic;
			  west_CTR_out		 	: out std_logic;
			  
			  -- arb needs to support ejection and injection fifos but no required for simulation if bypassed
			  injection_data		: in  std_logic_vector (WIDTH downto 0); -- Datalink from PE
			  injection_enq		: in  std_logic;								  -- Buffer enqueue from PE
			  injection_status	: out std_logic_vector (1 downto 0);	  -- Buffer status to PE
			  
			  ejection_data		: out std_logic_vector (WIDTH downto 0); -- Datalink to PE
			  ejection_deq			: in std_logic;								  -- Buffer dequeue from PE
			  ejection_status		: out std_logic_vector (1 downto 0);	  -- Buffer status to PE
			  
			  
			  clk						: in std_logic; 	-- global clock
			  reset					: in std_logic);	-- global reset
	end component;

	-- Signal Definitions
	
	-- Router 1
	signal router1_north_data_in		: std_logic_vector (WIDTH downto 0);
	signal router1_north_din_good		: std_logic;
	signal router1_north_CTR_in		: std_logic;
	signal router1_north_data_out		: std_logic_vector (WIDTH downto 0);
	signal router1_north_dout_good	: std_logic;
	signal router1_north_CTR_out		: std_logic;

	signal router1_east_data_in		: std_logic_vector (WIDTH downto 0);
	signal router1_east_din_good		: std_logic;
	signal router1_east_CTR_in			: std_logic;
	signal router1_east_data_out		: std_logic_vector (WIDTH downto 0);
	signal router1_east_dout_good		: std_logic;
	signal router1_east_CTR_out		: std_logic;
	
	signal router1_south_data_in		: std_logic_vector (WIDTH downto 0);
	signal router1_south_din_good		: std_logic;
	signal router1_south_CTR_in		: std_logic;
	signal router1_south_data_out		: std_logic_vector (WIDTH downto 0);
	signal router1_south_dout_good	: std_logic;
	signal router1_south_CTR_out		: std_logic;
	
	signal router1_west_data_in		: std_logic_vector (WIDTH downto 0);
	signal router1_west_din_good		: std_logic;
	signal router1_west_CTR_in			: std_logic;
	signal router1_west_data_out		: std_logic_vector (WIDTH downto 0);
	signal router1_west_dout_good		: std_logic;
	signal router1_west_CTR_out		: std_logic;
	
	signal router1_injection_data		: std_logic_vector (WIDTH downto 0);
	signal router1_injection_enq		: std_logic;
	signal router1_injection_status	: std_logic_vector (1 downto 0);
	
	signal router1_ejection_data		: std_logic_vector (WIDTH downto 0);
	signal router1_ejection_deq		: std_logic;
	signal router1_ejection_status	: std_logic_vector (1 downto 0);

	-- Router 2
	signal router2_north_data_in		: std_logic_vector (WIDTH downto 0);
	signal router2_north_din_good		: std_logic;
	signal router2_north_CTR_in		: std_logic;
	signal router2_north_data_out		: std_logic_vector (WIDTH downto 0);
	signal router2_north_dout_good	: std_logic;
	signal router2_north_CTR_out		: std_logic;

	signal router2_east_data_in		: std_logic_vector (WIDTH downto 0);
	signal router2_east_din_good		: std_logic;
	signal router2_east_CTR_in			: std_logic;
	signal router2_east_data_out		: std_logic_vector (WIDTH downto 0);
	signal router2_east_dout_good		: std_logic;
	signal router2_east_CTR_out		: std_logic;
	
	signal router2_south_data_in		: std_logic_vector (WIDTH downto 0);
	signal router2_south_din_good		: std_logic;
	signal router2_south_CTR_in		: std_logic;
	signal router2_south_data_out		: std_logic_vector (WIDTH downto 0);
	signal router2_south_dout_good	: std_logic;
	signal router2_south_CTR_out		: std_logic;
	
	signal router2_west_data_in		: std_logic_vector (WIDTH downto 0);
	signal router2_west_din_good		: std_logic;
	signal router2_west_CTR_in			: std_logic;
	signal router2_west_data_out		: std_logic_vector (WIDTH downto 0);
	signal router2_west_dout_good		: std_logic;
	signal router2_west_CTR_out		: std_logic;
	
	signal router2_injection_data		: std_logic_vector (WIDTH downto 0);
	signal router2_injection_enq		: std_logic;
	signal router2_injection_status	: std_logic_vector (1 downto 0);
	
	signal router2_ejection_data		: std_logic_vector (WIDTH downto 0);
	signal router2_ejection_deq		: std_logic;
	signal router2_ejection_status	: std_logic_vector (1 downto 0);
	
	-- Router 3
	signal router3_north_data_in		: std_logic_vector (WIDTH downto 0);
	signal router3_north_din_good		: std_logic;
	signal router3_north_CTR_in		: std_logic;
	signal router3_north_data_out		: std_logic_vector (WIDTH downto 0);
	signal router3_north_dout_good	: std_logic;
	signal router3_north_CTR_out		: std_logic;

	signal router3_east_data_in		: std_logic_vector (WIDTH downto 0);
	signal router3_east_din_good		: std_logic;
	signal router3_east_CTR_in			: std_logic;
	signal router3_east_data_out		: std_logic_vector (WIDTH downto 0);
	signal router3_east_dout_good		: std_logic;
	signal router3_east_CTR_out		: std_logic;
	
	signal router3_south_data_in		: std_logic_vector (WIDTH downto 0);
	signal router3_south_din_good		: std_logic;
	signal router3_south_CTR_in		: std_logic;
	signal router3_south_data_out		: std_logic_vector (WIDTH downto 0);
	signal router3_south_dout_good	: std_logic;
	signal router3_south_CTR_out		: std_logic;
	
	signal router3_west_data_in		: std_logic_vector (WIDTH downto 0);
	signal router3_west_din_good		: std_logic;
	signal router3_west_CTR_in			: std_logic;
	signal router3_west_data_out		: std_logic_vector (WIDTH downto 0);
	signal router3_west_dout_good		: std_logic;
	signal router3_west_CTR_out		: std_logic;
	
	signal router3_injection_data		: std_logic_vector (WIDTH downto 0);
	signal router3_injection_enq		: std_logic;
	signal router3_injection_status	: std_logic_vector (1 downto 0);
	
	signal router3_ejection_data		: std_logic_vector (WIDTH downto 0);
	signal router3_ejection_deq		: std_logic;
	signal router3_ejection_status	: std_logic_vector (1 downto 0);
	
	-- Router 4
	signal router4_north_data_in		: std_logic_vector (WIDTH downto 0);
	signal router4_north_din_good		: std_logic;
	signal router4_north_CTR_in		: std_logic;
	signal router4_north_data_out		: std_logic_vector (WIDTH downto 0);
	signal router4_north_dout_good	: std_logic;
	signal router4_north_CTR_out		: std_logic;

	signal router4_east_data_in		: std_logic_vector (WIDTH downto 0);
	signal router4_east_din_good		: std_logic;
	signal router4_east_CTR_in			: std_logic;
	signal router4_east_data_out		: std_logic_vector (WIDTH downto 0);
	signal router4_east_dout_good		: std_logic;
	signal router4_east_CTR_out		: std_logic;
	
	signal router4_south_data_in		: std_logic_vector (WIDTH downto 0);
	signal router4_south_din_good		: std_logic;
	signal router4_south_CTR_in		: std_logic;
	signal router4_south_data_out		: std_logic_vector (WIDTH downto 0);
	signal router4_south_dout_good	: std_logic;
	signal router4_south_CTR_out		: std_logic;
	
	signal router4_west_data_in		: std_logic_vector (WIDTH downto 0);
	signal router4_west_din_good		: std_logic;
	signal router4_west_CTR_in			: std_logic;
	signal router4_west_data_out		: std_logic_vector (WIDTH downto 0);
	signal router4_west_dout_good		: std_logic;
	signal router4_west_CTR_out		: std_logic;
	
	signal router4_injection_data		: std_logic_vector (WIDTH downto 0);
	signal router4_injection_enq		: std_logic;
	signal router4_injection_status	: std_logic_vector (1 downto 0);
	
	signal router4_ejection_data		: std_logic_vector (WIDTH downto 0);
	signal router4_ejection_deq		: std_logic;
	signal router4_ejection_status	: std_logic_vector (1 downto 0);
	
begin


end rtl;

