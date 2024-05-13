CONFIGURATION eq OF tb_comparator IS
    FOR sim
    END FOR;
END CONFIGURATION;

CONFIGURATION gt OF tb_comparator IS
    FOR sim
        FOR DUT : comparator
            USE ENTITY work.gr_than_gen;
        END FOR;
    END FOR;
END CONFIGURATION;

CONFIGURATION lt OF tb_comparator IS
    FOR sim
        FOR DUT : comparator
            USE ENTITY work.gr_than_gen
            PORT MAP (
                a => b,
                b => a,
                q => q
                );
        END FOR;
    END FOR;
END CONFIGURATION;