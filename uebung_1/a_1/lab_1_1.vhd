LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity n_bit_comparator is  
    GENERIC (n : integer := 8);
    port map (
        a : IN std_logic_vector(n-1 DOWNTO 0);
        b : IN std_logic_vector(n-1 DOWNTO 0);
        y : OUT std_logic);
END ENTITY;

ARCHITECTURE arch OF n_bit_comparator IS

SIGNAL comp_sig: std_logic_vector (n-1 DOWNTO 0);


BEGIN

FOR i IN 0 TO n-1 GENERATE
        component comparator ()
END GENERATE


END arch;