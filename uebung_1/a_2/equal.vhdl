library ieee;
use ieee.std_logic_1164.all;

entity equal is
    GENERIC (
        n: integer := 4
    ); 

    port (
        a, b: in std_logic_vector(n-1 downto 0); -- zwei Eingaenge zum Vergleich
        q: out std_logic -- '1' wenn a = b sonst '0'
    );
end equal;

architecture rtl of equal is

begin
    process(a, b) 
	 variable s_q: std_logic; 
	 variable temp: std_logic;
    begin
        s_q := '1'; 
        
        for i in 0 to n-1 loop
            temp := ( a(i) xnor b(i));
            if (temp = '0') then
                s_q := '0';
            end if;
        end loop;
		  
    q <= s_q; 
    end process;
    
end rtl;