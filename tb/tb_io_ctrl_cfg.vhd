--
-- FHTW - BEL3 - DSD - calculator project
--
--
-- Author:	Helmut Resch
--			el16b005
--			BEL3
--
-- File:	tb_io_ctrl_cfg.vhd
--
-- Version history:
--
-- v_0.1	13.11.2017	IO Ctrl + Testbench
-- v_0.2	15.11.2017	Calc Ctrl + Testbench
--
-- Design Unit:	IO Control Unit Testbench
--				Configuration
--
-- Description:	The IO Control unit is part of the calculator project.
--				It manages the interface to the 7-segment displays,
--				the LEDs, the push buttons and the switches of the
--				Digilent Basys3 FPGA board.
--
--
-- below doxygen documentation blocks

--! @file tb_io_ctrl_cfg.vhd
--! @brief IO Control Unit Testbench Configuration

configuration tb_io_ctrl_cfg of tb_io_ctrl is

  for sim

    for i_io_ctrl : io_ctrl

      use configuration work.io_ctrl_rtl_cfg;

    end for;

  end for;

end tb_io_ctrl_cfg;
