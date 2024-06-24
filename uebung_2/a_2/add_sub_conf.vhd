CONFIGURATION add OF tb_gen_adder_subtractor_fixed IS
    FOR tb
        FOR dut: gen_adder_fixed
            USE ENTITY work.gen_adder_fixed
            GENERIC MAP (
                n => 15,  -- 10 bits for x and sum
                k => 15   -- 14 bits for y
            )
            PORT MAP (
                x => x,  -- Signal x in the testbench (10 bits)
                y => y,  -- Signal y in the testbench (14 bits)
                sum => sum,  -- Signal sum in the testbench (10 bits)
                cin => cin,  -- Signal cin in the testbench
                cout => cout,  -- Signal cout in the testbench
                mode => mode  -- Signal mode in the testbench
            );
        END FOR;
    END FOR;
END CONFIGURATION add;

CONFIGURATION sub OF tb_gen_adder_subtractor_fixed IS
    FOR tb
        FOR dut: gen_adder_fixed
            USE ENTITY work.gen_adder_fixed
            GENERIC MAP (
                n => 15,  -- 12 bits for x and sum
                k => 15   -- 10 bits for y
            )
            PORT MAP (
                x => x,  -- Signal x in the testbench (12 bits)
                y => y,  -- Signal y in the testbench (10 bits)
                sum => sum,  -- Signal sum in the testbench (12 bits)
                cin => cin,  -- Signal cin in the testbench
                cout => cout,  -- Signal cout in the testbench
                mode => mode  -- Signal mode in the testbench
            );
        END FOR;
    END FOR;
END CONFIGURATION sub;
