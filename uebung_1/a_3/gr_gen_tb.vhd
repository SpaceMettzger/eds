library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity tb_gen_gr_than is
end tb_gen_gr_than;

architecture testing of tb_gen_gr_than is 
  component gr_than 
    generic (n: integer := 4);-- n = Anzahl der zu vergleichenden Bits
    port(a,b: in std_logic_vector(n-1 downto 0); -- zwei Eingaenge zum Vergleich
         q: out std_logic);
  end component;

  signal a: std_logic_vector(3 downto 0) := (others => '0');
  signal b: std_logic_vector(3 downto 0) := (others => '0');
  signal eq: std_logic;

begin
  -- Komponenten instanziieren
  dut: gr_than generic map (
      n => 4)
    port map (
      a => a,
      b => b,
      q => eq);

  -- Beispielprozess für Stimuli-Signale
  stimuli: process
  begin 
    for i in 0 to 15 loop -- generiere 16 Werte (entspr. 4 Bit)
      a <= std_logic_vector(to_unsigned(i+1,4));  
      b <= std_logic_vector(to_unsigned(i,4));  
      wait for 20 ns; 
    end loop;
    wait;
  end process;

  -- Überprüfung der Ausgabe
  assertion_check: process
  begin
    wait for 30 ns; -- Wartezeit für Stabilität der Ausgabe
    assert eq = '1' report "Output eq not as expected" severity error;
    wait;
  end process;

end testing;