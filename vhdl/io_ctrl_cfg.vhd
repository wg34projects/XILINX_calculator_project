--
-- FHTW - BEL3 - DSD - calculator project
--
--
-- Author:	Helmut Resch
--			el16b005
--			BEL3
--
-- File:	io_ctrl_cfg.vhd
--
-- Version history:
--
-- v_0.1	13.11.2017	IO Ctrl + Testbench
-- v_0.2	15.11.2017	Calc Ctrl + Testbench
--
-- Design Unit:	IO Control Unit
--				Configuration
--
-- Description:	The IO Control unit is part of the calculator project.
--				It manages the interface to the 7-segment displays,
--				the LEDs, the push buttons and the switches of the
--				Digilent Basys3 FPGA board.
--
--
-- below doxygen documentation blocks

--! @file io_ctrl_cfg.vhd
--! @brief IO Control Unit Configuration

configuration io_ctrl_rtl_cfg of io_ctrl is

  for rtl
  end for;

end io_ctrl_rtl_cfg;
