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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.router_library.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BlazeNoC is
	port ( clk_rte					: in std_logic; 	-- global clock for router
			 clk_pe					: in std_logic;	-- PE clocks
			 reset					: in std_logic;
			 
			 sm_triggerPE0			: in std_logic;
			 sm_triggerPE1			: in std_logic;
			 sm_triggerPE2			: in std_logic;
			 sm_triggerPE3			: in std_logic;
			 full_PE0				: out std_logic;
			 full_PE1				: out std_logic;
			 full_PE2				: out std_logic;
			 full_PE3				: out std_logic;
			 done_PE0				: out std_logic;
			 done_PE1				: out std_logic;
			 done_PE2				: out std_logic;
			 done_PE3				: out std_logic;
			 data_inject_PE0		: in std_logic_vector (WIDTH downto 0);
			 data_inject_PE1		: in std_logic_vector (WIDTH downto 0);
			 data_inject_PE2		: in std_logic_vector (WIDTH downto 0);
			 data_inject_PE3		: in std_logic_vector (WIDTH downto 0));
end BlazeNoC;

architecture rtl of BlazeNoC is
	component BlazeRouter is
	 
		port( north_data_in 		: in std_logic_vector (WIDTH downto 0);	-- Datalink from neighbor (to FCU)
				north_din_good		: in std_logic;									-- Data good indicator from neighbor (to FCU)
				north_CTR_in		: in std_logic;									-- CTR indicator from neighbor to arbiter indicating ready to recieve (to RNA) *** need implment in rna
				north_invld_in		: in std_logic;									-- Invalid data (from neighbor to fcu)
				north_data_out		: out std_logic_vector (WIDTH downto 0);	-- Datalink to neighbor (from SW)
				north_dout_good	: out std_logic;									-- Data good indicator to neighbor (from SW)
				north_CTR_out		: out std_logic;									-- CTR indicator from FCU to neighbor for accpeting data (from FCU)
				north_invld_out	: out std_logic;									-- Invalid data (from arbiter to neighbor fcu)
			  
				east_data_in 		: in std_logic_vector (WIDTH downto 0);
				east_din_good		: in std_logic;
				east_CTR_in			: in std_logic;
				east_invld_in		: in std_logic;
				east_data_out		: out std_logic_vector (WIDTH downto 0);
				east_dout_good		: out std_logic;
				east_CTR_out		: out std_logic;
				east_invld_out		: out std_logic;					-- Invalid data (from arbiter to neighbor fcu)
			  
				south_data_in 		: in std_logic_vector (WIDTH downto 0);
				south_din_good		: in std_logic;
				south_CTR_in		: in std_logic;
				south_invld_in		: in std_logic;
				south_data_out		: out std_logic_vector (WIDTH downto 0);
				south_dout_good	: out std_logic;
				south_CTR_out		: out std_logic;
				south_invld_out	: out std_logic;					-- Invalid data (from arbiter to neighbor fcu)
			  
				west_data_in 		: in std_logic_vector (WIDTH downto 0);
				west_din_good		: in std_logic;
				west_CTR_in			: in std_logic;
				west_invld_in		: in std_logic;
				west_data_out		: out std_logic_vector (WIDTH downto 0);
				west_dout_good		: out std_logic;
				west_CTR_out		: out std_logic;
				west_invld_out		: out std_logic;					-- Invalid data (from arbiter to neighbor fcu)
			  
				-- arb needs to support ejection and injection fifos but no required for simulation if bypassed
				injection_data		: in  std_logic_vector (WIDTH downto 0); -- Datalink from PE
				injection_enq		: in  std_logic;								  -- Buffer enqueue from PE
				injection_status	: out std_logic_vector (1 downto 0);	  -- Buffer status to PE
			  
				ejection_data		: out std_logic_vector (WIDTH downto 0); -- Datalink to PE
				ejection_deq		: in std_logic;								  -- Buffer dequeue from PE
				ejection_status	: out std_logic_vector (1 downto 0);	  -- Buffer status to PE
			  
				clk					: in std_logic; 	-- global clock
				reset					: in std_logic);	-- global reset
	end component;

	component PE is
		port(	clk 					: in  std_logic;
				reset 				: in  std_logic;
				trigger 				: in  std_logic;
				full					: out std_logic;
				done					: out std_logic;
				tb_data_out			: in 	std_logic_vector (WIDTH downto 0);
				injection_data 	: out std_logic_vector (WIDTH downto 0);
				injection_enq 		: out std_logic;
				injection_status 	: in  std_logic_vector (1 downto 0);	  	-- Buffer status to PE;
				ejection_data 		: in  std_logic_vector (WIDTH downto 0);
				ejection_deq 		: out std_logic;
				ejection_status 	: in  std_logic_vector (1 downto 0));		-- Buffer status to PE
	end component;
	
	-- Signal Definitions
		
	-- Router 0
	signal router0toX_north_to_south_data_in		: std_logic_vector (WIDTH downto 0);		--Not plugged 2/24/2012
	signal router0toX_north_to_south_din_good		: std_logic;
	signal router0toX_north_to_south_CTR_in		: std_logic;
	signal router0toX_north_to_south_invld_in		: std_logic;
	signal router0toX_north_to_south_data_out		: std_logic_vector (WIDTH downto 0);
	signal router0toX_north_to_south_dout_good	: std_logic;
	signal router0toX_north_to_south_CTR_out		: std_logic;
	signal router0toX_north_to_south_invld_out	: std_logic;

	signal router0to1_east_to_west_data_in			: std_logic_vector (WIDTH downto 0);		--Plugged into Router 1 West
	signal router0to1_east_to_west_din_good		: std_logic;
	signal router0to1_east_to_west_CTR_in			: std_logic;
	signal router0to1_east_to_west_invld_in		: std_logic;
	signal router0to1_east_to_west_data_out		: std_logic_vector (WIDTH downto 0);
	signal router0to1_east_to_west_dout_good		: std_logic;
	signal router0to1_east_to_west_CTR_out			: std_logic;
	signal router0to1_east_to_west_invld_out		: std_logic;
	
	signal router0to2_south_to_north_data_in		: std_logic_vector (WIDTH downto 0);		--Plugged into Router 2 North
	signal router0to2_south_to_north_din_good		: std_logic;
	signal router0to2_south_to_north_CTR_in		: std_logic;
	signal router0to2_south_to_north_invld_in		: std_logic;
	signal router0to2_south_to_north_data_out		: std_logic_vector (WIDTH downto 0);
	signal router0to2_south_to_north_dout_good	: std_logic;
	signal router0to2_south_to_north_CTR_out		: std_logic;
	signal router0to2_south_to_north_invld_out	: std_logic;
	
	signal router0toX_west_to_east_data_in			: std_logic_vector (WIDTH downto 0);		--Not plugged 2/24/2012
	signal router0toX_west_to_east_din_good		: std_logic;
	signal router0toX_west_to_east_CTR_in			: std_logic;
	signal router0toX_west_to_east_invld_in		: std_logic;
	signal router0toX_west_to_east_data_out		: std_logic_vector (WIDTH downto 0);
	signal router0toX_west_to_east_dout_good		: std_logic;
	signal router0toX_west_to_east_CTR_out			: std_logic;
	signal router0toX_west_to_east_invld_out		: std_logic;
	
	signal router0_injection_data		: std_logic_vector (WIDTH downto 0);						--Plugged into PE0
	signal router0_injection_enq		: std_logic;
	signal router0_injection_status	: std_logic_vector (1 downto 0);
	
	signal router0_ejection_data		: std_logic_vector (WIDTH downto 0);						--Plugged into PE0
	signal router0_ejection_deq		: std_logic;
	signal router0_ejection_status	: std_logic_vector (1 downto 0);

	-- Router 1
	signal router1toX_north_to_south_data_in		: std_logic_vector (WIDTH downto 0);		--Not plugged 2/24/2012
	signal router1toX_north_to_south_din_good		: std_logic;
	signal router1toX_north_to_south_CTR_in		: std_logic;
	signal router1toX_north_to_south_invld_in		: std_logic;
	signal router1toX_north_to_south_data_out		: std_logic_vector (WIDTH downto 0);
	signal router1toX_north_to_south_dout_good	: std_logic;
	signal router1toX_north_to_south_CTR_out		: std_logic;
	signal router1toX_north_to_south_invld_out	: std_logic;

	signal router1toX_east_to_west_data_in			: std_logic_vector (WIDTH downto 0);		--Not plugged 2/24/2012
	signal router1toX_east_to_west_din_good		: std_logic;
	signal router1toX_east_to_west_CTR_in			: std_logic;
	signal router1toX_east_to_west_invld_in		: std_logic;
	signal router1toX_east_to_west_data_out		: std_logic_vector (WIDTH downto 0);
	signal router1toX_east_to_west_dout_good		: std_logic;
	signal router1toX_east_to_west_CTR_out			: std_logic;
	signal router1toX_east_to_west_invld_out		: std_logic;
	
	signal router1to3_south_to_north_data_in		: std_logic_vector (WIDTH downto 0);		--Plugged into Router 3 North	
	signal router1to3_south_to_north_din_good		: std_logic;
	signal router1to3_south_to_north_CTR_in		: std_logic;
	signal router1to3_south_to_north_invld_in		: std_logic;
	signal router1to3_south_to_north_data_out		: std_logic_vector (WIDTH downto 0);
	signal router1to3_south_to_north_dout_good	: std_logic;
	signal router1to3_south_to_north_CTR_out		: std_logic;
	signal router1to3_south_to_north_invld_out	: std_logic;
	
