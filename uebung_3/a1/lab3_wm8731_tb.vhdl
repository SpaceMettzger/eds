library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_wm8731 is
end tb_wm8731;

architecture tb of tb_wm8731 is  
    component wm8731 is
    port (  clk, reset : in std_logic; -- Takteingang (entsprechend 18,432 MHz fuer WM8731)
            din : in std_logic_vector(31 downto 0); -- Audiodaten: 16 Bit linker Kanal + 16 Bit rechter Kanal
            i2c_sdat : out std_logic; -- I2C serieller Datenkanal
            i2c_sclk : out std_logic; -- I2C serielle Clock
            aud_xck : out std_logic; -- WM8731 Referenztakt (siehe Register 8 Programmierung)
            aud_bclk : out std_logic; -- Audio Bit Clock
            aud_dacdat : out std_logic; -- DAC Daten
            aud_daclrck : out std_logic -- Links / Rechts
    );
    end component;

    signal s_clk: std_logic;
    signal s_reset: std_logic;
    signal s_din: std_logic_vector(31 downto 0);

    begin
    dut: wm8731
    port map (clk => s_clk, reset=> s_reset, din=> s_din);
    
        p_clk: process
        begin
            s_din <= "00000000000000000000000000000000";
            s_clk <= '1'; wait for 10 ns;
            s_clk <= '0'; wait for 10 ns;
        end process;

        p_reset: process
        begin
            s_reset <= '1'; wait for 20 ns;
            s_reset <= '0'; wait;
        end process;
    
    end tb;