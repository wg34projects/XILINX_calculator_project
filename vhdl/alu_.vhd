--
-- FHTW - BEL3 - DSD - calculator project
--
--
-- Author:	Helmut Resch
--			el16b005
--			BEL3
--
-- File:	calc_ctrl_.vhd
--
-- Version history:
--
-- v_0.1	13.11.2017	IO Ctrl + Testbench
-- v_0.2	15.11.2017	Calc Ctrl + Testbench
--
-- Design Unit:	Calculator Control Unit
--				Entity
--
-- Description:	The Calculator Control unit is part of the calculator project.
--				The unit includes a FSM for the calculation itself and the 
--              decoder for the 7 segment displays.
--
--
-- below doxygen documentation blocks

--! @file calc_ctrl_.vhd
--! @brief Calculator Control Unit Entity

library IEEE;
use IEEE.std_logic_1164.all;

--! @brief Calculator Control Unit Entity
--! @details The Calculator Control unit is part of the calculator project.

entity alu is

  port
  (
    clk_i : in std_logic;
    reset_i : in std_logic;
    op1_i : in std_logic_vector(11 downto 0);
    op2_i : in std_logic_vector(11 downto 0);
    optype_i : in std_logic_vector(3 downto 0);
    start_i : in std_logic;
    finished_o : out std_logic;
    result_o : out std_logic_vector(15 downto 0);
    sign_o : out std_logic;
    overflow_o : out std_logic;
    error_o : out std_logic
  );

end alu;
