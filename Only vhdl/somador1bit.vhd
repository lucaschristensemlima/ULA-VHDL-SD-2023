----------------------------------------------------------------------------------
-- Company:  
-- Engineer: 
-- 
-- Create Date:    10/25/2023 
-- Design Name: 
-- Module Name:    somador1bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 1
-- Description: somador de hum(1) bit 
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

entity somador1bit is
    Port ( cin : in  STD_LOGIC;
           x : in  STD_LOGIC;
           y : in  STD_LOGIC;
           cout : out  STD_LOGIC;
           saida : out  STD_LOGIC);
end somador1bit;

architecture Behavioral of somador1bit is
SIGNAL sinal1, sinal2, sinal3, sinal4, sinal5resultado : STD_LOGIC;

begin
	sinal1 <= x and y;
	sinal2 <= x and cin;
	sinal3 <= y and cin;
	sinal4 <= sinal1 or sinal2;
	cout <= sinal3 or sinal4; 
	sinal5resultado <= x XOR y;
	saida <= sinal5resultado xor cin;
end Behavioral;

