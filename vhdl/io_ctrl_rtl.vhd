--
-- FHTW - BEL3 - DSD - calculator project
--
--
-- Author:	Helmut Resch
--			el16b005
--			BEL3
--
-- File:	io_ctrl_rtl.vhd
--
-- Version history:
--
-- v_0.1	13.11.2017	IO Ctrl + Testbench
-- v_0.2	15.11.2017	Calc Ctrl + Testbench
--
-- Design Unit:	IO Control Unit
--				Architecture
--
-- Description:	The IO Control unit is part of the calculator project.
--				It manages the interface to the 7-segment displays,
--				the LEDs, the push buttons and the switches of the
--				Digilent Basys3 FPGA board.
--
--
-- below doxygen documentation blocks

--! @file io_ctrl_rtl.vhd
--! @brief IO Control Unit Architecture

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

--! @brief IO Control Unit Architecture
--! @details The IO Control unit is part of the calculator project.

architecture rtl of io_ctrl is

  constant C_ENCOUNTVAL : std_logic_vector(16 downto 0) := "11000011010100000";

  signal s_enctr : std_logic_vector(16 downto 0);
  signal s_1khzen : std_logic;
  signal swsync : std_logic_vector(15 downto 0);
  signal pbsync : std_logic_vector(3 downto 0);
  signal s_ss_sel : std_logic_vector(3 downto 0);
  signal s_ss : std_logic_vector(7 downto 0);
  signal s_muxcnt : std_logic_vector(1 downto 0);
  signal s_debcnt : std_logic_vector(3 downto 0);
  signal s_button : std_logic;

begin

--! @brief IO Control Unit Architecture
--! @details Process for 1kHz signal.

  p_slowen: process (clk_i, reset_i)

  begin

    if reset_i = '1' then

      s_1khzen <= '0';
      s_debcnt <= "0000";
      s_enctr <= (others => '0');
      s_muxcnt <= "00";

    elsif clk_i'event and clk_i = '1' then

      s_enctr <= unsigned(s_enctr) + 1;

      if s_enctr = C_ENCOUNTVAL then

        s_1khzen <= not (s_1khzen);
        s_enctr <= (others => '0');

        if s_1khzen = '1' then

          s_muxcnt <= unsigned (s_muxcnt) + 1;

          if s_button = '1' then

            s_debcnt <= unsigned(s_debcnt) + 1;
 
          end if;

          if s_muxcnt = "11" then

            s_muxcnt <= "00";

          end if;

          if s_debcnt = "0011" then

            s_debcnt <= "0000";

         end if;

        end if;

      end if;

    end if;

  end process p_slowen;

--! @brief IO Control Unit Architecture
--! @details Process for button debounce.

  p_debounce: process (clk_i, reset_i)

  begin

    if reset_i = '1' then

      swsync <= (others => '0');
      pbsync <= (others => '0');
      s_button <= '0';

    elsif clk_i'event and clk_i = '1' then

      if s_1khzen = '1' then

        if swsync /= sw_i or pbsync /= pb_i then

          s_button <= '1';

          if s_debcnt = "0011" then

             swsync <= sw_i;
             pbsync <= pb_i;
             s_button <= '0';

           end if;

        end if;              

      end if;

    end if;

  end process p_debounce;

  swsync_o <= swsync;
  pbsync_o <= pbsync;

--! @brief IO Control Unit Architecture
--! @details Process to control 7 segment displays.

  p_display_ctrl: process (clk_i, reset_i)

  begin

    if reset_i = '1' then

      s_ss_sel <= (others => '1');
      s_ss <= (others => '0');
      
    elsif clk_i'event and clk_i = '1' then

      if s_1khzen = '1' then

        if s_muxcnt = "00" then

          s_ss_sel <= "1110";
          s_ss <= dig0_i;

        elsif s_muxcnt = "01" then

          s_ss_sel <= "1101";
          s_ss <= dig1_i;

        elsif s_muxcnt = "10" then

          s_ss_sel <= "1011";
          s_ss <= dig2_i;

        else

          s_ss_sel <= "0111";
          s_ss <= dig3_i;
          
        end if;

      end if;

    end if;

  end process p_display_ctrl;

  ss_o <= s_ss;
  ss_sel_o <= s_ss_sel;
  led_o <= led_i;

end rtl;
