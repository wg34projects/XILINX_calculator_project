--------------------------------------------------------------------------------
-- FHTW - BEL3 - DSD - calculator project
--
-- Author:	Helmut Resch
--			el16b005 BEL3 no. 15 in attendance list
--          User interface Type "A", square root, logdual, or, ror
--
-- File:	calc_ctrl_rtl.vhd
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
-- Design Unit:	Calculator Control Unit
--				Architecture RTL
--
-- Description:	The Calculator Control unit is part of the calculator project.
--				It includes the FSM for enter OP1, OP2, OPERAND
--				and for CALCUALTION and DISPLAY RESULT
--				Digilent Basys3 FPGA board.
--------------------------------------------------------------------------------

--! @file calc_ctrl_rtl.vhd
--! @brief Calculator Control Unit Architecture RTL

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

--! @brief Calclator Control Unit Architecture RTL
--! @details The Calulator Control unit is part of the calculator project.

architecture rtl of calc_ctrl is

  type states is (enterOP1, enterOP2, enterTYP, calculate, displayResult);
  signal state_s : states;
  signal buttonstate_s : std_logic_vector(1 downto 0); -- shift register for button press 0-1-0
  signal readystate_s : std_logic; -- signal storing the finished signal
  constant C_OP1start : std_logic_vector(7 downto 0) := "10011110"; -- 1.
  constant C_OP2start : std_logic_vector(7 downto 0) := "00100100"; -- 2.
  constant C_TYPstart : std_logic_vector(7 downto 0) := "11000100"; -- o.
  constant C_SIGN : std_logic_vector(7 downto 0) := "11111101"; -- -
  constant C_Echar : std_logic_vector(7 downto 0) := "01100001"; -- e
  constant C_rchar : std_logic_vector(7 downto 0) := "11110101"; -- r
  constant C_NULLchar : std_logic_vector(7 downto 0) := "11111111"; -- no segment illuminated
  constant C_Schar : std_logic_vector(7 downto 0) := "01001001"; -- S
  constant C_Lchar : std_logic_vector(7 downto 0) := "11100011"; -- L
  constant C_ochar : std_logic_vector(7 downto 0) := "11000101"; -- o
  constant C_bchar : std_logic_vector(7 downto 0) := "11000001"; -- b

--! @brief Calclator Control Unit Architecture RTL
--! @details Function to convert binary representation of switches to hexadecimal output

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
      when "0110" => hexnumberResult := "01000001"; -- 6
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

--! @brief Calclator Control Unit Architecture RTL
--! @details Procedure to decode switch setting for operator

  procedure decodeOperator (signal dig2_o : out std_logic_vector(7 downto 0);
                            signal dig1_o : out std_logic_vector(7 downto 0);
                            signal dig0_o : out std_logic_vector(7 downto 0);
                            signal swsync_i : in std_logic_vector(3 downto 0)) is
  begin

    case swsync_i is

      when "0110" => -- Sro

        dig2_o <= C_Schar;
        dig1_o <= C_rchar;
        dig0_o <= C_ochar;

      when "0111" => -- Lb 

        dig2_o <= C_Lchar;
        dig1_o <= C_bchar;
        dig0_o <= C_NULLchar;

      when "1010" => -- or 

        dig2_o <= C_ochar;
        dig1_o <= C_rchar;
        dig0_o <= C_NULLchar;

      when "1101" => -- ror

        dig2_o <= C_rchar;
        dig1_o <= C_ochar;
        dig0_o <= C_rchar;

      when others => -- all 3 segments dark

        dig2_o <= C_NULLchar;
        dig1_o <= C_NULLchar;
        dig0_o <= C_NULLchar;

    end case;

  end decodeOperator;

begin

