library ieee;
use ieee.std_logic_1164.all;

entity eq is
port (a,b: in std_logic_vector(3 downto 0); 
	  q: out std_logic
 	  );
end eq;

architecture rtl of eq is
signal s_verifyB1: std_logic; 
signal s_verifyB2: std_logic; 
signal s_verifyB3: std_logic; 
signal s_verifyB4: std_logic; 

begin
s_verifyB4 <= a(3) xnor b(3);
s_verifyB3 <= a(2) xnor b(2);
s_verifyB2 <= a(1) xnor b(1);
s_verifyB1 <= a(0) xnor b(0);
q <= s_verifyB1 AND s_verifyB2 AND s_verifyB3 AND s_verifyB4;
end rtl;
