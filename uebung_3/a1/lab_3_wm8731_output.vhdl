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
        reset_led : out std_logic;
        i2c_sdat : out std_logic;
        i2c_sclk : out std_logic;
        aud_xck : out std_logic;
        aud_bclk : inout std_logic;
        aud_dacdat : inout std_logic;
        aud_daclrck : inout std_logic;
		  aud_daclrck_2 : out std_logic;
		  aud_bclk_2 : out std_logic
		 
    );
end wm8731_output;

architecture struct of wm8731_output is
    signal s_tone_out : std_logic_vector(31 downto 0);
    signal s_c0 : STD_LOGIC;
	 signal s_locked : STD_LOGIC;
    signal s_not_locked : STD_LOGIC;
	 signal s_aud_daclrck : STD_LOGIC;
	 
begin
    s_not_locked <= not s_locked;

	u3: entity work.pll 
		PORT MAP (
			areset => reset,
			inclk0 => clk,
			c0 => s_c0,
			locked => s_locked
		);
		
    u1: entity work.sound_generation
        port map (
            clk => s_c0,
            reset => s_not_locked,
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
            reset => s_not_locked,
            din => s_tone_out,
            i2c_sdat => i2c_sdat,
            i2c_sclk => i2c_sclk,
            aud_xck => aud_xck,
            aud_bclk => aud_bclk,
            aud_dacdat => aud_dacdat,
            aud_daclrck => aud_daclrck
        );
    
        process(reset)
        begin
            if reset = '1' then 
                reset_led <= '1';
            else 
                reset_led <= '0';
            end if;
        end process;
		  
		aud_daclrck_2 <= aud_dacdat;
		aud_bclk_2 <= aud_bclk;

end struct;