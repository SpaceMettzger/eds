LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY debounce IS
    GENERIC (   freq : INTEGER := 50_000_000; -- Taktfrequenz in Hz
                stable : INTEGER := 10); -- stabile Zeitspanne in ms
    PORT (  clk, reset : IN std_logic;
            x : IN std_logic;
            y : OUT std_logic);
END ENTITY;

ARCHITECTURE behavioral OF debounce IS
    SIGNAL cnt : integer RANGE 0 TO freq*stable/1000;
    SIGNAL shreg : std_logic_vector (3 DOWNTO 0);
    SIGNAL status : std_logic;
    
    BEGIN
    
    PROCESS (clk, reset)
    BEGIN
    IF (reset = ’1’) THEN
        y <= ’0’;
        shreg(3 DOWNTO 0) <= "0000";
    ELSIF(clk’event AND clk = ’1’) THEN
        shreg <= shreg (2 DOWNTO 0) & x; -- Schieberegister fuellen
        IF(status = ’1’) THEN -- Zaehler starten wenn stabil
            cnt <= 0;
        ELSIF(cnt < freq*stable/1000 - 4) THEN -- 4 Takte bereits durch Shift
            cnt <= cnt + 1;
        ELSE
            y <= shreg(3);
        END IF;
    END IF;
    END PROCESS;

    status <= shreg(0) XOR shreg(1) XOR shreg(2) XOR shreg(3); -- stabil?
END behavioral;