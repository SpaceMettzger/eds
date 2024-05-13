library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity tb_gen_equal is
end tb_gen_equal;

architecture testing of tb_gen_equal is 
  constant k : integer := 4; 

  component comparator is
    GENERIC (
        n: integer := k
    ); --Anzahl der zu vergleichenden Bits

    port (
        a, b: in std_logic_vector(n-1 downto 0); -- zwei Eingaenge zum Vergleich
        q: out std_logic -- '1' wenn a = b sonst '0'
    );
end component;

  signal s_a: std_logic_vector(k-1 downto 0);
  signal s_b: std_logic_vector(k-1 downto 0);
  signal s_q: std_logic;

begin
  -- Komponenten instanziieren
  dut: comparator 
    port map (
      a => s_a,
      b => s_b,
      q => s_q);

  -- Beispielprozess für Stimuli-Signale
  stimuli: process
  begin 
    for i in 0 to 15 loop -- generiere 16 Werte (entspr. 4 Bit)
      s_a <= std_logic_vector(to_unsigned(i,k));  
      s_b <= std_logic_vector(to_unsigned(i+1,k));  
      wait for 20 ns; 
    end loop;
    wait;
  end process;

end testing;