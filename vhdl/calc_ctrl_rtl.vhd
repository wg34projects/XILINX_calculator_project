--
-- FHTW - BEL3 - DSD - calculator project
--
--
-- Author:	Helmut Resch
--			el16b005
--			BEL3
--
-- File:	calc_ctrl_rtl.vhd
--
-- Version history:
--
-- v_0.1	13.11.2017	IO Ctrl + Testbench
-- v_0.2	15.11.2017	Calc Ctrl + Testbench
--
-- Design Unit:	Calculator Control Unit
--				Architecture
--
-- Description:	The Calculator Control unit is part of the calculator project.
--				The unit includes a FSM for the calculation itself and the 
--              decoder for the 7 segment displays.
--
--
-- below doxygen documentation blocks

--! @file calc_ctrl_rtl.vhd
--! @brief Calculator Control Unit Architecture

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

--! @brief Calclator Control Unit Architecture
--! @details The Calulator Control unit is part of the calculator project.

architecture rtl of calc_ctrl is

  type states is (enterOP1, enterOP2, enterTYP, calculate);
  signal presentstate_s : states;
  signal nextstate_s : states;
  signal buttonstate_s : std_logic;
  constant OP1start : std_logic_vector(7 downto 0) := "10011110";
  constant OP2start : std_logic_vector(7 downto 0) := "00100100";
  constant TYPstart : std_logic_vector(7 downto 0) := "11000100";
  constant SIGN : std_logic_vector(7 downto 0) := "11111101";
  constant OVERLOW : std_logic_vector(7 downto 0) := "11000101";
  constant Echar : std_logic_vector(7 downto 0) := "01100001";
  constant Rchar : std_logic_vector(7 downto 0) := "11111010";

begin

  p_calcFSM_sequential : process (clk_i, reset_i)

  begin

    if reset_i = '1' then

      presentstate_s <= enterOP1;
      
    elsif clk_i'event and clk_i = '1' then

      presentstate_s <= nextstate_s;

    end if;

  end process p_calcFSM_sequential;

  p_calcFSM_combinatorial : process (presentstate_s, pbsync_i, swsync_i)

  begin

    case presentstate_s is

      when enterOP1 =>

        dig0_o <= (others => '0');
        dig1_o <= (others => '0');
        dig2_o <= (others => '0');
        led_o <= (others => '0');
        dig3_o <= (others => '0');
        op1_o <= (others => '0');
        op2_o <= (others => '0');
        optype_o <= (others => '0');
        start_o <= '0';
        dig3_o <= OP1start;
        buttonstate_s <= '0';
		
        if pbsync_i = "1000" then

          buttonstate_s <= '1';

        end if;

        if pbsync_i = "0000" and buttonstate_s = '1' then

          op1_o <= swsync_i(11 downto 0);
          buttonstate_s <= '0';
          nextstate_s <= enterOP2;

        else

          nextstate_s <= enterOP1;

        end if;

      when enterOP2 =>

        dig3_o <= OP2start;

        if pbsync_i = "1000" then

          buttonstate_s <= '1';

        end if;

        if pbsync_i = "0000" and buttonstate_s = '1' then

          op2_o <= swsync_i(11 downto 0);
          buttonstate_s <= '0';
          nextstate_s <= enterTYP;

        else

          nextstate_s <= enterOP2;

        end if;

      when enterTYP =>

        dig3_o <= TYPstart;

        if pbsync_i = "1000" then

          buttonstate_s <= '1';

        end if;

        if pbsync_i = "0000" and buttonstate_s = '1' then

          optype_o <= swsync_i(15 downto 12);
          buttonstate_s <= '0';
          nextstate_s <= calculate;
          start_o <= '1';

        else

          nextstate_s <= enterTYP;

        end if;

      when calculate =>

        dig3_o <= OVERLOW;

        if finished_i = '1' then

          led_o <= "1000000000000000";

          if pbsync_i = "1000" then

            buttonstate_s <= '1';

          end if;

          if pbsync_i = "0000" and buttonstate_s = '1' then

            buttonstate_s <= '0';
            nextstate_s <= enterOP1;

          else

            nextstate_s <= calculate;

          end if;

        end if;
   
      when others =>

        nextstate_s <= enterOP1;

    end case;

  end process p_calcFSM_combinatorial;

end rtl;
