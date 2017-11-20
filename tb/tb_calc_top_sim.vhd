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

  p_clk : process

  begin

    clk_i <= '0';
    wait for 5 ns;
    clk_i <= '1';
    wait for 5 ns;

  end process p_clk;

  run : process

  begin

    sw_i <= "0101000000000000";
    pb_i <= "0000";
    reset_i <= '1';
    wait for 1 ms;
    reset_i <= '0';
    wait for 1 ms;
    pb_i <= "0000";
--    sw_i <= "0101000000011011"; -- 27 OK
--    sw_i <= "0000011110100011"; -- 1955 OK
--    sw_i <= "0000001000011111"; -- 9 OK
--    
    sw_i <= "0000111111111111";
    wait for 5 ms;
    pb_i <= "1000";
    wait for 5 ms;
    pb_i <= "0000";
--    sw_i <= "0101110011001100";
    sw_i <= "0000000000000000";
    wait for 5 ms;
    pb_i <= "1000";
    wait for 5 ms;
    pb_i <= "0000";
--    sw_i <= "0101111111110000"; -- sqrtCount_s
--    sw_i <= "0111000000000000"; -- logdual
    sw_i <= "0101111111110000"; 
    wait for 5 ms;
    pb_i <= "1000";
    wait for 5 ms;
    pb_i <= "0000";
    wait for 50 ms;

  end process run;

end sim;
