--
-- FHTW - BEL3 - DSD - calculator project
--
--
-- Author:	Helmut Resch
--			el16b005
--			BEL3
--
-- File:	io_ctrl_.vhd
--
-- Version history:
--
-- v_0.1	13.11.2017	IO Ctrl + Testbench
-- v_0.2	15.11.2017	Calc Ctrl + Testbench
--
-- Design Unit:	IO Control Unit
--				Entity
--
-- Description:	The IO Control unit is part of the calculator project.
--				It manages the interface to the 7-segment displays,
--				the LEDs, the push buttons and the switches of the
--				Digilent Basys3 FPGA board.
--
--
-- below doxygen documentation blocks

--! @file io_ctrl_.vhd
--! @brief IO Control Unit Entity

library IEEE;
use IEEE.std_logic_1164.all;

--! @brief IO Control Unit Entity
--! @details The IO Control unit is part of the calculator project.

entity io_ctrl is

  port
  (
    clk_i : in std_logic;
    reset_i : in std_logic;
    dig0_i : in std_logic_vector(7 downto 0); --!binary representation for digits segement 0
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

end io_ctrl;
