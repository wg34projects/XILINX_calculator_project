--------------------------------------------------------------------------------
-- FHTW - BEL3 - DSD - calculator project
--
-- Author:	Helmut Resch
--			el16b005 BEL3 no. 15 in attendance list
--          User interface Type "A", square root, logdual, or, ror
--
-- File:	tb_calc_top_sim.vhd
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
-- Design Unit:	Calculator Top Design Testbench
--				Architecture SIM
--
-- Description:	The IO Control unit is part of the calculator project.
--              The Calculator Top Design links the io_ctrl, calc_ctrl and ALU
--              with internal signals and portmapping
--------------------------------------------------------------------------------

--! @file tb_calc_top_sim.vhd
--! @brief Calculator Top Design Testbench Architecture SIM

library IEEE;
use IEEE.std_logic_1164.all;

--! @brief Calculator Top Design Testbench Architecture SIM
--! @details The Calculcator Control uniti part of the calculator project.

architecture sim of tb_calc_top is

component calc_top

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

end component;

signal clk_i : std_logic;
signal reset_i : std_logic;
signal sw_i : std_logic_vector(15 downto 0);
signal pb_i : std_logic_vector(3 downto 0);
signal ss_o : std_logic_vector(7 downto 0);
signal ss_sel_o : std_logic_vector(3 downto 0);
signal led_o :std_logic_vector(15 downto 0);

begin

  i_calc_top : calc_top

  port map
  (
    clk_i => clk_i,
    reset_i => reset_i,
    sw_i => sw_i,
    pb_i => pb_i,
    ss_o => ss_o,
    ss_sel_o => ss_sel_o,
    led_o => led_o
  );

--! @brief Calculator Top Design Testbench Architecture SIM
--! @details Process to generate 100MHz clock

  p_clk : process

  begin

    clk_i <= '0';
    wait for 5 ns;
    clk_i <= '1';
    wait for 5 ns;

  end process p_clk;

--! @brief Calculator Top Design Testbench Architecture SIM
--! @details Process to generate misc. stimuli

  run : process

  begin

-- reset values

    sw_i <= "0000000000000000";
    pb_i <= "0000";
    reset_i <= '1';
    wait for 1 ms;

-- de assert reset

    reset_i <= '0';
    wait for 1 ms;
    
    sw_i <= "0000101010101010";
    wait for 5 ms;
    pb_i <= "1000";
    wait for 5 ms;
    pb_i <= "0000";
    sw_i <= "0000010101010101";
    wait for 5 ms;
    pb_i <= "1000";
    wait for 5 ms;
    pb_i <= "0000";
    sw_i <= "0110000000000000";  -- sro
--    sw_i <= "0111000000000000";  -- logdual
--    sw_i <= "1010000000000000";  -- or
--    sw_i <= "1101000000000000";  -- ror
--    sw_i <= "1111000000000000";  -- error
    wait for 5 ms;
    pb_i <= "1000";
    wait for 5 ms;
    pb_i <= "0000";
    wait for 5 ms;

  end process run;

end sim;
