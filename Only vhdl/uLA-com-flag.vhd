----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10/25/2023 
-- Design Name: 
-- Module Name:    ULA - Behavioral 
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

entity ULA is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           Operacao : in  STD_LOGIC_VECTOR (3 downto 0);
           Z : out  STD_LOGIC_VECTOR (3 downto 0);
	   Flag_Zero : out STD_LOGIC;
	   Flag_Sinal : out STD_LOGIC;
	   Flag_Overflow : out STD_LOGIC;
	   Flag_Cout : out STD_LOGIC
	   );
end ULA;

architecture Behavioral of ULA is

COMPONENT somador4bits
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           y : in  STD_LOGIC_VECTOR (3 downto 0);
           cin : in  STD_LOGIC;
           cout : out  STD_LOGIC;
           saida : out  STD_LOGIC_VECTOR (3 downto 0);
	   Flag_Zero : out STD_LOGIC;
	   Flag_Sinal : out STD_LOGIC;
	   Flag_Overflow : out STD_LOGIC;
		Flag_Cout : out STD_LOGIC
	   );
end COMPONENT somador4bits;
    
COMPONENT Complementa is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           saida : out  STD_LOGIC_VECTOR (3 downto 0);
	   Flag_Zero : out STD_LOGIC;
	   Flag_Sinal : out STD_LOGIC
	 );
end COMPONENT Complementa;
    
COMPONENT Inversor is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           saida : out  STD_LOGIC_VECTOR (3 downto 0);
	   Flag_Zero : out STD_LOGIC;
	   Flag_Sinal : out STD_LOGIC);
end COMPONENT Inversor;
    
COMPONENT subtrator4bits is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           y : in  STD_LOGIC_VECTOR (3 downto 0);
           bin : in  STD_LOGIC;
           bout : out  STD_LOGIC;
			  saida : out  STD_LOGIC_VECTOR (3 downto 0);
			  Flag_Zero : out STD_LOGIC;
			  Flag_Sinal : out STD_LOGIC;
			  Flag_Overflow : out STD_LOGIC;
			  Flag_Borrow : out STD_LOGIC);
end COMPONENT subtrator4bits;

COMPONENT Modulo_Xor is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           y : in  STD_LOGIC_VECTOR (3 downto 0);
           saida : out  STD_LOGIC_VECTOR (3 downto 0);
	   Flag_Zero : out STD_LOGIC;
	   Flag_Sinal : out STD_LOGIC);
end COMPONENT Modulo_Xor;    

COMPONENT Modulo_Or is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           y : in  STD_LOGIC_VECTOR (3 downto 0);
           saida : out  STD_LOGIC_VECTOR (3 downto 0);
	   Flag_Zero : out STD_LOGIC;
	   Flag_Sinal : out STD_LOGIC);
end COMPONENT Modulo_Or;
	
COMPONENT Modulo_And is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           y : in  STD_LOGIC_VECTOR (3 downto 0);
           saida : out  STD_LOGIC_VECTOR (3 downto 0);
	   Flag_Zero : out STD_LOGIC;
	   Flag_Sinal : out STD_LOGIC);
end COMPONENT Modulo_And;

COMPONENT incrementa1 is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           saida : out  STD_LOGIC_VECTOR (3 downto 0);
	   Flag_Zero : out STD_LOGIC;
	   Flag_Sinal : out STD_LOGIC);
end COMPONENT incrementa1;

signal Not_A, Compl_A, A_mais_B, A_mais_1, A_menos_B, A_and_B, A_xor_B, A_or_B : STD_LOGIC_VECTOR (3 downto 0);
signal cout_somador, bout_subtrator : STD_LOGIC;
signal Flag_Zero_somador, Flag_Sinal_somador, Flag_Overflow_somador, Flag_Cout_somador, Flag_Zero_complementador, Flag_Sinal_complementador : STD_LOGIC;
signal Flag_Zero_inversor, Flag_Sinal_inversor, Flag_Zero_subtrator, Flag_Sinal_subtrator, Flag_Overflow_subtrator, Flag_Borrow_subtrator : STD_LOGIC;
signal Flag_Zero_xor, Flag_Sinal_xor, Flag_Zero_or, Flag_Sinal_or, Flag_Zero_and, Flag_Sinal_and, Flag_Zero_incrementa, Flag_Sinal_incrementa : STD_LOGIC;

