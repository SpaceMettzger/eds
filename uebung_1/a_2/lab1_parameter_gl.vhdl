library ieee;
use ieee.std_logic_1164.all;

entity comparator is
GENERIC(n: integer := 2 ); --Anzahl der zu vergleichenden Bits

port (a,b: in std_logic_vector(n-1 downto 0); -- zwei Eingaenge zum Vergleich
	  q: out std_logic -- '1' wenn a = b sonst '0'
	  );
end comparator;

architecture rtl of comparator is
	q <= 1;
	for i in 0 to n-1 loop 
		case when a(i) xor b(i) then q <= 0; exit;
		end loop; 

end rtl;
