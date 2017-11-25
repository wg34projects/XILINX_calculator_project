--------------------------------------------------------------------------------
-- FHTW - BEL3 - DSD - calculator project
--
-- Author:	Helmut Resch
--			el16b005 BEL3 no. 15 in attendance list
--          User interface Type "A", square root, logdual, or, ror
--
-- File:	tb_alu_.vhd
--
-- Version history:
--
-- v_0.1    14.11.2017	IO Ctrl + Testbench
-- v_0.2    15.11.2017	Calc Ctrl + Testbench
-- v_0.3	16.11.2017	ALU + Testbench
-- v_0.4	17.11.2017	Top Level Design + Testbench
-- v_0.5	20.11.2017	Synthesis + Implementation
--                      Solve XILINX warnings
-- v_0.6    21.11.2017  Synthesis and check calculations
--                      Solve error square root
-- v_1.0    24.11.2017  Final Specification check and Documentation
--
-- Design Unit:	ALU Testbench
--				Entity
--
-- Description:	The ALU unit is part of the calculator project.
--              The ALU provides all necessary calculations and handling of
--              error, overflow, sign, finished and result
--------------------------------------------------------------------------------

--! @file tb_alu_.vhd
--! @brief ALU Testbench Entity

library IEEE;
use IEEE.std_logic_1164.all;

--! @brief ALU Testbench Entity
--! @details The Calculator Control unit is part of the calculator project.

entity tb_alu is

end tb_alu;
