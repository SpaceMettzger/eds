CONFIGURATION eq OF tb_comparator IS
    FOR testing
	FOR dut: comparator
            USE ENTITY work.equal;
	END FOR;  
    END FOR;
END CONFIGURATION;

CONFIGURATION gt OF tb_comparator IS
    FOR testing
        FOR dut: comparator
            USE ENTITY work.gr_than  
            PORT MAP (
                a => a,
                b => b,
                q => q
                );
        END FOR;
    END FOR;
END CONFIGURATION;

CONFIGURATION lt OF tb_comparator IS
    FOR testing
        FOR dut: comparator
            USE ENTITY work.gr_than
            PORT MAP (
                a => b,
                b => a,
                q => q
                );
        END FOR;
    END FOR;
END CONFIGURATION;