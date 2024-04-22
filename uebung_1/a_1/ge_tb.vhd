library ieee;
use ieee.std_logic_1164.all;

entity tb_ge is
end tb_ge;
 
architecture testing of tb_ge is 
    component gr_than
    port(
      a,b: in std_logic_vector(1 downto 0);
      q: out std_logic);
    end component;

signal s_a, s_b : std_logic_vector(1 downto 0);


begin
    dut: gr_than
	port map (a => s_a , b => s_b);
   
    process    
    begin 

    s_a(1) <= '0'; s_a(0) <= '0'; s_b(1) <= '0'; s_b(0) <= '0'; wait for 10ns;
    s_a(1) <= '0'; s_a(0) <= '0'; s_b(1) <= '0'; s_b(0) <= '1'; wait for 10ns;
    s_a(1) <= '0'; s_a(0) <= '0'; s_b(1) <= '1'; s_b(0) <= '0'; wait for 10ns;
    s_a(1) <= '0'; s_a(0) <= '0'; s_b(1) <= '1'; s_b(0) <= '1'; wait for 10ns;
    s_a(1) <= '0'; s_a(0) <= '1'; s_b(1) <= '0'; s_b(0) <= '0'; wait for 10ns;
    s_a(1) <= '0'; s_a(0) <= '1'; s_b(1) <= '0'; s_b(0) <= '1'; wait for 10ns;
    s_a(1) <= '0'; s_a(0) <= '1'; s_b(1) <= '1'; s_b(0) <= '0'; wait for 10ns;
    s_a(1) <= '0'; s_a(0) <= '1'; s_b(1) <= '1'; s_b(0) <= '1'; wait for 10ns;

    s_a(1) <= '1'; s_a(0) <= '0'; s_b(1) <= '0'; s_b(0) <= '0'; wait for 10ns;
    s_a(1) <= '1'; s_a(0) <= '0'; s_b(1) <= '0'; s_b(0) <= '1'; wait for 10ns;
    s_a(1) <= '1'; s_a(0) <= '0'; s_b(1) <= '1'; s_b(0) <= '0'; wait for 10ns;
    s_a(1) <= '1'; s_a(0) <= '0'; s_b(1) <= '1'; s_b(0) <= '1'; wait for 10ns;
    s_a(1) <= '1'; s_a(0) <= '1'; s_b(1) <= '0'; s_b(0) <= '0'; wait for 10ns;
    s_a(1) <= '1'; s_a(0) <= '1'; s_b(1) <= '0'; s_b(0) <= '1'; wait for 10ns;
    s_a(1) <= '1'; s_a(0) <= '1'; s_b(1) <= '1'; s_b(0) <= '0'; wait for 10ns;
    s_a(1) <= '1'; s_a(0) <= '1'; s_b(1) <= '1'; s_b(0) <= '1'; wait for 10ns;

    wait;
   end process;

end testing;