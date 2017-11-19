--
-- FHTW - BEL3 - DSD - calculator project
--
--
-- Author:	Helmut Resch
--			el16b005
--			BEL3
--
-- File:	tb_calc_ctrl_sim.vhd
--
-- Version history:
--
-- v_0.1	13.11.2017	IO Ctrl + Testbench
-- v_0.2	15.11.2017	Calc Ctrl + Testbench
--
-- Design Unit:	Calculcator Control Unit Testbench
--				Architecture
--
-- Description:	The Calculcator Control unit is part of the calculator project.
--				It manages the interface to the 7-segment displays,
--				the LEDs, the push buttons and the switches of the
--				Digilent Basys3 FPGA board.
--
--
-- below doxygen documentation blocks

--! @file tb_calc_ctrl_sim.vhd
--! @brief Calculcator Control Unit Testbench Architecture

library IEEE;
use IEEE.std_logic_1164.all;

--! @brief Calculcator Control Unit Testbench Architecture
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

  p_clk : process

  begin

    clk_i <= '0';
    wait for 5 ns;
    clk_i <= '1';
    wait for 5 ns;

  end process p_clk;

  run : process

  begin

--  initial values and reset 1ms
    reset_i <= '1';
    swsync_i <= "0000000000000000";
    pbsync_i <= "0000";
    finished_i <= '0';
    result_i <= "0000000000000000";
    overflow_i <= '0';
    error_i <= '0';
    sign_i <= '0';
    wait for 1 ms;

--  reset done
    reset_i <= '0';
    wait for 1 ms;

--  first number for first operator
    swsync_i <= "0000111111000000";
    wait for 5 ms;

--  second number for first operator
    swsync_i <= "0000111111111111";
    wait for 5 ms;

--  third number for first operator = final
    swsync_i <= "1000101010101010";
    wait for 5 ms;

--  confirm third number for first operator
    pbsync_i <= "1000";
    wait for 1 ms;
    pbsync_i <= "0000";
    wait for 1 ms;

--  first number for second operator
    swsync_i <= "0000000000111111";
    wait for 5 ms;

--  second number for second operator
    swsync_i <= "0000000000000000";
    wait for 5 ms;

--  first number for second operator
    swsync_i <= "1010010101010101";
    wait for 5 ms;

--  confirm third number for second operator
    pbsync_i <= "1000";
    wait for 1 ms;
    pbsync_i <= "0000";
    wait for 5 ms;

--  first operator
    swsync_i <= "0000000000111111";
    wait for 5 ms;

--  second operator
    swsync_i <= "1010111111111111";
    wait for 5 ms;

--  third operator
    swsync_i <= "0101010000000011";
    wait for 5 ms;

--  confirm third operator
    pbsync_i <= "1000";
    wait for 1 ms;
    pbsync_i <= "0000";
    wait for 1 ms;

--  wait for finished from ALU
    wait for 15 ms;
    result_i <= "0000111010101101";
    finished_i <= '1';
    overflow_i <= '1';
    error_i <= '1';
    sign_i <= '0';
    wait for 10 ns;
    finished_i <= '0';
    wait for 20 ms;

--  confirm and start new calculation
    pbsync_i <= "1000";
    wait for 1 ms;
    pbsync_i <= "0000";
    wait for 10 ms;


  end process run;

end sim;