--	signal router1toX_west_to_east_data_in			: std_logic_vector (WIDTH downto 0);		--Not used. Uncomment if
--	signal router1toX_west_to_east_din_good		: std_logic;										--Router1 west plugs into
--	signal router1toX_west_to_east_CTR_in			: std_logic;										--another router or another
--	signal router1toX_west_to_east_invld_in		: std_logic;										--port.
--	signal router1toX_west_to_east_data_out		: std_logic_vector (WIDTH downto 0);
--	signal router1toX_west_to_east_dout_good		: std_logic;
--	signal router1toX_west_to_east_CTR_out			: std_logic;
--	signal router1toX_west_to_east_invld_out		: std_logic;
	
	signal router1_injection_data		: std_logic_vector (WIDTH downto 0);						--Plugged into PE1
	signal router1_injection_enq		: std_logic;
	signal router1_injection_status	: std_logic_vector (1 downto 0);
	
	signal router1_ejection_data		: std_logic_vector (WIDTH downto 0);						--Plugged into PE1
	signal router1_ejection_deq		: std_logic;
	signal router1_ejection_status	: std_logic_vector (1 downto 0);
	
	-- Router 2
--	signal router2toX_north_to_south_data_in		: std_logic_vector (WIDTH downto 0);		--Not used. Uncomment if
--	signal router2toX_north_to_south_din_good		: std_logic;										--Router2 north plugs into
--	signal router2toX_north_to_south_CTR_in		: std_logic;										--another router or another
--	signal router2toX_north_to_south_invld_in		: std_logic;										--port.
--	signal router2toX_north_to_south_data_out		: std_logic_vector (WIDTH downto 0);
--	signal router2toX_north_to_south_dout_good	: std_logic;
--	signal router2toX_north_to_south_CTR_out		: std_logic;
--	signal router2toX_north_to_south_invld_out	: std_logic;

	signal router2to3_east_to_west_data_in			: std_logic_vector (WIDTH downto 0);		--Plugged into Router 3 West
	signal router2to3_east_to_west_din_good		: std_logic;
	signal router2to3_east_to_west_CTR_in			: std_logic;
	signal router2to3_east_to_west_invld_in		: std_logic;
	signal router2to3_east_to_west_data_out		: std_logic_vector (WIDTH downto 0);
	signal router2to3_east_to_west_dout_good		: std_logic;
	signal router2to3_east_to_west_CTR_out			: std_logic;
	signal router2to3_east_to_west_invld_out		: std_logic;
	
	signal router2toX_south_to_north_data_in		: std_logic_vector (WIDTH downto 0);		--Not plugged 2/24/2012
	signal router2toX_south_to_north_din_good		: std_logic;
	signal router2toX_south_to_north_CTR_in		: std_logic;
	signal router2toX_south_to_north_invld_in		: std_logic;
	signal router2toX_south_to_north_data_out		: std_logic_vector (WIDTH downto 0);
	signal router2toX_south_to_north_dout_good	: std_logic;
	signal router2toX_south_to_north_CTR_out		: std_logic;
	signal router2toX_south_to_north_invld_out	: std_logic;
	
	signal router2toX_west_to_east_data_in			: std_logic_vector (WIDTH downto 0);		--Not plugged 2/24/2012
	signal router2toX_west_to_east_din_good		: std_logic;
	signal router2toX_west_to_east_CTR_in			: std_logic;
	signal router2toX_west_to_east_invld_in		: std_logic;
	signal router2toX_west_to_east_data_out		: std_logic_vector (WIDTH downto 0);
	signal router2toX_west_to_east_dout_good		: std_logic;
	signal router2toX_west_to_east_CTR_out			: std_logic;
	signal router2toX_west_to_east_invld_out		: std_logic;
	
	signal router2_injection_data		: std_logic_vector (WIDTH downto 0);						--Plugged into PE2
	signal router2_injection_enq		: std_logic;
	signal router2_injection_status	: std_logic_vector (1 downto 0);
	
	signal router2_ejection_data		: std_logic_vector (WIDTH downto 0);						--Plugged into PE2
	signal router2_ejection_deq		: std_logic;
	signal router2_ejection_status	: std_logic_vector (1 downto 0);
	
	-- Router 3
