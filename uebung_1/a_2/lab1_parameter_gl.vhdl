library ieee;
use ieee.std_logic_1164.all;

entity eq_gen is
    GENERIC (
        n: integer := 2 
    ); --Anzahl der zu vergleichenden Bits

    port (
        a, b: in std_logic_vector(n-1 downto 0); -- zwei Eingaenge zum Vergleich
        q: out std_logic -- '1' wenn a = b sonst '0'
    );
end eq_gen;

architecture rtl of eq_gen is
    signal s_q: std_logic := '1'; 
begin
    process(a, b) 
    begin
        s_q <= '1'; 
        
        for i in 0 to n-1 loop
            if (a(i) /= b(i)) then
                s_q <= '0';
                exit;
            end if;
        end loop;
    end process;
    
    q <= s_q; 
end rtl;