library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gen_adder is
    generic (
        n : integer := 4
    );
    port (
        x, y: in std_logic_vector(n-1 downto 0);
        sum : out std_logic_vector(n-1 downto 0); 
        cin : in std_logic;
        cout: out std_logic;
        mode: in std_logic
    );
end gen_adder;

architecture arch of gen_adder is

    component adder
        port (
            x, y, cin : in std_logic;
            cout, sum : out std_logic
        );
    end component;

    signal carries: std_logic_vector(n downto 0);
    signal y_mod: std_logic_vector(n-1 downto 0);

begin
    process(x, y, mode)
    begin
        if mode = '1' then
            y_mod <= not y; 
            carries(0) <= '1'; 
        else
            y_mod <= y;
            carries(0) <= cin; 
        end if;
    end process;

    cout <= carries(n);

    GEN_ADD_X: for i in 0 to n-1 generate
        GEN_ADD_I: adder port map (
            x => x(i),
            y => y_mod(i),
            cin => carries(i),
            sum => sum(i),
            cout => carries(i+1)
        );
    end generate;

end arch;