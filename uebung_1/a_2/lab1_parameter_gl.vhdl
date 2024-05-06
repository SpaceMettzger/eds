library ieee;
use ieee.std_logic_1164.all;

entity comparator is
GENERIC(n: -- n = Anzahl der zu vergleichenden Bits
port (a,b: in std_logic_vector(n-1 downto 0); -- zwei Eingaenge zum Vergleich
	  q: out std_logic -- '1' wenn a = b sonst '0'
	  );
end comparator;

architecture rtl of comparator is
	
	-- hier bitte ergaenzen


end rtl;