--	signal router3toX_north_to_south_data_in		: std_logic_vector (WIDTH downto 0);		--Not used. Uncomment if
--	signal router3toX_north_to_south_din_good		: std_logic;										--Router 3 north plugs into
--	signal router3toX_north_to_south_CTR_in		: std_logic;										--another router or another
--	signal router3toX_north_to_south_invld_in		: std_logic;										--port
--	signal router3toX_north_to_south_data_out		: std_logic_vector (WIDTH downto 0);
--	signal router3toX_north_to_south_dout_good	: std_logic;
--	signal router3toX_north_to_south_CTR_out		: std_logic;
--	signal router3toX_north_to_south_invld_out	: std_logic;

	signal router3toX_east_to_west_data_in			: std_logic_vector (WIDTH downto 0);		--Not plugged 2/24/2012
	signal router3toX_east_to_west_din_good		: std_logic;
	signal router3toX_east_to_west_CTR_in			: std_logic;
	signal router3toX_east_to_west_invld_in		: std_logic;
	signal router3toX_east_to_west_data_out		: std_logic_vector (WIDTH downto 0);
	signal router3toX_east_to_west_dout_good		: std_logic;
	signal router3toX_east_to_west_CTR_out			: std_logic;
	signal router3toX_east_to_west_invld_out		: std_logic;
	
	signal router3toX_south_to_north_data_in		: std_logic_vector (WIDTH downto 0);		--Not plugged 2/24/2012
	signal router3toX_south_to_north_din_good		: std_logic;
	signal router3toX_south_to_north_CTR_in		: std_logic;
	signal router3toX_south_to_north_invld_in		: std_logic;
	signal router3toX_south_to_north_data_out		: std_logic_vector (WIDTH downto 0);
	signal router3toX_south_to_north_dout_good	: std_logic;
	signal router3toX_south_to_north_CTR_out		: std_logic;
	signal router3toX_south_to_north_invld_out	: std_logic;
	
