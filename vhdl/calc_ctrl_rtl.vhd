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

  type states is (enterOP1, enterOP2, enterTYP, calculate, displayResult);
  signal state_s : states;
  signal buttonstate_s : std_logic_vector(1 downto 0);
  signal readystate_s : std_logic;
  constant OP1start : std_logic_vector(7 downto 0) := "10011110";
  constant OP2start : std_logic_vector(7 downto 0) := "00100100";
  constant TYPstart : std_logic_vector(7 downto 0) := "11000100";
  constant SIGN : std_logic_vector(7 downto 0) := "11111101";
  constant OVERLOW : std_logic_vector(7 downto 0) := "11000101";
  constant Echar : std_logic_vector(7 downto 0) := "01100001";
  constant rchar : std_logic_vector(7 downto 0) := "11110101";
  constant NULLchar : std_logic_vector(7 downto 0) := "11111111";
  constant Schar : std_logic_vector(7 downto 0) := "01001001";
  constant qchar : std_logic_vector(7 downto 0) := "00011001";
  constant Lchar : std_logic_vector(7 downto 0) := "11100011";
  constant ochar : std_logic_vector(7 downto 0) := "11000101";
  constant bchar : std_logic_vector(7 downto 0) := "11000001";

  function makeBINtoHEX (binnumberConvert : std_logic_vector(3 downto 0))

    return std_logic_vector is

  variable hexnumberResult : std_logic_vector(7 downto 0);

  begin

    case binnumberConvert is

      when "0000" => hexnumberResult := "00000011"; -- 0
      when "0001" => hexnumberResult := "10011111"; -- 1
      when "0010" => hexnumberResult := "00100101"; -- 2
      when "0011" => hexnumberResult := "00001101"; -- 3
      when "0100" => hexnumberResult := "10011001"; -- 4
      when "0101" => hexnumberResult := "01001001"; -- 5
      when "0110" => hexnumberResult := "11000001"; -- 6
      when "0111" => hexnumberResult := "00011111"; -- 7
      when "1000" => hexnumberResult := "00000001"; -- 8
      when "1001" => hexnumberResult := "00011001"; -- 9
      when "1010" => hexnumberResult := "00010001"; -- A
      when "1011" => hexnumberResult := "11000001"; -- b
      when "1100" => hexnumberResult := "11100101"; -- c
      when "1101" => hexnumberResult := "10000101"; -- d
      when "1110" => hexnumberResult := "01100001"; -- E
      when "1111" => hexnumberResult := "01110001"; -- f
      when others => hexnumberResult := "11111111"; -- no led on

    end case;

    return hexnumberResult;
  
  end;

  procedure decodeOperator (signal dig2_o : out std_logic_vector(7 downto 0);
                            signal dig1_o : out std_logic_vector(7 downto 0);
                            signal dig0_o : out std_logic_vector(7 downto 0);
                            signal swsync_i : in std_logic_vector(3 downto 0)) is
  begin

    case swsync_i is

      when "0101" => -- Sqr

        dig2_o <= Schar;
        dig1_o <= qchar;
        dig0_o <= rchar;

      when "0111" => -- Lb 

        dig2_o <= Lchar;
        dig1_o <= bchar;
        dig0_o <= NULLchar;

      when "1010" => -- or 

        dig2_o <= ochar;
        dig1_o <= rchar;
        dig0_o <= NULLchar;

      when "1101" => -- ror

        dig2_o <= rchar;
        dig1_o <= ochar;
        dig0_o <= rchar;

      when others => -- all 3 segments dark

        dig2_o <= NULLchar;
        dig1_o <= NULLchar;
        dig0_o <= NULLchar;

    end case;

  end decodeOperator;

