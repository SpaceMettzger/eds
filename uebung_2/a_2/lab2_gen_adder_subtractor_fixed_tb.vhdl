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

        s_x <= "00000" & "10000" & "00101"; -- 5 Nullen hinzugefügt - 10000.00101
        s_y <= "0" & "011101" & "01110100"; -- 1 Null hinzugefügt - 011101.01110100
        s_mode <= '0';
        wait for 20 ns;

        s_x <= "00000" & "00110" & "10100"; -- 5 Nullen hinzugefügt - 00110.10100
        s_y <= "0" & "000100" & "11111011"; -- 1 Null hinzugefügt - 000100.11111011
        s_mode <= '0';
        wait for 20 ns;

        s_x <= "00000" & "00001" & "01101"; -- 5 Nullen hinzugefügt - 00001.01101
        s_y <= "0" & "100001" & "01010101"; -- 1 Null hinzugefügt - 100001.01010101
        s_mode <= '0';
        wait for 20 ns;

        s_x <= "000" & "00111" & "1110001"; -- 3 Nullen hinzugefügt - 00111.1110001
        s_y <= "00000" & "1001" & "011001";  -- 5 Nullen hinzugefügt - 1001.011001
        s_mode <= '1'; -- Differenz: 11111110011111 ~ 01.100001
        wait for 20 ns;

        s_x <= "000" & "11000" & "1001000"; -- 3 Nullen hinzugefügt - 11000.1001000
        s_y <= "00000" & "1011" & "000111"; -- 5 Nullen hinzugefügt - 1011.000111 
        s_mode <= '1'; -- Differenz: 000011010111010
        wait for 20 ns;

        s_x <= "000" & "00100" & "0000101"; -- 3 Nullen hinzugefügt - 00100.0000101   
        s_y <= "00000" & "0101" & "110100"; -- 5 Null hinzugefügt - 0101.110100
        s_mode <= '1'; -- Differenz: 11111110001101 ~ -01.110011
        wait for 20 ns;

        wait;
    end process;

end tb;