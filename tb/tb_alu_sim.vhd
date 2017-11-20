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

  p_clk : process

  begin

    clk_i <= '0';
    wait for 5 ns;
    clk_i <= '1';
    wait for 5 ns;

  end process p_clk;

  run : process

  begin

    reset_i <= '1';
    start_i <= '0';

    op1_i <= "111111111111";
    --op1_i <= "011111111111";
    op2_i <= "111111111111";
    optype_i <= "0101";
    wait for 1 ms;
    reset_i <= '0';
    wait for 1 ms;
    start_i <= '1';
    wait for 5 ms;
    start_i <= '0';
    wait for 1 ms;
 
    op1_i <= "001011011101";
    optype_i <= "0111";
    wait for 1 ms;
    start_i <= '1';
    wait for 5 ms;
    start_i <= '0';  
    wait for 1 ms;

    op1_i <= "111111000000";
    op1_i <= "000000000000";
    optype_i <= "1010";
    wait for 1 ms;
    start_i <= '1';
    wait for 5 ms;
    start_i <= '0';  
    wait for 1 ms;

    op1_i <= "000111111110";
    optype_i <= "1101";
    wait for 1 ms;
    start_i <= '1';
    wait for 5 ms;
    start_i <= '0';  
    wait for 1 ms;

  end process run;

end sim;
