--
-- FHTW - BEL3 - DSD - calculator project
--
--
-- Author:	Helmut Resch
--			el16b005
--			BEL3
--
-- File:	tb_io_ctrl_sim.vhd
--
-- Version history:
--
-- v_0.1	13.11.2017	start Project
--
--
-- Design Unit:	IO Control Unit Testbench
--				Architecture
--
-- Description:	The IO Control uniti part of the calculator project.
--				It manages the interface to the 7-segment displays,
--				the LEDs, the push buttons and the switches of the
--				Digilent Basys3 FPGA board.
--
--
-- below doxygen documentation blocks

--! @file tb_io_ctrl_sim.vhd
--! @brief IO Control Unit Testbench Architecture

library IEEE;
use IEEE.std_logic_1164.all;

--! @brief IO Control Unit Testbench Architecture
--! @details The IO Control uniti part of the calculator project.

architecture sim of tb_io_ctrl is

component io_ctrl

  port
  (
    clk_i : in std_logic;
    reset_i : in std_logic;
    dig0_i : in std_logic_vector(7 downto 0);
    dig1_i : in std_logic_vector(7 downto 0);
    dig2_i : in std_logic_vector(7 downto 0);
    dig3_i : in std_logic_vector(7 downto 0);
    led_i : in std_logic_vector(15 downto 0);
    sw_i : in std_logic_vector(15 downto 0);
    pb_i : in std_logic_vector(3 downto 0);
    ss_o : out std_logic_vector(7 downto 0);
    led_o : out std_logic_vector(15 downto 0);
    ss_sel_o : out std_logic_vector(3 downto 0);
    swsync_o : out std_logic_vector(15 downto 0);
    pbsync_o : out std_logic_vector(3 downto 0)
  );

end component;

signal clk_i : std_logic;
signal reset_i : std_logic;
signal dig0_i : std_logic_vector(7 downto 0);
signal dig1_i : std_logic_vector(7 downto 0);
signal dig2_i : std_logic_vector(7 downto 0);
signal dig3_i : std_logic_vector(7 downto 0);
signal led_i : std_logic_vector(15 downto 0);
signal sw_i : std_logic_vector(15 downto 0);
signal pb_i : std_logic_vector(3 downto 0);
signal ss_o : std_logic_vector(7 downto 0);
signal led_o : std_logic_vector(15 downto 0);
signal ss_sel_o : std_logic_vector(3 downto 0);
signal swsync_o : std_logic_vector(15 downto 0);
signal pbsync_o : std_logic_vector(3 downto 0);

begin

  i_io_ctrl : io_ctrl

  port map
  (
    clk_i => clk_i,
    reset_i => reset_i,
    dig0_i => dig0_i,
    dig1_i => dig1_i,
    dig2_i => dig2_i,
    dig3_i => dig3_i,
    led_i => led_i,
    sw_i => sw_i,
    pb_i => pb_i,
    ss_o => ss_o,
    led_o => led_o,
    ss_sel_o => ss_sel_o,
    swsync_o => swsync_o,
    pbsync_o => pbsync_o
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
    dig0_i <= "00000000";
    dig1_i <= "00000000";
    dig2_i <= "00000000";
    dig3_i <= "00000000";
    led_i <= "0000000000000000";
    sw_i <= "0000000000000000";
    pb_i <= "0000";

    wait for 1 ms;

    reset_i <= '0';

    wait for 1 ms;

-- some switches, some buttons - less than 3 100kHz ticks

    sw_i <= "0000000000000001";
    pb_i <= "0000";

    wait for 1 ms;

    sw_i <= "0000000000000010";
    pb_i <= "1001";

    wait for 1 ms;

    sw_i <= "0000111000000010";
    pb_i <= "0101";

    wait for 2 ms;

    sw_i <= "0000000001110010";
    pb_i <= "0011";
    
    wait for 2 ms;

    sw_i <= "0111100000000010";
    pb_i <= "1111";

    wait for 10 ms;

    sw_i <= "0000000011100010";
    pb_i <= "1101";

    wait for 10 ms;

    sw_i <= "0111100000000010";
    pb_i <= "0011";

    dig0_i <= "00000010";
    dig1_i <= "00100000";
    dig2_i <= "00001000";
    dig3_i <= "00010000";

    wait for 5 ms;

    dig0_i <= "00010000";
    dig1_i <= "01000000";
    dig2_i <= "00100000";
    dig3_i <= "00000010";

    wait for 2 ms;

    dig0_i <= "00100000";
    dig1_i <= "00000100";
    dig2_i <= "00100000";
    dig3_i <= "00000010";

    wait for 2 ms;

    dig0_i <= "00010000";
    dig1_i <= "01000000";
    dig2_i <= "00010000";
    dig3_i <= "00000100";

    wait for 2 ms;

    dig0_i <= "01000000";
    dig1_i <= "00000100";
    dig2_i <= "00100000";
    dig3_i <= "00000001";

    wait for 2 ms;

  end process run;

end sim;
