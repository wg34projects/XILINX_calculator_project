--------------------------------------------------------------------------------
-- FHTW - BEL3 - DSD - calculator project
--
-- Author:	Helmut Resch
--			el16b005 BEL3 no. 15 in attendance list
--          User interface Type "A", square root, logdual, or, ror
--
-- File:	io_ctrl_rtl.vhd
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
-- Design Unit:	IO Control Unit
--				Architecture RTL
--
-- Description:	The IO Control unit is part of the calculator project.
--				It manages the interface of the 7-segment displays,
--				the LEDs, the push buttons and the switches of the
--				Digilent Basys3 FPGA board.
--------------------------------------------------------------------------------

--! @file io_ctrl_rtl.vhd
--! @brief IO Control Unit Architecture RTL

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

--! @brief IO Control Unit Architecture RTL
--! @details The IO Control unit is part of the calculator project.

architecture rtl of io_ctrl is

  constant C_ENCOUNTVAL : std_logic_vector(16 downto 0) := "11000011010100000";
  signal s_enctr : std_logic_vector(16 downto 0);
  signal s_1khzen : std_logic;
  signal swsync : std_logic_vector(15 downto 0);
  signal pbsync : std_logic_vector(3 downto 0);
  signal s_ss_sel : std_logic_vector(3 downto 0);
  signal s_ss : std_logic_vector(7 downto 0);
  signal s_muxcnt : std_logic_vector(1 downto 0); -- internal signal for MUX 7-segment displays
  signal s_debcnt : std_logic_vector(1 downto 0); -- internal signal for debounce
  signal s_button : std_logic;  -- internal signal to trigger button or switch change

begin

--! @brief IO Control Unit Architecture RTL
--! @details Process for 1kHz signal

  p_slowen: process (clk_i, reset_i)

  begin

    if reset_i = '1' then

      s_1khzen <= '0';
      s_debcnt <= "00";
      s_enctr <= (others => '0');
      s_muxcnt <= "00";

    elsif clk_i'event and clk_i = '1' then

      s_enctr <= unsigned(s_enctr) + 1; -- increase counter

      if s_enctr = C_ENCOUNTVAL then

        s_1khzen <= not (s_1khzen); -- when count reaches 100000 toggle 1kHz signal
        s_enctr <= (others => '0'); -- and reset counter

        if s_1khzen = '1' then

          s_muxcnt <= unsigned (s_muxcnt) + 1; -- increase the MUX counter

          if s_button = '1' then

            s_debcnt <= unsigned(s_debcnt) + 1; -- start 1kHz synchron counter when button or switch change
 
          end if;

          if s_muxcnt = "11" then -- when all 4 7-segment displays were MUXED start from beginning

            s_muxcnt <= "00";

          end if;

          if s_debcnt = "11" then -- reset debounce count after 3 1kHz signals

            s_debcnt <= "00";

         end if;

        end if;

      end if;

    end if;

  end process p_slowen;

--! @brief IO Control Unit Architecture RTL
--! @details Process for button debounce

  p_debounce: process (clk_i, reset_i)

  begin

    if reset_i = '1' then

      swsync <= (others => '0');
      pbsync <= (others => '0');
      s_button <= '0';

    elsif clk_i'event and clk_i = '1' then

      if s_1khzen = '1' then

        if swsync /= sw_i or pbsync /= pb_i then -- check if button or switch changed

          s_button <= '1'; -- set trigger signal for debounce

          if s_debcnt = "11" then -- accept button and switch status after 3 1kHz signals

             swsync <= sw_i;
             pbsync <= pb_i;
             s_button <= '0';

          else -- or continue

            pbsync <= (others => '0'); -- push buttons are always 1-0-1-0, switches keep value

           end if;

        end if;              

      end if;

    end if;

  end process p_debounce;

  swsync_o <= swsync;
  pbsync_o <= pbsync;

--! @brief IO Control Unit Architecture RTL
--! @details Process to control 7 segment displays

  p_display_ctrl: process (clk_i, reset_i)

  begin

    if reset_i = '1' then

      s_ss_sel <= (others => '1');
      s_ss <= (others => '0');
      
    elsif clk_i'event and clk_i = '1' then

      if s_1khzen = '1' then -- MUX the 4 displays synchron to 1kHz signal, common anode is low active

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
  led_o <= led_i; -- necessary to shift input to output

end rtl;
