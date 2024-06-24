library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.myfixed.all;

entity gen_adder_fixed is
    generic (
        n : integer := 15;  -- 10 für Addition
        k : integer := 15   --14 für Addition
    );
    port (
        x : in std_logic_vector(n-1 downto 0);
        y: in std_logic_vector(k-1 downto 0);
        sum : out std_logic_vector(14 downto 0); 
        cin : in std_logic;
        cout: out std_logic;
        mode: in std_logic
    );
end gen_adder_fixed;

architecture arch of gen_adder_fixed is

    component adder
        port (
            x, y, cin : in std_logic;
            cout, sum : out std_logic
        );
    end component;

    signal s_carries: std_logic_vector(n downto 0);
    signal s_y: unsigned(k-1 downto 0);
    signal s_x: unsigned(n-1 downto 0);
    

begin
    process(x, y, mode)
    variable v_y: unsigned(k-1 downto 0);
    variable v_x: unsigned(n-1 downto 0);
    begin
        if mode = '1' then
            v_y := not unsigned(y) + 1; 
            v_x := unsigned(x);
            s_carries(0) <= '0';
            v_y := shift_left(v_y, (minuend_bruchb - subtrahend_bruchb));
        else
            v_x := unsigned(x);
            v_y := unsigned(y);
            s_carries(0) <= '0'; 
            v_x := shift_left(v_x, (summand_b_bruchb - summand_a_bruchb));
        end if;
        s_y <= v_y;
        s_x <= v_x;
    end process;

    cout <= s_carries(n);

    GEN_ADD_X: for i in 0 to n-1 generate
        GEN_ADD_I: adder port map (
            x => s_x(i),
            y => s_y(i),
            cin => s_carries(i),
            sum => sum(i),
            cout => s_carries(i+1)
        );
    end generate;

end arch;