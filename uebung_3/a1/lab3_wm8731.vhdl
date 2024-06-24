library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity wm8731 is
port (  clk, reset : in std_logic; -- Takteingang (entsprechend 18,432 MHz fuer WM8731)
        din : in std_logic_vector(31 downto 0); -- Audiodaten: 16 Bit linker Kanal + 16 Bit rechter Kanal
        i2c_sdat : out std_logic; -- I2C serieller Datenkanal
        i2c_sclk : out std_logic; -- I2C serielle Clock
        aud_xck : out std_logic; -- WM8731 Referenztakt (siehe Register 8 Programmierung)
        aud_bclk : out std_logic; -- Audio Bit Clock
        aud_dacdat : out std_logic; -- DAC Daten
        aud_daclrck : out std_logic -- Links / Rechts
);
end wm8731;

architecture behavioral of wm8731 is
constant i2c_adr : std_logic_vector(7 downto 0) := "00110100";  -- I2C Device Adresse vom WM8731
constant arraysize : integer := 7;
type rom is array (0 to arraysize) of std_logic_vector(15 downto 0);

-- I2C Daten: 7 Bit Registeradresse plus 9 Datenbits 
constant i2c_data : rom := (
  "0001111000000000", -- R15 Reset Chip
  "0000100000010000", -- R4  DAC Sel
  "0000101000000000", -- R5  DAC Mute off
  "0000110001100111", -- R6  DAC on, out on
  "0000111000000011", -- R7  Slave, DSP Modus, 16 Bit,
  "0001000000000010", -- R8  Normal Modus, 384fs (18,432 Mhz, f_s = 48 kHz)
  "0001001000000000", -- R9  Deaktiviere Audio 
  "0001001000000001"  -- R9  Aktiviere Audio
);

signal s_din : std_logic_vector(31 downto 0);
signal s_lrswitch : integer range 0 to 2303;
signal i2c_clkdiv : std_logic_vector(5 downto 0);
signal i2c_clk : std_logic;
signal i2c_seq : integer range 0 to 2;
signal i2c_bitcnt : integer range 0 to 31; 
signal i2c_wordcnt :integer range 0 to 7;

begin

