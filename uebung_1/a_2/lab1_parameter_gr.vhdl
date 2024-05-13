 library ieee;
use ieee.std_logic_1164.all;

entity gr_than_gen is
    generic (
        n: integer := 2 -- n = Anzahl der zu vergleichenden Bits
    );

port (
    a, b: in std_logic_vector(n-1 downto 0); -- zwei Eingaenge zum Vergleich
    q: out std_logic -- '1' wenn a > b sonst '0'
    );
end gr_than_gen;

architecture rtl of gr_than_gen is
    signal previous_sig: std_logic;
	signal q_sig: std_logic;
begin
	q_sig <= '0';
	previous_sig <= '1';

    process(a, b) 
    begin
        for i in 0 to n-1 loop
            if (previous_sig  = '1' and ((a(n-i-1) = '1') and (b(n-i-1) = '0'))) then
                q <= '1'; 
                exit;
            else
                previous_sig <= previous_sig and (a(n-i-1) xnor b(n-i-1));
            end if;
        end loop;
		q <= q_sig;
    end process;
end rtl;