--! @brief Calclator Control Unit Architecture RTL
--! @details Process for FSM calculator - enterOP1, enterOP2, enterTyp, calculate, displayResult

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

        if finished_i = '1' then

          readystate_s <= '1'; -- store finished signal
          led_o <= "1000000000000000"; -- illuminate LED15 for result

        elsif state_s = enterOP1 then

          readystate_s <= '0'; -- reset stored finished signal

        end if;

    case state_s is

      when enterOP1 => -- enter first number

        led_o <= "0000000000000000";
        dig3_o <= C_OP1start; -- show 1. at leftmost 7-segment display
        dig2_o <= makeBINtoHEX(swsync_i(11 downto 8)); -- decode switch settings for the other 3 7-segment displays
        dig1_o <= makeBINtoHEX(swsync_i(7 downto 4));
        dig0_o <= makeBINtoHEX(swsync_i(3 downto 0));
		
        if pbsync_i = "1000" and buttonstate_s = "00" then -- shift register for button press 0-1

			buttonstate_s(1) <= buttonstate_s(0);
			buttonstate_s(0) <= '1';

        end if;

        if pbsync_i = "0000" and buttonstate_s = "01" then -- shift register for button release 1-0

			buttonstate_s(1) <= buttonstate_s(0);
			buttonstate_s(0) <= '1';

        end if;

        if buttonstate_s = "11" then  -- action after button 0-1-0, accept first number and go to next state

          op1_o <= swsync_i(11 downto 0);
          buttonstate_s <= "00";
          state_s <= enterOP2;

        else

          state_s <= enterOP1;

        end if;

      when enterOP2 => -- enter second number, shift register and bin-hex decoding equal as before

        led_o <= "0000000000000000";
        dig3_o <= C_OP2start; -- show 2. at leftmost 7-segment display
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

          op2_o <= swsync_i(11 downto 0);
          buttonstate_s <= "00";
          state_s <= enterTYP;

        else

          state_s <= enterOP2;

        end if;

      when enterTYP => -- enter operator, shift register equal as before

        led_o <= "0000000000000000";
        dig3_o <= C_TYPstart; -- show o. at leftmost 7-segment display
        decodeOperator(dig2_o, dig1_o, dig0_o, swsync_i(15 downto 12)); -- decode switch12-15 for operator type

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

      when calculate => -- start calculation and wait for result

        start_o <= '0'; -- send start signal to ALU

        if readystate_s = '1' then -- go to final state, readystate is the stored finished signal

          state_s <= displayResult;

        else

          dig3_o <= C_NULLchar; -- keep all segments dark during calculation
          dig2_o <= C_NULLchar;
          dig1_o <= C_NULLchar;
          dig0_o <= C_NULLchar;
          state_s <= calculate;

        end if;

      when displayResult => -- final state, display result, shift register and bin-hex decoding equal as before

        if sign_i = '0' and overflow_i = '0' and error_i = '0' then -- no error, no overflow, no sign

          dig3_o <= makeBINtoHEX(result_i(15 downto 12)); -- make hex number out of bin representation
          dig2_o <= makeBINtoHEX(result_i(11 downto 8));
          dig1_o <= makeBINtoHEX(result_i(7 downto 4));
          dig0_o <= makeBINtoHEX(result_i(3 downto 0));

        elsif sign_i = '1' and overflow_i = '0' and error_i = '0' then -- no error, no overflow, sign

          dig3_o <= C_SIGN; -- show -
          dig2_o <= makeBINtoHEX(result_i(11 downto 8)); -- make hex number out of bin representation
          dig1_o <= makeBINtoHEX(result_i(7 downto 4));
          dig0_o <= makeBINtoHEX(result_i(3 downto 0));

        elsif error_i = '0' and overflow_i = '1' then -- no error but overflow

          dig3_o <= C_ochar; -- o
          dig2_o <= C_ochar; -- o
          dig1_o <= C_ochar; -- o
          dig0_o <= C_ochar; -- o

        elsif error_i = '1' then -- error

          dig3_o <= C_NULLchar; -- leftmost display dark
          dig2_o <= C_Echar; -- E
          dig1_o <= C_rchar; -- r
          dig0_o <= C_rchar; -- r

        end if;

          if pbsync_i = "1000" and buttonstate_s = "00" then

			buttonstate_s(1) <= buttonstate_s(0);
			buttonstate_s(0) <= '1';

          end if;

          if pbsync_i = "0000" and buttonstate_s = "01" then

			buttonstate_s(1) <= buttonstate_s(0);
			buttonstate_s(0) <= '1';

          end if;

          if buttonstate_s = "11" then -- prepare for new calculation, reset values

            buttonstate_s <= "00";
            state_s <= enterOP1;
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
        readystate_s <= '0'; -- reset stored finished signal

    end case;

  end if;

  end process p_calcFSM;

end rtl;
