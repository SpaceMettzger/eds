library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

-- Design zu generischem n-bit addierer machen
-- Vorzeichenlos, ganze Zahlen

entity adder is
port (x, y, cin : in std_logic;
	  cout, sum : out std_logic
	  );
end adder;

architecture rtl of adder is

begin
	sum <= x xor y xor cin;
	cout <= (x and y) or (x and cin) or (y and cin);
end rtl;