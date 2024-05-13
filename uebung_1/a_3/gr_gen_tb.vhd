library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity tb_gen_gr_than is
end tb_gen_gr_than;

architecture testing of tb_gen_gr_than is 
  constant k : integer := 4; 

  component gr_than
    generic (
      n: integer := k
      );-- n = Anzahl der zu vergleichenden Bits

    port(
      a,b: in std_logic_vector(n-1 downto 0); -- zwei Eingaenge zum Vergleich
         q: out std_logic
         );
  end component;

  signal s_a: std_logic_vector(k-1 downto 0);
  signal s_b: std_logic_vector(k-1 downto 0);
  signal s_q: std_logic;

begin
  -- Komponenten instanziieren
  dut: gr_than 
    port map (
      a => s_a,
      b => s_b,
      q => s_q);

  -- Beispielprozess für Stimuli-Signale
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