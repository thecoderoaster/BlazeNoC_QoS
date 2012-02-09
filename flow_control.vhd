----------------------------------------------------------------------------------
-- Company:			 University of Nevada, Las Vegas 
-- Engineer: 		 Krikor Hovasapian (ECE Graduate Student)
-- 					 Kareem Matariyeh (ECE Graduate Student)
-- Create Date:    18:47:06 03/15/2011 
-- Design Name: 	 BlazeRouter
-- Module Name:    flow_control - fc_4 
-- Project Name: 	 BlazeRouter
-- Description: 	 individual flow control for one direction in
--
-- Dependencies: 
--						 None
-- Revision: 
-- 					 Revision 0.01 - File Created
--						 Revision 0.02 - Created entity outline (KM)
--                 Revision 0.03 - Created implmentation code (KM)
--						 Revision 0.04	- Changed implmentation (KM)
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.router_library.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity flow_control is
	Port (  fc_CTRflg			: in		STD_LOGIC;									-- Clear To Recieve flag (from RNA)
			  fc_dataIn 		: in  	STD_LOGIC_VECTOR (WIDTH downto 0); 	-- Input data port (from neighbor)
           fc_dStrb 			: in  	STD_LOGIC;									-- Data strobe (from neighbor)
           fc_vcFull 		: in  	STD_LOGIC;									-- Full status flag (from VC)
			  fc_arbEnq			: in 		STD_LOGIC; 									-- Direct Enq control (from arbiter)
			  fc_vcData 		: out  	STD_LOGIC_VECTOR (WIDTH downto 0);	-- Data port (to VC)
           fc_rnaCtrl	 	: out  	STD_LOGIC_VECTOR (WIDTH downto 0);	-- Data port (to RNA)
           fc_rnaCtrlStrb 	: out  	STD_LOGIC;									-- Control packet strobe (to RNA)
			  fc_rnaDataStrb	: out		STD_LOGIC;									-- Data packet strobe (to RNA)
			  fc_CTR				: out		STD_LOGIC;									-- Clear to Recieve (to neighbor)
           fc_vcEnq 			: out  	STD_LOGIC);									-- enqueue command from RNA (to VC)
end flow_control;

architecture fc_4 of flow_control is

	signal dStrbInd	: STD_LOGIC;
	signal CTRInd	: STD_LOGIC;
	signal DATInd 	: STD_LOGIC;

	-- Control packet sense (for now it is assumed if LSB is high in a packet then it is of the control variety)
	-- Its assumed that the control packet will get consumed and a new one will be created
	alias  senseOp 	:STD_LOGIC is fc_dataIn(0);
	
begin

-- This is setup is pretty much a large forwarder with dmux for control packet forwarding to RNA.	

-- Data Bus
fc_vcData <= fc_dataIn;
fc_rnaCtrl <= fc_dataIn;

-- Dmux for control packet sense
fc_rnaCtrlStrb <= fc_dStrb when (senseOp = '1') else '0';
--fc_rnaCtrlStrb <= '1' when (senseOp = '1' and (CTRInd = '0' and fc_dStrb = '1')) else '0';
dStrbInd <= fc_dStrb when (senseOp = '0') else '0';

-- Data indicator for RNA 
-- When a non control packet is wanting to enter and ctr is low we indicate it exists
fc_rnaDataStrb <= '1' when (senseOp = '0' and (CTRInd = '0' and fc_dStrb = '1')) else '0';

-- Clear to recieve handler
CTRInd <= fc_CTRflg; --(not fc_vcFull) and fc_CTRflg;
fc_CTR <= fc_CTRflg; -- direct communication between recv rna and sending rna

-- VC Data strobe handler
-- arbiter will have direct control to enqueue actions, but the data must be good and 
-- the system must be clear to recv
fc_vcEnq <= CTRInd and dStrbInd and fc_arbEnq;
--fc_vcEnq <= fc_arbEnq;

end fc_4;

