--------------------------------------------------------------------------------
-- FHTW - BEL3 - DSD - calculator project
--
-- Author:	Helmut Resch
--			el16b005 BEL3 no. 15 in attendance list
--          User interface Type "A", square root, logdual, or, ror
--
-- File:	tb_alu_sim.vhd
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
--				Architecture SIM
--
-- Description:	The ALU unit is part of the calculator project.
--              The ALU provides all necessary calculations and handling of
--              error, overflow, sign, finished and result
--------------------------------------------------------------------------------

--! @file tb_alu_sim.vhd
--! @brief ALU Testbench Architecture SIM

library IEEE;
use IEEE.std_logic_1164.all;

--! @brief ALU Testbench Architecture SIM
--! @details The Calculcator Control uniti part of the calculator project.

architecture sim of tb_alu is

component alu

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

end component;

signal clk_i : std_logic;
signal reset_i : std_logic;
signal op1_i : std_logic_vector(11 downto 0);
signal op2_i : std_logic_vector(11 downto 0);
signal optype_i : std_logic_vector(3 downto 0);
signal start_i : std_logic;
signal finished_o : std_logic;
signal result_o : std_logic_vector(15 downto 0);
signal sign_o : std_logic;
signal overflow_o : std_logic;
signal error_o : std_logic;

begin

  i_alu : alu

  port map
  (
    clk_i => clk_i,
    reset_i => reset_i,
    finished_o => finished_o,
    result_o => result_o,
    sign_o => sign_o,
    overflow_o => overflow_o,
    error_o => error_o,
    op1_i => op1_i,
    op2_i => op2_i,
    optype_i => optype_i,
    start_i => start_i
  );

--! @brief ALU Testbench Architecture SIM
--! @details Process to generate 100MHz clock

  p_clk : process

  begin

    clk_i <= '0';
    wait for 5 ns;
    clk_i <= '1';
    wait for 5 ns;

  end process p_clk;

--! @brief ALU Testbench Architecture SIM
--! @details Process to generate misc. stimuli

  run : process

  begin

-- reset values

    reset_i <= '1';
    start_i <= '0';
    op1_i <= "000000000000";
    op2_i <= "000000000000";
    optype_i <= "0110";
    wait for 1 ms;

-- de assert reset

    reset_i <= '0';
    wait for 1 ms;

-- squareroot

    op1_i <= "101010101010";
    op2_i <= "010101010101";
    optype_i <= "0110";
    wait for 1 ms;
    start_i <= '1';
    wait for 10 ns; -- start for 1 impulse
    start_i <= '0';
    wait for 5 ms;

-- logdual
 
    optype_i <= "0111";
    wait for 1 ms;
    start_i <= '1';
    wait for 10 ns; -- start for 1 impulse
    start_i <= '0';
    wait for 5 ms;

-- or

    optype_i <= "1010";
    wait for 1 ms;
    start_i <= '1';
    wait for 10 ns; -- start for 1 impulse
    start_i <= '0';
    wait for 5 ms;

-- ror

    optype_i <= "1101";
    wait for 1 ms;
    start_i <= '1';
    wait for 10 ns; -- start for 1 impulse
    start_i <= '0';
    wait for 5 ms;

  end process run;

end sim;
