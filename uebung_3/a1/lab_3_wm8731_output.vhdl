library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity wm8731_output is
    port (
        clk : in std_logic; -- System clock
        reset : in std_logic; -- System reset
        key3 : in std_logic;
        key2 : in std_logic;
        key1 : in std_logic;
        key0 : in std_logic;
        led : out std_logic_vector(3 downto 0);
        i2c_sdat : out std_logic;
        i2c_sclk : out std_logic;
        aud_xck : out std_logic;
        aud_bclk : out std_logic;
        aud_dacdat : out std_logic;
        aud_daclrck : out std_logic
    );
end wm8731_output;

architecture struct of wm8731_output is
    signal s_tone_out : std_logic_vector(31 downto 0);
    signal s_c0 : STD_LOGIC;
	 signal s_locked : STD_LOGIC;
	 
begin

	u3: entity work.wm8731_pll 
		PORT MAP (
			areset => reset,
			inclk0 => clk,
			c0 => s_c0,
			locked => s_locked
		);
		
    u1: entity work.sound_generation
        port map (
            clk => s_c0,
            reset => not s_locked,
            key3 => key3,
            key2 => key2,
            key1 => key1,
            key0 => key0,
            led => led,
            tone_out => s_tone_out
        );

    u2: entity work.wm8731
        port map (
            clk => s_c0,
            reset => not s_locked,
            din => s_tone_out,
            i2c_sdat => i2c_sdat,
            i2c_sclk => i2c_sclk,
            aud_xck => aud_xck,
            aud_bclk => aud_bclk,
            aud_dacdat => aud_dacdat,
            aud_daclrck => aud_daclrck
        );

end struct;