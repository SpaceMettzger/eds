library ieee;
use ieee.std_logic_1164.all;

entity gr_than is
    generic (
        n: integer := 4 -- n = Anzahl der zu vergleichenden Bits
    );

port (
    a, b: in std_logic_vector(n-1 downto 0); -- zwei Eingaenge zum Vergleich
    q: out std_logic -- '1' wenn a > b sonst '0'
    );
end gr_than;

architecture rtl of gr_than is
signal q_sig: std_logic;

begin

    process(a, b) 
    begin
        q_sig <= '0';
        for i in n-1 downto 0 loop
            if a(i)  = '1' and b(i) = '0' then
                q_sig <= '1'; 
                exit;
            elsif
                b(i)  = '1' and a(i) = '0' then  
				q_sig <= '0'; 
                exit;
            end if;
        end loop;
    end process;
    q <= q_sig;
end rtl;
