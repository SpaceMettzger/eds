library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


ENTITY dds_lut IS
    GENERIC(
        addr_width : integer RANGE 4 TO 6 := 6;
        data_width : integer := 8
        );
    PORT (
        addrin : IN std_logic_vector(addr_width-1 DOWNTO 0);
        dataout : OUT std_logic_vector(data_width-1 DOWNTO 0)
        );
END dds_lut;

ARCHITECTURE arch OF dds_lut IS
    SIGNAL x : integer RANGE 0 TO 2**addrin'length-1;
    SIGNAL y : integer RANGE 0 TO 2**dataout'length-1;
    
    BEGIN
    x <= to_integer(unsigned(addrin));
    Option1: IF addr_width = 4 AND data_width = 8 GENERATE
    PROCESS(x)
    BEGIN
    y <= 0;
    CASE x IS
    WHEN 0 => y <= 0;
    WHEN 1 => y <= 25;
    WHEN 2 => y <= 50;
    -- ..................
    WHEN 15 => y <= 254;
    WHEN OTHERS => NULL;
    END CASE;
    END PROCESS;
    END GENERATE;
    dataout <= std_logic_vector(to_unsigned(y, dataout'length));
    END;