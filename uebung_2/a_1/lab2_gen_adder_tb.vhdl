library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_gen_adder is
end tb_gen_adder;

architecture tb of tb_gen_adder is
    constant k : integer := 4;
  
    component gen_adder is
      generic (
          n: integer := k
      );
  
      port (
        x, y: in std_logic_vector(n-1 downto 0);
        sum : out std_logic_vector(n-1 downto 0); 
        cin : in std_logic;
        cout: out std_logic
      );
    end component;

    signal s_x: std_logic_vector(k-1 downto 0);
    signal s_y: std_logic_vector(k-1 downto 0);
    signal s_sum: std_logic_vector(k-1 downto 0); 
    signal s_cin : std_logic;
    signal s_cout: std_logic;

    begin
    dut: gen_adder
    generic map(n => k)
        port map (
            x => s_x, y=> s_y, sum => s_sum, cin => s_cin, cout => s_cout
        );

        p_b0: process
        begin
            s_x(0) <= '0'; wait for 10 ns;
            s_x(0) <= '1'; wait for 10 ns;
        end process;
    
        p_b1: process
        begin
            s_x(1) <= '0'; wait for 20 ns;
            s_x(1) <= '1'; wait for 20 ns;
        end process;
    
        p_b2: process
        begin
            s_x(2) <= '0'; wait for 40 ns;
            s_x(2) <= '1'; wait for 40 ns;
        end process;
    
        p_b3: process
        begin
            s_x(3) <= '0'; wait for 80 ns;
            s_x(3) <= '1'; wait for 80 ns;
        end process;
    
        p_a0: process
        begin
            s_y(0) <= '0'; wait for 160 ns;
            s_y(0) <= '1'; wait for 160 ns;
        end process;
    
        p_a1: process
        begin
            s_y(1) <= '0'; wait for 320 ns;
            s_y(1) <= '1'; wait for 320 ns;
        end process;
    
        p_a2: process
        begin
            s_y(2) <= '0'; wait for 640 ns;
            s_y(2) <= '1'; wait for 640 ns;
        end process;
    
        p_a3: process
        begin
            s_y(3) <= '0'; wait for 1280 ns;
            s_y(3) <= '1'; wait for 1280 ns;
        end process;
    
    end tb;