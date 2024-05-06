library ieee;
use ieee.std_logic_1164.all;

entity tb_ge is
end tb_ge;
 
architecture testing of tb_ge is 
    component gr_than
    port(
      a,b: in std_logic_vector(3 downto 0);
      q: out std_logic);
    end component;

signal s_a, s_b : std_logic_vector(3 downto 0);


begin
    dut: gr_than
	port map (a => s_a , b => s_b);
   
    PROCESS
    BEGIN
        s_b(3) <= '0'; WAIT FOR 10 ns;
        s_b(3) <= '1'; WAIT FOR 10 ns;
    END PROCESS;

    PROCESS
    BEGIN
    s_b(2) <= '0'; WAIT FOR 20 ns;
    s_b(2) <= '1'; WAIT FOR 20 ns;
    END PROCESS;

    PROCESS
    BEGIN
    s_b(1) <= '0'; WAIT FOR 40 ns;
    s_b(1) <= '1'; WAIT FOR 40 ns;
    END PROCESS;

    PROCESS
    BEGIN
    s_b(0) <= '0'; WAIT FOR 80 ns;
    s_b(0) <= '1'; WAIT FOR 80 ns;
    END PROCESS;

    
    PROCESS
    BEGIN
    s_a(3) <= '0'; WAIT FOR 160 ns;
    s_a(3) <= '1'; WAIT FOR 160 ns;
    END PROCESS;

    PROCESS
    BEGIN
    s_a(2) <= '0'; WAIT FOR 320 ns;
    s_a(2) <= '1'; WAIT FOR 320 ns;
    END PROCESS;

    PROCESS
    BEGIN
    s_a(1) <= '0'; WAIT FOR 640 ns;
    s_a(1) <= '1'; WAIT FOR 640 ns;
    END PROCESS;

    PROCESS
    BEGIN
    s_a(0) <= '0'; WAIT FOR 1280 ns;
    s_a(0) <= '1'; WAIT FOR 1280 ns;
    END PROCESS;


end testing;