----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:37:49 01/08/2012 
-- Design Name: 
-- Module Name:    PE - Behavioral 
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

entity PE is
    Port ( clk 					: in  std_logic;
           reset 					: in  std_logic;
			  trigger 				: in  std_logic;
           injection_data 		: out  std_logic_vector (WIDTH downto 0);
           injection_enq 		: out  std_logic;
           injection_status 	: in  std_logic;
			  ejection_data 		: in  std_logic_vector (WIDTH downto 0);
			  ejection_deq 		: out  std_logic;
           ejection_status 	: in  std_logic);
end PE;

architecture rtl of PE is

begin


end rtl;

