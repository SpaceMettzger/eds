library ieee;
use ieee.std_logic_1164.all;

entity gr_than is
    GENERIC (
        n: integer := 4 
    );

    port (
        a, b: in std_logic_vector(n-1 downto 0); -- zwei Eingaenge zum Vergleich
        q: out std_logic -- '1' wenn a > b sonst '0'
    );
end gr_than;

architecture rtl of gr_than is
signal s_q: std_logic;

begin

    process(a, b)
    begin
        s_q <= '0';
        for i in n-1 downto 0 loop
            if a(i)  = '1' and b(i) = '0' then
                s_q <= '1';
                exit;
            elsif
                b(i)  = '1' and a(i) = '0' then
                    s_q <= '0';
                exit;
            end if;
        end loop;
    end process;
    q <= s_q;
end rtl;
