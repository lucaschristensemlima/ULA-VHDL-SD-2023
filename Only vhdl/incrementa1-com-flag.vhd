----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10/25/2023
-- Design Name: 
-- Module Name:    incrementa1 - Behavioral 
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

entity incrementa1 is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           saida : out  STD_LOGIC_VECTOR (3 downto 0);
           Flag_Zero : out STD_LOGIC;
           Flag_Sinal : out STD_LOGIC);
end incrementa1;

architecture Behavioral of incrementa1 is

COMPONENT somador4bits
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           y : in  STD_LOGIC_VECTOR (3 downto 0);
           cin : in  STD_LOGIC;
           cout : out  STD_LOGIC;
           saida : out  STD_LOGIC_VECTOR (3 downto 0);
           Flag_Zero : out STD_LOGIC;
           Flag_Sinal : out STD_LOGIC;
           Flag_Overflow : out STD_LOGIC);
end COMPONENT somador4bits;

SIGNAL resultado: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL um: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL complementado: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL cout: std_logic;
SIGNAL Flag_Zero_somador : std_logic;
SIGNAL Flag_Sinal_somador : std_logic;
SIGNAL Flag_Overflow_somador : std_logic;

begin

um(0) <= '1';
um(1) <= '0';
um(2) <= '0';
um(3) <= '0';
label2: somador4bits port map (x, um, '0', cout, complementado);
saida <= complementado;
Flag_Zero <= not (complementado(0) or complementado(1) or complementado(2) or complementado(3));
Flag_Sinal <= complementado(3);


end Behavioral;