begin

	-- Declarando os componentes
	U0: Inversor port map (A, Not_A, Flag_Zero_inversor, Flag_Sinal_inversor); -- Para operação 0
	U1: Complementa port map (A, Compl_A, Flag_Zero_complementador, Flag_Sinal_complementador); -- Para operação 1
	U2: somador4bits port map (A, B, '0', cout_somador, A_mais_B, Flag_Zero_somador, Flag_Sinal_somador, Flag_Overflow_somador, Flag_Cout_somador); -- Para operação 2
	U3: incrementa1 port map (A, A_mais_1, Flag_Zero_incrementa, Flag_Sinal_incrementa); -- Para operação 3
	U4: subtrator4bits port map (A, B, '0', bout_subtrator, A_menos_B, Flag_Zero_subtrator, Flag_Sinal_subtrator, Flag_Overflow_subtrator, Flag_Borrow_subtrator); -- Para operação 4
	U5: Modulo_And port map (A, B, A_and_B, Flag_Zero_and, Flag_Sinal_and); -- Para operação 5
	U6: Modulo_Xor port map (A, B, A_xor_B, Flag_Zero_xor, Flag_Sinal_xor); -- Para operação 6
	U7: Modulo_Or port map (A, B, A_or_B, Flag_Zero_or, Flag_Sinal_or); -- Para operação 7
	
	process (Operacao, Not_A, Compl_A, A_mais_B, A_mais_1, A_menos_B, A_and_B, A_xor_B, A_or_B)
	begin
		case Operacao is
			when "0000" =>
				Z <= A_and_B;
				Flag_Zero <= Flag_Zero_and;
	   			Flag_Sinal <= Flag_Sinal_and;
	   			Flag_Overflow <= '0';
	   			Flag_Cout <= '0';
			when "1000" =>
				Z <= A_and_B;
				Flag_Zero <= Flag_Zero_and;
	   			Flag_Sinal <= Flag_Sinal_and;
	   			Flag_Overflow <= '0';
	   			Flag_Cout <= '0';
			when "0001" =>
				Z <= A_xor_B;
				Flag_Zero <= Flag_Zero_xor;
	   			Flag_Sinal <= Flag_Sinal_xor;
	   			Flag_Overflow <= '0';
	   			Flag_Cout <= '0';
			when "1001" =>
				Z <= A_xor_B;
				Flag_Zero <= Flag_Zero_xor;
	   			Flag_Sinal <= Flag_Sinal_xor;
	   			Flag_Overflow <= '0';
	   			Flag_Cout <= '0';
			when "0010" =>
				Z <= A_mais_1;
				Flag_Zero <= Flag_Zero_incrementa;
	   			Flag_Sinal <= Flag_Sinal_incrementa;
	   			Flag_Overflow <= '0';
	   			Flag_Cout <= '0';
			when "1010" =>
				Z <= A_mais_1;
				Flag_Zero <= Flag_Zero_incrementa;
	   			Flag_Sinal <= Flag_Sinal_incrementa;
	   			Flag_Overflow <= '0';
	   			Flag_Cout <= '0';
			when "0011" =>
				Z <= A_menos_B;
				Flag_Zero <= Flag_Zero_subtrator;
	   			Flag_Sinal <= Flag_Sinal_subtrator;
	   			Flag_Overflow <= Flag_Overflow_subtrator;
	   			Flag_Cout <= Flag_Borrow_subtrator;
			when "1011" =>
				Z <= A_menos_B;
				Flag_Zero <= Flag_Zero_subtrator;
	   			Flag_Sinal <= Flag_Sinal_subtrator;
	   			Flag_Overflow <= Flag_Overflow_subtrator;
	   			Flag_Cout <= Flag_Borrow_subtrator;
			when "0100" =>
				Z <= A_or_B;
				Flag_Zero <= Flag_Zero_or;
	   			Flag_Sinal <= Flag_Sinal_or;
	   			Flag_Overflow <= '0';
	   			Flag_Cout <= '0';
			when "1100" =>
				Z <= A_or_B;
				Flag_Zero <= Flag_Zero_or;
	   			Flag_Sinal <= Flag_Sinal_or;
	   			Flag_Overflow <= '0';
	   			Flag_Cout <= '0';
			when "0101" =>
				Z <= A_mais_B;
				Flag_Zero <= Flag_Zero_somador;
	   			Flag_Sinal <= Flag_Sinal_somador;
	   			Flag_Overflow <= Flag_Overflow_somador;
	   			Flag_Cout <= Flag_Cout_somador;
			when "1101" =>
				Z <= A_mais_B;
				Flag_Zero <= Flag_Zero_somador;
	   			Flag_Sinal <= Flag_Sinal_somador;
	   			Flag_Overflow <= Flag_Overflow_somador;
	   			Flag_Cout <= Flag_Cout_somador;
			when "0110" =>
				Z <= Compl_A;
				Flag_Zero <= Flag_Zero_or;
	   			Flag_Sinal <= Flag_Sinal_or;
	   			Flag_Overflow <= '0';
	   			Flag_Cout <= '0';
			when "1110" =>
				Z <= Compl_A;
				Flag_Zero <= Flag_Zero_complementador;
	   			Flag_Sinal <= Flag_Sinal_complementador;
	   			Flag_Overflow <= '0';
	   			Flag_Cout <= '0';
			when "0111" =>
				Z <= Not_A;
				Flag_Zero <= Flag_Zero_inversor;
	   			Flag_Sinal <= Flag_Sinal_inversor;
	   			Flag_Overflow <= '0';
	   			Flag_Cout <= '0';
			when "1111" =>
				Z <= Not_A;
				Flag_Zero <= Flag_Zero_inversor;
	   			Flag_Sinal <= Flag_Sinal_inversor;
	   			Flag_Overflow <= '0';
	   			Flag_Cout <= '0';
			when others =>
				z <= Not_A;
				Flag_Zero <= Flag_Zero_inversor;
	   			Flag_Sinal <= Flag_Sinal_inversor;
	   			Flag_Overflow <= '0';
	   			Flag_Cout <= '0';
			
		end case;
	end process;

end Behavioral;

