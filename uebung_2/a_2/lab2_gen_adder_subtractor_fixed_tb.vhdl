library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_gen_adder_subtractor_fixed is
end tb_gen_adder_subtractor_fixed;

architecture tb of tb_gen_adder_subtractor_fixed is
    constant k : integer := 15; 

    component gen_adder_fixed is
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
    dut: gen_adder_fixed
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

        s_x <= "000001000000101"; -- 5 Nullen hinzugefügt
        s_y <= "001110101110100"; -- 1 Null hinzugefügt
        s_mode <= '0';
        wait for 20 ns;

        s_x <= "000000011010100"; -- 5 Nullen hinzugefügt
        s_y <= "000010011111011"; -- 1 Null hinzugefügt
        s_mode <= '0';
        wait for 20 ns;

        s_x <= "000000000101101"; -- 5 Nullen hinzugefügt
        s_y <= "010000101010101"; -- 1 Null hinzugefügt
        s_mode <= '0';
        wait for 20 ns;

        s_x <= "000001111110001"; -- 3 Nullen hinzugefügt
        s_y <= "000001001011001";  -- 5 Nullen hinzugefügt
        s_mode <= '1';
        wait for 20 ns;

        s_x <= "000110001001000"; -- 3 Nullen hinzugefügt
        s_y <= "000001011000111"; -- 5 Nullen hinzugefügt
        s_mode <= '1';
        wait for 20 ns;

        s_x <= "000001000000101"; -- 5 Nullen hinzugefügt
        s_y <= "001110101110100"; -- 1 Null hinzugefügt
        s_mode <= '1';
        wait for 20 ns;

        wait;
    end process;

end tb;