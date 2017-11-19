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

architecture rtl of alu is

  signal oddNumber_s : std_logic_vector(11 downto 0);
  signal workNumber1_s : std_logic_vector(11 downto 0);
  signal workNumber2_s : std_logic_vector(11 downto 0);
  signal sqrtCount_s : std_logic_vector(15 downto 0);
  signal finished_s : std_logic;
  constant pattern11 : std_logic_vector(11 downto 0) := "100000000000";
  constant pattern10 : std_logic_vector(11 downto 0) := "010000000000";
  constant pattern09 : std_logic_vector(11 downto 0) := "001000000000";
  constant pattern08 : std_logic_vector(11 downto 0) := "000100000000";
  constant pattern07 : std_logic_vector(11 downto 0) := "000010000000";
  constant pattern06 : std_logic_vector(11 downto 0) := "000001000000";
  constant pattern05 : std_logic_vector(11 downto 0) := "000000100000";
  constant pattern04 : std_logic_vector(11 downto 0) := "000000010000";
  constant pattern03 : std_logic_vector(11 downto 0) := "000000001000";
  constant pattern02 : std_logic_vector(11 downto 0) := "000000000100";
  constant pattern01 : std_logic_vector(11 downto 0) := "000000000010";
  constant pattern00 : std_logic_vector(11 downto 0) := "000000000001";


begin

  calculate : process (clk_i, reset_i, start_i, finished_s)

  variable logdual11_v : std_logic_vector(11 downto 0);
  variable logdual10_v : std_logic_vector(11 downto 0);
  variable logdual09_v : std_logic_vector(11 downto 0);
  variable logdual08_v : std_logic_vector(11 downto 0);
  variable logdual07_v : std_logic_vector(11 downto 0);
  variable logdual06_v : std_logic_vector(11 downto 0);
  variable logdual05_v : std_logic_vector(11 downto 0);
  variable logdual04_v : std_logic_vector(11 downto 0);
  variable logdual03_v : std_logic_vector(11 downto 0);
  variable logdual02_v : std_logic_vector(11 downto 0);
  variable logdual01_v : std_logic_vector(11 downto 0);
  variable logdual00_v : std_logic_vector(11 downto 0);

  begin

    if reset_i = '1' then

      oddNumber_s <= "000000000001";
      workNumber1_s <= (others => '0');
      workNumber2_s <= (others => '0');
      logdual11_v := (others => '0');
      logdual10_v := (others => '0');
      logdual09_v := (others => '0');
      logdual08_v := (others => '0');
      logdual07_v := (others => '0');
      logdual06_v := (others => '0');
      logdual05_v := (others => '0');
      logdual04_v := (others => '0');
      logdual03_v := (others => '0');
      logdual02_v := (others => '0');
      logdual01_v := (others => '0');
      logdual00_v := (others => '0');
      sqrtCount_s <= (others => '0');
      result_o <= (others => '0');
      finished_s <= '0';
      error_o <= '0';
      overflow_o <= '0';
      sign_o <= '0';
   
    elsif clk_i'event and clk_i = '1' then

      workNumber1_s <= op1_i;
      workNumber2_s <= op2_i;

      if finished_s = '1' and start_i = '0' then

        oddNumber_s <= "000000000001";
        sqrtCount_s <= (others => '0');
        result_o <= (others => '0');
        finished_s <= '0';

      end if;

      if start_i = '1' and finished_s = '0' then

        case optype_i is

          when "0101" =>

            sqrtCount_s <= unsigned (sqrtCount_s) + 1;
            workNumber1_s <= signed (workNumber1_s) - signed (oddNumber_s);

            if workNumber1_s(11) = '1' then
 
              result_o <= unsigned (sqrtCount_s) - 1;
              finished_s <= '1';
              error_o <= '0';
              overflow_o <= '0';
              sign_o <= '0';
              sqrtCount_s <= (others => '0');
              workNumber1_s <= (others => '0');
              oddNumber_s <= (others => '0');

            else

              oddNumber_s <= unsigned (oddNumber_s) + 2;

            end if;
            

          when "0111" =>
  
            logdual11_v := workNumber1_s and pattern11;
            logdual10_v := workNumber1_s and pattern10;
            logdual09_v := workNumber1_s and pattern09;
            logdual08_v := workNumber1_s and pattern08;
            logdual07_v := workNumber1_s and pattern07;
            logdual06_v := workNumber1_s and pattern06;
            logdual05_v := workNumber1_s and pattern05;
            logdual04_v := workNumber1_s and pattern04;
            logdual03_v := workNumber1_s and pattern03;
            logdual02_v := workNumber1_s and pattern02;
            logdual01_v := workNumber1_s and pattern01;
            logdual00_v := workNumber1_s and pattern00;

            if logdual11_v /= "000000000000" then

              result_o <= "0000000000001011";

            elsif logdual10_v /= "000000000000" then

              result_o <= "0000000000001010";
        
            elsif logdual09_v /= "000000000000" then

              result_o <= "0000000000001001";


            elsif logdual08_v /= "000000000000" then

              result_o <= "0000000000001000";


            elsif logdual07_v /= "000000000000" then

              result_o <= "0000000000000111";


            elsif logdual06_v /= "000000000000" then

              result_o <= "0000000000000110";


            elsif logdual05_v /= "000000000000" then

              result_o <= "0000000000000101";


            elsif logdual04_v /= "000000000000" then

              result_o <= "0000000000000100";


            elsif logdual03_v /= "000000000000" then

              result_o <= "0000000000000011";


            elsif logdual02_v /= "000000000000" then

              result_o <= "0000000000000010";


            elsif logdual01_v /= "000000000000" then

              result_o <= "0000000000000001";


            elsif logdual00_v /= "000000000000" then

              result_o <= "0000000000000000";

            else
 
              result_o <= "0000000000000000";

            end if;

            finished_s <= '1';
            error_o <= '0';
            overflow_o <= '0';
            sign_o <= '0';

          when "1010" =>

            result_o(11 downto 0) <= workNumber1_s or workNumber2_s;
            finished_s <= '1';
            error_o <= '0';
            overflow_o <= '0';
            sign_o <= '0';

          when "1101" =>

            result_o(11) <= workNumber1_s(0);
            result_o(10) <= workNumber1_s(11);
            result_o(9) <= workNumber1_s(10);
            result_o(8) <= workNumber1_s(9);
            result_o(7) <= workNumber1_s(8);
            result_o(6) <= workNumber1_s(7);
            result_o(5) <= workNumber1_s(6);
            result_o(4) <= workNumber1_s(5);
            result_o(3) <= workNumber1_s(4);
            result_o(2) <= workNumber1_s(3);
            result_o(1) <= workNumber1_s(2);
            result_o(0) <= workNumber1_s(1);
            finished_s <= '1';
            error_o <= '0';
            overflow_o <= '0';
            sign_o <= '0';

          when others =>

            result_o <= (others => '1');
            finished_s <= '1';
            error_o <= '1';
            overflow_o <= '0';
            sign_o <= '0';

        end case;

     end if;

    end if;

  finished_o <= finished_s;

  end process calculate;
 
end rtl;
