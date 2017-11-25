--------------------------------------------------------------------------------
-- FHTW - BEL3 - DSD - calculator project
--
-- Author:	Helmut Resch
--			el16b005 BEL3 no. 15 in attendance list
--          User interface Type "A", square root, logdual, or, ror
--
-- File:	tb_calc_ctrl_sim.vhd
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
-- Design Unit:	Calculator Control Unit Testbench
--				Architecture SIM
--
-- Description:	The Calculator Control unit is part of the calculator project.
--				It includes the FSM for enter OP1, OP2, OPERAND
--				and for CALCUALTION and DISPLAY RESULT
--				Digilent Basys3 FPGA board.
--------------------------------------------------------------------------------

--! @file tb_calc_ctrl_sim.vhd
--! @brief Calculcator Control Unit Testbench Architecture SIM

library IEEE;
use IEEE.std_logic_1164.all;

--! @brief Calculcator Control Unit Testbench Architecture SIM
--! @details The Calculcator Control uniti part of the calculator project.

architecture sim of tb_calc_ctrl is

component calc_ctrl

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

end component;

signal clk_i : std_logic;
signal reset_i : std_logic;
signal swsync_i : std_logic_vector(15 downto 0);
signal pbsync_i : std_logic_vector(3 downto 0);
signal finished_i : std_logic;
signal result_i : std_logic_vector(15 downto 0);
signal sign_i : std_logic;
signal overflow_i : std_logic;
signal error_i : std_logic;
signal dig0_o : std_logic_vector(7 downto 0);
signal dig1_o : std_logic_vector(7 downto 0);
signal dig2_o : std_logic_vector(7 downto 0);
signal dig3_o : std_logic_vector(7 downto 0);
signal led_o : std_logic_vector(15 downto 0);
signal op1_o : std_logic_vector(11 downto 0);
signal op2_o : std_logic_vector(11 downto 0);
signal optype_o : std_logic_vector(3 downto 0);
signal start_o : std_logic;

begin

  i_calc_ctrl : calc_ctrl

  port map
  (
    clk_i => clk_i,
    reset_i => reset_i,
    swsync_i => swsync_i,
    pbsync_i => pbsync_i,
    finished_i => finished_i,
    result_i => result_i,
    sign_i => sign_i,
    overflow_i => overflow_i,
    error_i => error_i,
    dig0_o => dig0_o,
    dig1_o => dig1_o,
    dig2_o => dig2_o,
    dig3_o => dig3_o,
    led_o => led_o,
    op1_o => op1_o,
    op2_o => op2_o,
    optype_o => optype_o,
    start_o => start_o
  );

--! @brief Calculator Control Unit Testbench Architecture RTL
--! @details Process to generate 100MHz clock

  p_clk : process

  begin

    clk_i <= '0';
    wait for 5 ns;
    clk_i <= '1';
    wait for 5 ns;

  end process p_clk;

--! @brief Calculator Control Unit Testbench Architecture RTL
--! @details Process to generate misc. stimuli

  run : process

  begin

--  reset values

    reset_i <= '1';
    swsync_i <= "0000000000000000";
    pbsync_i <= "0000";
    finished_i <= '0';
    result_i <= "0000000000000000";
    overflow_i <= '0';
    error_i <= '0';
    sign_i <= '0';
    wait for 1 ms;

-- de assert reset

    reset_i <= '0';
    wait for 1 ms;

--  first number for first operator

    swsync_i <= "0000111111000000";
    wait for 2 ms;

--  second number for first operator

    swsync_i <= "0000111111111111";
    wait for 2 ms;

--  third number for first operator = final

    swsync_i <= "1000101010101010";
    wait for 2 ms;

--  confirm third number for first operator

    pbsync_i <= "1000";
    wait for 1 ms;
    pbsync_i <= "0000";
    wait for 1 ms;

--  first number for second operator

    swsync_i <= "0000000000111111";
    wait for 2 ms;

--  second number for second operator

    swsync_i <= "0000000000000000";
    wait for 2 ms;

--  third number for second operator

    swsync_i <= "1010010101010101";
    wait for 2 ms;

--  confirm third number for second operator

    pbsync_i <= "1000";
    wait for 1 ms;
    pbsync_i <= "0000";
    wait for 1 ms;

--  first operator

    swsync_i <= "0000000000111111";
    wait for 2 ms;

--  second operator

    swsync_i <= "1010111111111111";
    wait for 2 ms;

--  third operator

    swsync_i <= "0110010000000011";
    wait for 2 ms;

--  confirm third operator

    pbsync_i <= "1000";
    wait for 1 ms;
    pbsync_i <= "0000";
    wait for 1 ms;

--  wait for finished from ALU

    wait for 2 ms;
    result_i <= "0000111010101101";
    finished_i <= '1';
    overflow_i <= '1';
    error_i <= '1';
    sign_i <= '1';
    wait for 10 ns; -- finished for 1 period of clk
    finished_i <= '0';
    wait for 2 ms;

-- reset error, overflow, sign

    overflow_i <= '0';
    error_i <= '0';
    sign_i <= '0';

--  confirm and start new calculation

    pbsync_i <= "1000";
    wait for 1 ms;
    pbsync_i <= "0000";
    wait for 1 ms;

--  number for first operator

    swsync_i <= "1000101010101010";
    wait for 2 ms;

--  confirm number for first operator

    pbsync_i <= "1000";
    wait for 1 ms;
    pbsync_i <= "0000";
    wait for 1 ms;

--  number for second operator

    swsync_i <= "1010010101010101";
    wait for 2 ms;

--  confirm number for second operator

    pbsync_i <= "1000";
    wait for 1 ms;
    pbsync_i <= "0000";
    wait for 1 ms;

--  operator

    swsync_i <= "0110010000000011";
    wait for 2 ms;

--  confirm operator

    pbsync_i <= "1000";
    wait for 1 ms;
    pbsync_i <= "0000";
    wait for 1 ms;

--  wait for finished from ALU

    wait for 2 ms;
    result_i <= "0000111010101101";
    finished_i <= '1';
    overflow_i <= '0';
    error_i <= '0';
    sign_i <= '0';
    wait for 10 ns; -- finished for 1 period of clk
    finished_i <= '0';
    wait for 2 ms;

--  confirm and start new calculation

    pbsync_i <= "1000";
    wait for 1 ms;
    pbsync_i <= "0000";
    wait for 1 ms;

  end process run;

end sim;
