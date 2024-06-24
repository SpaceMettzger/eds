LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE myfixed IS
CONSTANT minuend_breite:positive:=12; -- Bitbreite des Minuenden
CONSTANT minuend_bruchb:positive:=7; -- Anzahl der Minuenden-Bruchbits
CONSTANT subtrahend_breite:positive:=10; -- Bitbreite des Subtrahends
CONSTANT subtrahend_bruchb:positive:=6; -- Anzahl der Subtrahend-Bruchbits
CONSTANT summand_a_breite:positive:=10; -- Bitbreite des ersten Summanden
CONSTANT summand_a_bruchb:positive:=5; -- Anzahl der Summanden-Bruchbits fuer den ersten Summanden
CONSTANT summand_b_breite:positive:=14; -- Bitbreite des zweiten Summanden
CONSTANT summand_b_bruchb:positive:=8; -- Anzahl der Summanden-Bruchbits fuer den zweiten Summanden

SUBTYPE t_datain_minuend IS unsigned(minuend_breite-1 DOWNTO 0);
SUBTYPE t_datain_subtrahend IS unsigned(subtrahend_breite-1 DOWNTO 0);
SUBTYPE t_dataout_subtraction IS unsigned(minuend_breite-1 DOWNTO 0); -- kann maximal so gross sein wie der Minuend

SUBTYPE t_datain_summand_a IS unsigned(summand_a_breite-1 DOWNTO 0);
SUBTYPE t_datain_summand_b IS unsigned(summand_b_breite-1 DOWNTO 0);
SUBTYPE t_dataout_addition IS unsigned(summand_b_breite DOWNTO 0); -- Kann maximal so gross wie Summand b + 1 sein


END PACKAGE myfixed;