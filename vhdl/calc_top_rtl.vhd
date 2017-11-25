--------------------------------------------------------------------------------
-- FHTW - BEL3 - DSD - calculator project
--
-- Author:	Helmut Resch
--			el16b005 BEL3 no. 15 in attendance list
--          User interface Type "A", square root, logdual, or, ror
--
-- File:	calc_top_rtl.vhd
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
--				Architecture RTL-STRUC
--
-- Description:	The IO Control unit is part of the calculator project.
--              The Calculator Top Design links the io_ctrl, calc_ctrl and ALU
--              with internal signals and portmapping
--------------------------------------------------------------------------------

--! @file calc_top_rtl.vhd
--! @brief Calculator Top Architecture RTL-STRUC

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

--! @brief Calculator Top Architecture RTL-STRUC
--! @details The Calulator Control unit is part of the calculator project.

architecture struc of calc_top is

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
    ss_sel_o : out std_logic_vector(3 downto 0);
    led_o : out std_logic_vector(15 downto 0);
    swsync_o : out std_logic_vector(15 downto 0);
    pbsync_o : out std_logic_vector(3 downto 0)
  );

end component;

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


signal dig0 : std_logic_vector(7 downto 0);
signal dig1 : std_logic_vector(7 downto 0);
signal dig2 : std_logic_vector(7 downto 0);
signal dig3 : std_logic_vector(7 downto 0);
signal led : std_logic_vector(15 downto 0);
signal swsync : std_logic_vector(15 downto 0);
signal pbsync : std_logic_vector(3 downto 0);
signal finished : std_logic;
signal result : std_logic_vector(15 downto 0);
signal sign : std_logic;
signal overflow : std_logic;
signal errors : std_logic;
signal op1 : std_logic_vector(11 downto 0);
signal op2 : std_logic_vector(11 downto 0);
signal optype : std_logic_vector(3 downto 0);
signal start : std_logic;

begin

  i_io_ctrl : io_ctrl

  port map
  (
    clk_i => clk_i,
    reset_i => reset_i,
    dig0_i => dig0,
    dig1_i => dig1,
    dig2_i => dig2,
    dig3_i => dig3,
    led_i => led,
    sw_i => sw_i,
    pb_i => pb_i,
    ss_o => ss_o,
    led_o => led_o,
    ss_sel_o => ss_sel_o,
    swsync_o => swsync,
    pbsync_o => pbsync
  );

  i_calc_ctrl : calc_ctrl

  port map
  (
    clk_i => clk_i,
    reset_i => reset_i,
    swsync_i => swsync,
    pbsync_i => pbsync,
    finished_i => finished,
    result_i => result,
    sign_i => sign,
    overflow_i => overflow,
    error_i => errors,
    dig0_o => dig0,
    dig1_o => dig1,
    dig2_o => dig2,
    dig3_o => dig3,
    led_o => led,
    op1_o => op1,
    op2_o => op2,
    optype_o => optype,
    start_o => start
  );

  i_alu : alu

  port map
  (
    clk_i => clk_i,
    reset_i => reset_i,
    finished_o => finished,
    result_o => result,
    sign_o => sign,
    overflow_o => overflow,
    error_o => errors,
    op1_i => op1,
    op2_i => op2,
    optype_i => optype,
    start_i => start
  );

end struc;