begin

  p_calcFSM : process (clk_i, reset_i, pbsync_i, swsync_i, readystate_s, result_i, sign_i, overflow_i, error_i, buttonstate_s)

  begin

    if reset_i = '1' then

      state_s <= enterOP1;
      readystate_s <= '0';
      led_o <= "0000000000000000";
      dig0_o <= (others => '0');
      dig1_o <= (others => '0');
      dig2_o <= (others => '0');
      dig3_o <= (others => '0');
      op1_o <= (others => '0');
      op2_o <= (others => '0');
      optype_o <= (others => '0');
      start_o <= '0';
      buttonstate_s <= "00";
      
    elsif clk_i'event and clk_i = '1' then

        if finished_i = '1' and readystate_s = '0' then

          readystate_s <= '1';
          led_o <= "0000000000000001";

        elsif state_s = enterOP1 then

          readystate_s <= '0';
          led_o <= "0000000000000000";

        end if;

    case state_s is

      when enterOP1 =>

        led_o <= "0000000000000000";
        dig3_o <= OP1start;
        dig2_o <= makeBINtoHEX(swsync_i(11 downto 8));
        dig1_o <= makeBINtoHEX(swsync_i(7 downto 4));
        dig0_o <= makeBINtoHEX(swsync_i(3 downto 0));
		
        if pbsync_i = "1000" and buttonstate_s = "00" then

			buttonstate_s(1) <= buttonstate_s(0);
			buttonstate_s(0) <= '1';

        end if;

        if pbsync_i = "0000" and buttonstate_s = "01" then

			buttonstate_s(1) <= buttonstate_s(0);
			buttonstate_s(0) <= '1';

        end if;

        if buttonstate_s = "11" then

          op1_o <= swsync_i(11 downto 0);
          buttonstate_s <= "00";
          state_s <= enterOP2;

        else

          state_s <= enterOP1;

        end if;

      when enterOP2 =>

        led_o <= "0000000000000000";
        dig3_o <= OP2start;
        dig1_o <= makeBINtoHEX(swsync_i(11 downto 8));
        dig1_o <= makeBINtoHEX(swsync_i(7 downto 4));
        dig0_o <= makeBINtoHEX(swsync_i(3 downto 0));

        if pbsync_i = "1000" and buttonstate_s = "00" then

			buttonstate_s(1) <= buttonstate_s(0);
			buttonstate_s(0) <= '1';

        end if;

        if pbsync_i = "0000" and buttonstate_s = "01" then

			buttonstate_s(1) <= buttonstate_s(0);
			buttonstate_s(0) <= '1';

        end if;

        if buttonstate_s = "11" then

          op2_o <= swsync_i(11 downto 0);
          buttonstate_s <= "00";
          state_s <= enterTYP;

        else

          state_s <= enterOP2;

        end if;

      when enterTYP =>

        led_o <= "0000000000000000";
        dig3_o <= TYPstart;
        decodeOperator(dig2_o, dig1_o, dig0_o, swsync_i(15 downto 12));

        if pbsync_i = "1000" and buttonstate_s = "00" then

			buttonstate_s(1) <= buttonstate_s(0);
			buttonstate_s(0) <= '1';

        end if;

        if pbsync_i = "0000" and buttonstate_s = "01" then

			buttonstate_s(1) <= buttonstate_s(0);
			buttonstate_s(0) <= '1';

        end if;

        if buttonstate_s = "11" then

          optype_o <= swsync_i(15 downto 12);
          buttonstate_s <= "00";
          state_s <= calculate;
          start_o <= '1';

        else

          state_s <= enterTYP;

        end if;

      when calculate =>

        if readystate_s = '1' then

          state_s <= displayResult;

        else

          dig3_o <= NULLchar;
          dig2_o <= NULLchar;
          dig1_o <= NULLchar;
          dig0_o <= NULLchar;
          state_s <= calculate;

        end if;

      when displayResult =>

        if sign_i = '0' and overflow_i = '0' and error_i = '0' then

          dig3_o <= makeBINtoHEX(result_i(15 downto 12));
          dig2_o <= makeBINtoHEX(result_i(11 downto 8));
          dig1_o <= makeBINtoHEX(result_i(7 downto 4));
          dig0_o <= makeBINtoHEX(result_i(3 downto 0));

        elsif sign_i = '1' and overflow_i = '0' and error_i = '0' then

          dig3_o <= SIGN;
          dig2_o <= makeBINtoHEX(result_i(11 downto 8));
          dig1_o <= makeBINtoHEX(result_i(7 downto 4));
          dig0_o <= makeBINtoHEX(result_i(3 downto 0));

        elsif error_i = '0' and overflow_i = '1' then

          dig3_o <= ochar;
          dig2_o <= ochar;
          dig1_o <= ochar;
          dig0_o <= ochar;

        elsif error_i = '1' then

          dig3_o <= NULLchar;
          dig2_o <= Echar;
          dig1_o <= Rchar;
          dig0_o <= RChar;

        end if;

          if pbsync_i = "1000" and buttonstate_s = "00" then

			buttonstate_s(1) <= buttonstate_s(0);
			buttonstate_s(0) <= '1';

          end if;

          if pbsync_i = "0000" and buttonstate_s = "01" then

			buttonstate_s(1) <= buttonstate_s(0);
			buttonstate_s(0) <= '1';

          end if;

          if buttonstate_s = "11" then

            buttonstate_s <= "00";
            state_s <= enterOP1;
            readystate_s <= '0';
            led_o <= "0000000000000000";
            dig0_o <= (others => '0');
            dig1_o <= (others => '0');
            dig2_o <= (others => '0');
            dig3_o <= (others => '0');
            op1_o <= (others => '0');
            op2_o <= (others => '0');
            optype_o <= (others => '0');
            start_o <= '0';

          else

            state_s <= displayResult;

          end if;      
   
      when others =>

        state_s <= enterOP1;

    end case;

  end if;

  end process p_calcFSM;

end rtl;
