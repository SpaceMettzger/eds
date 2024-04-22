library ieee;
use ieee.std_logic_1164.all;

entity gr_than is
port (a,b: in std_logic_vector(1 downto 0); -- zwei Eingaenge zum Vergleich
	  q: out std_logic -- '1' wenn a > b sonst '0'
 	  );
end gr_than;

architecture rtl of gr_than is
signal s_verifyB1: std_logic; 
signal s_verifyB2: std_logic; 

begin
s_verifyB1 <= '1' when ((a(1) and not b(1)) = '1') else '0';
s_verifyB2 <= '1' when ((a(0) and not b(0)) = '1') else '0';
q <= s_verifyB1 or (not b(1) and s_verifyB2);
	
end rtl;
