--------------------------------------------------------------------------------
-- FHTW - BEL3 - DSD - calculator project
--
-- Author:	Helmut Resch
--			el16b005 BEL3 no. 15 in attendance list
--          User interface Type "A", square root, logdual, or, ror
--
-- File:	calc_ctrl_.vhd
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
-- Design Unit:	Calculator Control Unit
--				Entity
--
-- Description:	The Calculator Control unit is part of the calculator project.
--				It includes the FSM for enter OP1, OP2, OPERAND
--				and for CALCUALTION and DISPLAY RESULT
--				Digilent Basys3 FPGA board.
--------------------------------------------------------------------------------

--! @file calc_ctrl_.vhd
--! @brief Calculator Control Unit Entity

library IEEE;
use IEEE.std_logic_1164.all;

--! @brief Calculator Control Unit Entity
--! @details The Calculator Control unit is part of the calculator project.

entity calc_ctrl is

  port
  (
    clk_i : in std_logic;
    reset_i : in std_logic;
    swsync_i : in std_logic_vector(15 downto 0);
    pbsync_i : in std_logic_vector(3 downto 0);
    finished_i : in std_logic;
    result_i : in std_logic_vector(15 downto 0);
    sign_i : in std_logic;
    overflow_i : in std_logic;
    error_i : in std_logic;
    dig0_o : out std_logic_vector(7 downto 0);
    dig1_o : out std_logic_vector(7 downto 0);
    dig2_o : out std_logic_vector(7 downto 0);
    dig3_o : out std_logic_vector(7 downto 0);
    led_o : out std_logic_vector(15 downto 0);
    op1_o : out std_logic_vector(11 downto 0);
    op2_o : out std_logic_vector(11 downto 0);
    optype_o : out std_logic_vector(3 downto 0);
    start_o : out std_logic
  );

end calc_ctrl;
