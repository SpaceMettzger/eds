library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity tb_comparator is
end tb_comparator;
 
architecture testing of tb_comparator is 
    component comparator
    port(
      a,b: in std_logic_vector(1 downto 0);
      q: out std_logic);
    end component;


begin
	-- Komponenten instanziieren
	
   -- Beispielprozess fuer Stimuli-Signale
   stimuli: process
   begin 
   for i in 0 to 15 loop -- generiere 16 Werte (entspr. 4 Bit)
   		a <= std_logic_vector(to_unsigned(i,4));  
        b <= std_logic_vector(to_unsigned(i+1,4));  
        wait for 20 ns; 
   end loop;
   wait;
   end process;

end testing;