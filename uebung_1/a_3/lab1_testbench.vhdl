library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_comparator is
end tb_comparator;

architecture testing of tb_comparator is
  constant k : integer := 4;

  component comparator is
    generic (
        n: integer := k
    ); -- Anzahl der zu vergleichenden Bits

    port (
        a, b: in std_logic_vector(n-1 downto 0); -- zwei Eingaenge zum Vergleich
        q: out std_logic -- '1' wenn a = b sonst '0'
    );
  end component;

  signal s_a: std_logic_vector(k-1 downto 0);
  signal s_b: std_logic_vector(k-1 downto 0);
  signal s_q: std_logic;

begin
  dut: comparator
  generic map(k)
      port map (
          s_a, s_b, s_q 
      );

  -- Stimulus process
  stimuli: process
  begin 
    s_a <= "1100";
    s_b <= "1000"; 
    wait for 20 ns;
    s_a <= "1000";
    s_b <= "1100"; 
    wait for 20 ns;
    s_a <= "1100";
    s_b <= "1100"; 
    wait for 20 ns; 

  wait;
  end process;

end testing;
