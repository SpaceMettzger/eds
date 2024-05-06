library ieee;
use ieee.std_logic_1164.all;

entity gr_than is
port (a,b: in std_logic_vector(3 downto 0); -- zwei Eingaenge zum Vergleich
	  q: out std_logic -- '1' wenn a > b sonst '0'
 	  );
end gr_than;

architecture rtl of gr_than is
    signal s_verifyB3: std_logic; 
    signal s_verifyB2: std_logic; 
    signal s_verifyB1: std_logic; 
    signal s_verifyB0: std_logic; 

begin

s_verifyB3 <= a(3) and not b(3); -- MSB von a ist größer als MSB von b
s_verifyB2 <= (a(3) xnor b(3)) and a(2) and not b(2);
s_verifyB1 <= (a(3) xnor b(3)) and (a(2) xnor b(2)) and a(1) and not b(1); 
s_verifyB0 <= (a(3) xnor b(3)) and (a(2) xnor b(2)) and (a(1) xnor b(1)) and a(0) and not b(0); 

q <= s_verifyB3 or s_verifyB2 or s_verifyB1 or s_verifyB0;
	
end rtl;
