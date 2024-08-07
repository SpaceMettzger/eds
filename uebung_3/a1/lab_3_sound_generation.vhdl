library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity sound_generation is
    port (  
        clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        key3 : in  STD_LOGIC;
        key2 : in  STD_LOGIC;
        key1 : in  STD_LOGIC;
        key0 : in  STD_LOGIC;
        led : out  STD_LOGIC_VECTOR (3 downto 0);
        tone_out : out std_logic_vector(31 downto 0)
    );
end sound_generation;

-- C6 (1046,5 Hz); 
-- E6 (1318,5 Hz); 
-- G6 (1568,0 Hz); 
-- C7 (2093,0 Hz);

-- max signal amplitude: must be no greater than 1.0V rms at AVDD = 3.3V

-- T = 1 / f

-- N = clock frequenz / f

-- N_C6 = 18,432 Mhz / 1046.5 Hz = 17613
-- N_E6 = 18,432 Mhz / 1318.5 Hz = 13979.52
-- N_G6 = 18,432 Mhz / 1558.0 Hz = 11830.55
-- N_C7 = 18,432 Mhz / 2093.0 Hz = 8806.5

architecture behavioral of sound_generation is
    signal counter : integer := 0;
    signal N : integer := 0;
    signal s_frequency_select : std_logic_vector(1 downto 0) := "11";
    signal toggle : STD_LOGIC := '0';
	 signal s_out : std_logic_vector(15 downto 0);

    begin
        process(clk, reset) -- Prozess für die generierung der Töne. 
        begin
            if reset = '1' then
                counter <= 0;
                toggle <= '0';
            elsif rising_edge(clk) then
                case s_frequency_select is
                    when "00" => N <= 8806; -- C7
                    when "01" => N <= 11830; -- G6
                    when "10" => N <= 13979; -- E6
                    when "11" => N <= 17613; -- C6
                    when others => N <= 17613; -- C6
                end case;
            end if;
            if counter >= (N / 2) then
                counter <= 0;
                toggle <= not toggle;
            else
                counter <= counter + 1;
            end if;
        end process;

        process(clk, reset) -- Prozess für die Knopf-Priorisierung
        begin
            if reset = '1' then
                s_frequency_select <= "00"; -- C6
                led <= "0000";
            elsif rising_edge(clk) then
                if key0 = '0' then
                    s_frequency_select <= "00"; -- C7
                    led <= "0001";
                elsif key1 = '0' then
                    s_frequency_select <= "01"; -- G6
                    led <= "0010";
                elsif key2 = '0' then
                    s_frequency_select <= "10"; -- E6
                    led <= "0100";
                elsif key3 = '0' then
                    s_frequency_select <= "11"; -- C6
                    led <= "1000";
                else
                    s_frequency_select <= "11"; -- C6
                    led <= "0000";
                end if;
            end if;
        end process;
    
        process(toggle)
        begin
            case toggle is
                when '1' => s_out <= "0111111111111111"; 
                when '0' => s_out <= "1000000000000000"; 
                when others => s_out <= "0000000000000000"; 
            end case;
				tone_out <= s_out & s_out;
        end process;


end behavioral;