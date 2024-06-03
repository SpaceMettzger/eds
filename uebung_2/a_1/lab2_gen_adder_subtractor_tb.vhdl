library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_gen_adder_subtractor is
end tb_gen_adder_subtractor;

architecture tb of tb_gen_adder_subtractor is
    constant k : integer := 4;
  
    component gen_adder is
        generic (
            n: integer := k
        );
        port (
            x, y: in std_logic_vector(k-1 downto 0);
            sum : out std_logic_vector(k-1 downto 0); 
            cin : in std_logic;
            cout: out std_logic;
            mode: in std_logic
        );
    end component;

    signal s_x: std_logic_vector(k-1 downto 0);
    signal s_y: std_logic_vector(k-1 downto 0);
    signal s_sum: std_logic_vector(k-1 downto 0); 
    signal s_cin : std_logic;
    signal s_cout: std_logic;
    signal s_mode: std_logic;

begin
 s   dut: gen_adder
        generic map(n => k)
        port map (
            x => s_x, 
            y => s_y, 
            sum => s_sum, 
            cin => s_cin, 
            cout => s_cout,
            mode => s_mode
        );

    p_stimulus: process
    begin
        s_x <= (others => '0');
        s_y <= (others => '0');
        s_cin <= '0';
        s_mode <= '0';
        wait for 10 ns;

        s_x <= "0000";
        s_y <= "0000";
        s_mode <= '0';
        s_cin <= '0';
        wait for 20 ns;

        s_x <= "0001";
        s_y <= "0001";
        s_mode <= '0';
        s_cin <= '0';
        wait for 20 ns;

        s_x <= "0010";
        s_y <= "0001";
        s_mode <= '1';
        wait for 20 ns;

        s_x <= "0000";
        s_y <= "0011";
        s_mode <= '1';
        wait for 20 ns;

        s_x <= "1111";
        s_y <= "0001";
        s_mode <= '0';
        s_cin <= '0';
        wait for 20 ns;

        s_x <= "1111";
        s_y <= "0001";
        s_mode <= '1';
        wait for 20 ns;

        wait;
    end process;

end tb;
