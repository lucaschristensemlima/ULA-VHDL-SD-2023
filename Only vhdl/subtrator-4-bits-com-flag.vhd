----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10/25/2023 
-- Design Name: 
-- Module Name:    subtrator4bits - Behavioral 
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

entity subtrator4bits is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           y : in  STD_LOGIC_VECTOR (3 downto 0);
           bin : in  STD_LOGIC;
           bout : out  STD_LOGIC;
	   saida : out  STD_LOGIC_VECTOR (3 downto 0);
	   Flag_Zero : out STD_LOGIC;
	   Flag_Overflow : out STD_LOGIC;
	   Flag_Sinal : out STD_LOGIC;
	   Flag_Borrow : out STD_LOGIC
			  );
end subtrator4bits;

architecture Behavioral of subtrator4bits is

COMPONENT somador4bits
    PORT(
         cin : IN  std_logic;
         x : in  STD_LOGIC_VECTOR (3 downto 0);
         y : in  STD_LOGIC_VECTOR (3 downto 0);
         cout : out  std_logic;
         saida : out  STD_LOGIC_VECTOR (3 downto 0);
	 Flag_Zero : out STD_LOGIC;
	 Flag_Overflow : out STD_LOGIC;
	 Flag_Sinal : out STD_LOGIC
        );
		  
end COMPONENT somador4bits;

COMPONENT Complementa
    PORT(
        x : in  STD_LOGIC_VECTOR (3 downto 0);
	saida : out  STD_LOGIC_VECTOR (3 downto 0);
	Flag_Zero : out STD_LOGIC;
	Flag_Sinal : out STD_LOGIC
        );
		  
end COMPONENT Complementa;

SIGNAL yinvertido: STD_LOGIC_VECTOR (3 downto 0);
SIGNAL resultado: std_logic_vector (3 downto 0);
SIGNAL Flag_Zero_somador: std_logic;
SIGNAL Flag_Sinal_somador: std_logic;
SIGNAL Flag_Overflow_somador: std_logic;
SIGNAL armazena_borrow : std_logic;
SIGNAL borrow : std_logic;

begin

	a0:Complementa port map(y, yinvertido);
	a1:somador4bits port map (bin, x, yinvertido, borrow, resultado, Flag_Zero_somador, Flag_Overflow_somador,  Flag_Sinal_somador);
	saida <= resultado;
	Flag_Zero <= not(resultado(0) or resultado(1) or resultado(2) or resultado(3));
	Flag_Overflow <= Flag_Overflow_somador;
	armazena_borrow <= not borrow;
	bout<= armazena_borrow;
	Flag_Sinal <= resultado(3);
	Flag_Borrow <= armazena_borrow;
end Behavioral;