-- WM8731 I2C Schnittstelle 
process(clk)
begin
    if (reset = '1') then
        i2c_clk <= '0';
        i2c_clkdiv  <= (others=>'0');
    elsif (clk'event and clk='1') then 
        i2c_clkdiv <= std_logic_vector(unsigned(i2c_clkdiv)+1);
        if i2c_clkdiv = "010010" then		-- 18 MHz/36 = 500 kHz, Umschalten bei halber Periode
        i2c_clk <= not (i2c_clk);
              i2c_clkdiv <= "000000";
        end if;
    end if;
end process;

process(i2c_clk)
begin
    if (reset = '1') then
        i2c_sdat <= '0';	
        i2c_sclk <= '0';	
        i2c_seq <= 0;
        i2c_bitcnt <= 0;
        i2c_wordcnt <= 0;	
    elsif (i2c_clk'event and i2c_clk='1') then 
    -- Zählung von ROM Data, 32 Bits pro Wort, Sequenz von jeweils 3 Bit
        -- i2c_seq zaehlt jeweils von 0 bis 2
        -- i2c_bitcnt zählt jeweils von 0 bis 31
        -- i2c_wordcnt wird nach 32 Schritte von i2c_bitcnt inkrementiert
        -- wenn i2c_wordcnt auf 7 steht, ist das Ende des Schreibens über I2C beendet
        if i2c_seq < 2 then 
            i2c_seq <= i2c_seq + 1;
        else
            if i2c_bitcnt < 32 then 
                i2c_bitcnt <= i2c_bitcnt + 1;
            else 
                i2c_bitcnt <= 0;
                i2c_wordcnt <= i2c_wordcnt + 1;        
            end if;
            i2c_seq <= 0;    
        end if;
             
   -- Generierung des I2C Takt
           -- i2c_sclk alterniert abhaengig von i2c_bitcnt
        if i2c_bitcnt = 0 then
            if i2c_seq = 0 then 
                i2c_sclk <= '1';
            end if;
        elsif i2c_bitcnt = 1 then
            if i2c_seq = 1 then
                i2c_sclk <= '0';
            end if;
        elsif i2c_bitcnt = 29 then 
            if i2c_seq = 0 then
                i2c_sclk <= '0';
            else
                i2c_sclk <= '1';
            end if;
        elsif i2c_bitcnt = 30 then 
            i2c_sclk <= '1';
        elsif i2c_bitcnt = 31 then 
            i2c_sclk <= '1';
        elsif i2c_seq = 1 then
            i2c_sclk <= '1';
        else 
            i2c_sclk <= '0';
        end if;
        
   -- Generierung der I2C Daten
        case i2c_bitcnt is
            when 1 => i2c_sdat <= '0'; -- Startbedingung
            when 2 => i2c_sdat <= i2c_adr(7);-- 8 Bit I2C Adresse
            when 3 => i2c_sdat <= i2c_adr(6);
            when 4 => i2c_sdat <= i2c_adr(5);
            when 5 => i2c_sdat <= i2c_adr(4);
            when 6 => i2c_sdat <= i2c_adr(3);
            when 7 => i2c_sdat <= i2c_adr(2);
            when 8 => i2c_sdat <= i2c_adr(1);
            when 9 => i2c_sdat <= i2c_adr(0);
            -- 1 bit Acknowledge
            when 11 => i2c_sdat <= i2c_data(i2c_wordcnt)(15); -- 8 Bit I2C Daten 
            when 12 => i2c_sdat <= i2c_data(i2c_wordcnt)(14); 
            when 13 => i2c_sdat <= i2c_data(i2c_wordcnt)(13);
            when 14 => i2c_sdat <= i2c_data(i2c_wordcnt)(12);
            when 15 => i2c_sdat <= i2c_data(i2c_wordcnt)(11);
            when 16 => i2c_sdat <= i2c_data(i2c_wordcnt)(10);
            when 17 => i2c_sdat <= i2c_data(i2c_wordcnt)(9);
            when 18 => i2c_sdat <= i2c_data(i2c_wordcnt)(8);
            -- 1 bit Acknowledge
            when 20 => i2c_sdat <= i2c_data(i2c_wordcnt)(7);
            when 21 => i2c_sdat <= i2c_data(i2c_wordcnt)(6);
            when 22 => i2c_sdat <= i2c_data(i2c_wordcnt)(5);
            when 23 => i2c_sdat <= i2c_data(i2c_wordcnt)(4);
            when 24 => i2c_sdat <= i2c_data(i2c_wordcnt)(3);
            when 25 => i2c_sdat <= i2c_data(i2c_wordcnt)(2);
            when 26 => i2c_sdat <= i2c_data(i2c_wordcnt)(1);
            when 27 => i2c_sdat <= i2c_data(i2c_wordcnt)(0);
            -- 1 bit Acknowledge
            when 29 => i2c_sdat <= '0'; 
            when others  => i2c_sdat <= '1'; 
        end case;
    end if;
end process;

-- WM8731 Audiointerface
process(clk, reset)
begin
    if (reset = '1') then
        s_lrswitch <= 0;
        aud_daclrck <= '0';
        s_din <= (others=>'0');
    elsif (clk'event and clk='1') then 
        if s_lrswitch = 383 then -- 18,432 Mhz / 384 = 48 kHz (siehe Datenblatt Seite 42)
              aud_daclrck <= '1'; -- Beginn der Daten
              s_din <= din;
            s_lrswitch <= 0;
        else
              aud_daclrck <= '0';
              s_din <= s_din(30 downto 0) & "0";
              s_lrswitch <=  s_lrswitch + 1;
        end if;
      end if;
end process;

aud_xck  <= clk;
aud_bclk <= not(clk);
aud_dacdat <= s_din(31);
end behavioral;