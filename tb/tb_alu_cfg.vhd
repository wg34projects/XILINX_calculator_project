--
-- FHTW - BEL3 - DSD - calculator project
--
--
-- Author:	Helmut Resch
--			el16b005
--			BEL3
--
-- File:	tb_calc_ctrl_cfg.vhd
--
-- Version history:
--
-- v_0.1	13.11.2017	IO Ctrl + Testbench
-- v_0.2	15.11.2017	Calc Ctrl + Testbench
--
-- Design Unit:	Calculator Control Unit Testbench
--				Configuration
--
-- Description:	The Calculator Control unit is part of the calculator project.
--				It manages the interface to the 7-segment displays,
--				the LEDs, the push buttons and the switches of the
--				Digilent Basys3 FPGA board.
--
--
-- below doxygen documentation blocks

--! @file tb_calc_ctrl_.vhd
--! @brief Calculator Control Unit Testbench Configuration

configuration tb_alu_cfg of tb_alu is

  for sim

    for i_alu : alu

      use configuration work.alu_rtl_cfg;

    end for;

  end for;

end tb_alu_cfg;
