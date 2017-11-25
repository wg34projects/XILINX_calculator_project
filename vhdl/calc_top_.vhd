--------------------------------------------------------------------------------
-- FHTW - BEL3 - DSD - calculator project
--
-- Author:	Helmut Resch
--			el16b005 BEL3 no. 15 in attendance list
--          User interface Type "A", square root, logdual, or, ror
--
-- File:	calc_top_.vhd
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
-- Design Unit:	Calculator Top Design
--				Entity
--
-- Description:	The IO Control unit is part of the calculator project.
--              The Calculator Top Design links the io_ctrl, calc_ctrl and ALU
--              with internal signals and portmapping
--------------------------------------------------------------------------------

--! @file calc_top_.vhd
--! @brief Calculator Top Design Entity

library IEEE;
use IEEE.std_logic_1164.all;

--! @brief Calculator Top Design Entity
--! @details The Calculator Control unit is part of the calculator project.

entity calc_top is

  port
  (
    clk_i : in std_logic;
    reset_i : in std_logic;
    sw_i : in std_logic_vector(15 downto 0);
    pb_i : in std_logic_vector(3 downto 0);
    ss_o : out std_logic_vector(7 downto 0);
    ss_sel_o : out std_logic_vector(3 downto 0);
    led_o : out std_logic_vector(15 downto 0)
  );

end calc_top;
