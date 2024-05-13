library ieee;
use ieee.std_logic_1164.all;

entity comparator is
    GENERIC (
        n: integer := 4
    ); --Anzahl der zu vergleichenden Bits

    port (
        a, b: in std_logic_vector(n-1 downto 0); -- zwei Eingaenge zum Vergleich
        q: out std_logic -- '1' wenn a = b sonst '0'
    );
end comparator;

architecture rtl of comparator is
signal s_q: std_logic := '1'; 
signal temp: std_logic;

begin
    process(a, b) 
    begin
        s_q <= '1'; 
        
        for i in 0 to n-1 loop
            temp <= a(i) xor b(i);
            if (temp = '1') then
                s_q <= '0';
                exit;
            end if;
        end loop;
    end process;
    
    q <= s_q; 
end rtl;