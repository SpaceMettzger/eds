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
        cout: out std_logic
    );
end gen_adder;

architecture arch of gen_adder is

    component adder
        port (
            x, y, cin : in std_logic;
            cout, sum : out std_logic
        );
    end component;

    signal t: std_logic_vector(n downto 0);

begin
    t(0) <= cin;
    cout <= t(n);

    GEN_ADD_X: for i in 0 to n-1 generate
        GEN_ADD_I: adder port map (
            x => x(i),
            y => y(i),
            cin => t(i),
            sum => sum(i),
            cout => t(i+1)
        );
    end generate;

end arch;