--	signal router3toX_west_to_east_data_in			: std_logic_vector (WIDTH downto 0);		--Not used. Uncomment if
--	signal router3toX_west_to_east_din_good		: std_logic;										--Router 3 west plugs into
--	signal router3toX_west_to_east_CTR_in			: std_logic;										--another router
--	signal router3toX_west_to_east_invld_in		: std_logic;
--	signal router3toX_west_to_east_data_out		: std_logic_vector (WIDTH downto 0);
--	signal router3toX_west_to_east_dout_good		: std_logic;
--	signal router3toX_west_to_east_CTR_out			: std_logic;
--	signal router3toX_west_to_east_invld_out		: std_logic;
	
	signal router3_injection_data		: std_logic_vector (WIDTH downto 0);						--Plugged into PE3
	signal router3_injection_enq		: std_logic;
	signal router3_injection_status	: std_logic_vector (1 downto 0);
	
	signal router3_ejection_data		: std_logic_vector (WIDTH downto 0);						--Plugged into PE3
	signal router3_ejection_deq		: std_logic;
	signal router3_ejection_status	: std_logic_vector (1 downto 0);
	
	
begin

		Router0 : BlazeRouter
		port map(router0toX_north_to_south_data_in, 					--North Port
					router0toX_north_to_south_din_good,
					router0toX_north_to_south_CTR_in,
					router0toX_north_to_south_invld_in,
					router0toX_north_to_south_data_out,
					router0toX_north_to_south_dout_good,
					router0toX_north_to_south_CTR_out,
					router0toX_north_to_south_invld_out,
					
					router0to1_east_to_west_data_in,						--East Port [Connected to Router1 WEST PORT]
					router0to1_east_to_west_din_good,
					router0to1_east_to_west_CTR_in,	
					router0to1_east_to_west_invld_in,
					router0to1_east_to_west_data_out,
					router0to1_east_to_west_dout_good,
					router0to1_east_to_west_CTR_out,
					router0to1_east_to_west_invld_out,
					
					router0to2_south_to_north_data_in,					--South Port [Connected to Router 2 NORTH PORT]
					router0to2_south_to_north_din_good,
					router0to2_south_to_north_CTR_in,
					router0to2_south_to_north_invld_in,
					router0to2_south_to_north_data_out,
					router0to2_south_to_north_dout_good,
					router0to2_south_to_north_CTR_out,
					router0to2_south_to_north_invld_out,
					
					router0toX_west_to_east_data_in,						--West Port [Connected to Router1 EAST PORT]
					router0toX_west_to_east_din_good,
					router0toX_west_to_east_CTR_in,
					router0toX_west_to_east_invld_in,
					router0toX_west_to_east_data_out,
					router0toX_west_to_east_dout_good,	
					router0toX_west_to_east_CTR_out,
					router0toX_west_to_east_invld_out,
					
					router0_injection_data,								--Injection
					router0_injection_enq,
					router0_injection_status,
					
					router0_ejection_data,								--Ejection
					router0_ejection_deq,
					router0_ejection_status,
					clk_rte,
					reset);
					
		Router1 : BlazeRouter
		port map(router1toX_north_to_south_data_in, 					--North Port
					router1toX_north_to_south_din_good,
					router1toX_north_to_south_CTR_in,
					router1toX_north_to_south_invld_in,
					router1toX_north_to_south_data_out,
					router1toX_north_to_south_dout_good,
					router1toX_north_to_south_CTR_out,
					router1toX_north_to_south_invld_out,
					
					router1toX_east_to_west_data_in,						--East Port
					router1toX_east_to_west_din_good,
					router1toX_east_to_west_CTR_in,
					router1toX_east_to_west_invld_in,					
					router1toX_east_to_west_data_out,					
					router1toX_east_to_west_dout_good,
					router1toX_east_to_west_CTR_out,
					router1toX_east_to_west_invld_out,
					
					router1to3_south_to_north_data_in,					--South Port [Connected to Router 3 NORTH PORT]
					router1to3_south_to_north_din_good,
					router1to3_south_to_north_CTR_in,
					router1to3_south_to_north_invld_in,
					router1to3_south_to_north_data_out,
					router1to3_south_to_north_dout_good,
					router1to3_south_to_north_CTR_out,
					router1to3_south_to_north_invld_out,
					
					router0to1_east_to_west_data_out,					--West Port [Connected to Router0 EAST PORT]
					router0to1_east_to_west_dout_good,
					router0to1_east_to_west_CTR_out,
					router0to1_east_to_west_invld_out,
					router0to1_east_to_west_data_in,	
					router0to1_east_to_west_din_good,
					router0to1_east_to_west_CTR_in,
					router0to1_east_to_west_invld_in,
					
					router1_injection_data,									--Injection
					router1_injection_enq,
					router1_injection_status,
					
					router1_ejection_data,									--Ejection
					router1_ejection_deq,
					router1_ejection_status,
					clk_rte,
					reset);

		Router2 : BlazeRouter
		port map(router0to2_south_to_north_data_out,					--North Port [Connected to Router 0 SOUTH PORT]
					router0to2_south_to_north_dout_good,
					router0to2_south_to_north_CTR_out,
					router0to2_south_to_north_invld_out,
					router0to2_south_to_north_data_in,	
					router0to2_south_to_north_din_good,
					router0to2_south_to_north_CTR_in,
					router0to2_south_to_north_invld_in,
					
					router2to3_east_to_west_data_in,						--East Port [Connected to Router3 WEST PORT]
					router2to3_east_to_west_din_good,
					router2to3_east_to_west_CTR_in,	
					router2to3_east_to_west_invld_in,
					router2to3_east_to_west_data_out,
					router2to3_east_to_west_dout_good,
					router2to3_east_to_west_CTR_out,
					router2to3_east_to_west_invld_out,
					
					router2toX_south_to_north_data_in,					--South Port
					router2toX_south_to_north_din_good,
					router2toX_south_to_north_CTR_in,
					router2toX_south_to_north_invld_in,
					router2toX_south_to_north_data_out,
					router2toX_south_to_north_dout_good,
					router2toX_south_to_north_CTR_out,
					router2toX_south_to_north_invld_out,
					
					router2toX_west_to_east_data_in,						--West Port
					router2toX_west_to_east_din_good,
					router2toX_west_to_east_CTR_in,
					router2toX_west_to_east_invld_in,
					router2toX_west_to_east_data_out,
					router2toX_west_to_east_dout_good,	
					router2toX_west_to_east_CTR_out,
					router2toX_west_to_east_invld_out,
					
					router2_injection_data,									--Injection
					router2_injection_enq,
					router2_injection_status,
					
					router2_ejection_data,									--Ejection
					router2_ejection_deq,
					router2_ejection_status,
					clk_rte,
					reset);

		Router3 : BlazeRouter
		port map(router1to3_south_to_north_data_out,					--North Port [Connected to Router 1 SOUTH PORT]
					router1to3_south_to_north_dout_good,
					router1to3_south_to_north_CTR_out,
					router1to3_south_to_north_invld_out,
					router1to3_south_to_north_data_in,					
					router1to3_south_to_north_din_good,
					router1to3_south_to_north_CTR_in,
					router1to3_south_to_north_invld_in,
					
					router3toX_east_to_west_data_in,						--East Port
					router3toX_east_to_west_din_good,
					router3toX_east_to_west_CTR_in,	
					router3toX_east_to_west_invld_in,
					router3toX_east_to_west_data_out,
					router3toX_east_to_west_dout_good,
					router3toX_east_to_west_CTR_out,
					router3toX_east_to_west_invld_out,
					
					router3toX_south_to_north_data_in,					--South Port
					router3toX_south_to_north_din_good,
					router3toX_south_to_north_CTR_in,
					router3toX_south_to_north_invld_in,
					router3toX_south_to_north_data_out,
					router3toX_south_to_north_dout_good,
					router3toX_south_to_north_CTR_out,
					router3toX_south_to_north_invld_out,
					
					router2to3_east_to_west_data_out,					--West Port [Connected to Router 2 EAST PORT]
					router2to3_east_to_west_dout_good,
					router2to3_east_to_west_CTR_out,
					router2to3_east_to_west_invld_out,
					router2to3_east_to_west_data_in,						
					router2to3_east_to_west_din_good,
					router2to3_east_to_west_CTR_in,	
					router2to3_east_to_west_invld_in,
					
					router3_injection_data,								--Injection
					router3_injection_enq,
					router3_injection_status,
					
					router3_ejection_data,								--Ejection
					router3_ejection_deq,
					router3_ejection_status,
					clk_rte,
					reset);

		Processing_Element0: PE
		port map(clk_pe,
					reset,
					sm_triggerPE0,
					full_PE0,
					done_PE0,
					data_inject_PE0,
					router0_injection_data,
					router0_injection_enq,
					router0_injection_status,
					router0_ejection_data,
					router0_ejection_deq,
					router0_ejection_status);
		
		Processing_Element1: PE
		port map(clk_pe,
					reset,
					sm_triggerPE1,
					full_PE1,
					done_PE1,
					data_inject_PE1,
					router1_injection_data,
					router1_injection_enq,
					router1_injection_status,
					router1_ejection_data,
					router1_ejection_deq,
					router1_ejection_status);
					
		Processing_Element2: PE
		port map(clk_pe,
					reset,
					sm_triggerPE2,
					full_PE2,
					done_PE2,
					data_inject_PE2,
					router2_injection_data,
					router2_injection_enq,
					router2_injection_status,
					router2_ejection_data,
					router2_ejection_deq,
					router2_ejection_status);
					
		Processing_Element3: PE
		port map(clk_pe,
					reset,
					sm_triggerPE3,
					full_PE3,
					done_PE3,
					data_inject_PE3,
					router3_injection_data,
					router3_injection_enq,
					router3_injection_status,
					router3_ejection_data,
					router3_ejection_deq,
					router3_ejection_status);
					
					

end rtl;

