--------------------------------------------------------------------------------
-- FHTW - BEL3 - DSD - calculator project
--
-- Author:	Helmut Resch
--			el16b005 BEL3 no. 15 in attendance list
--          User interface Type "A", square root, logdual, or, ror
--
-- File:	alu_rtl.vhd
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
-- Design Unit:	ALU
--				Architecture RTL
--
-- Description:	The ALU unit is part of the calculator project.
--              The ALU provides all necessary calculations and handling of
--              error, overflow, sign, finished and result
--------------------------------------------------------------------------------

--! @file alu_rtl.vhd
--! @brief ALU Architecture RTL

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

--! @brief ALU Architecture RTL
--! @details The ALU is part of the calculator project.

architecture rtl of alu is

  signal oddNumber_s : std_logic_vector(15 downto 0); -- odd number counter for squareroot algorithm
  signal workNumber1_s : std_logic_vector(15 downto 0); -- signal for store 12bit operand1 in 16bit workNumber1
  signal workNumber2_s : std_logic_vector(15 downto 0); -- signal for store 12bit operand2 in 16bit workNumber2
  signal cntval : std_logic_vector(15 downto 0); -- counter for squareroot algorithm
  signal finished_s : std_logic; -- internal finished signal
  signal run_s : std_logic; -- internal run signal to store start signal
  constant C_PATTERN11 : std_logic_vector(15 downto 0) := "0000100000000000"; -- bit patterns for logdual
  constant C_PATTERN10 : std_logic_vector(15 downto 0) := "0000010000000000";
  constant C_PATTERN09 : std_logic_vector(15 downto 0) := "0000001000000000";
  constant C_PATTERN08 : std_logic_vector(15 downto 0) := "0000000100000000";
  constant C_PATTERN07 : std_logic_vector(15 downto 0) := "0000000010000000";
  constant C_PATTERN06 : std_logic_vector(15 downto 0) := "0000000001000000";
  constant C_PATTERN05 : std_logic_vector(15 downto 0) := "0000000000100000";
  constant C_PATTERN04 : std_logic_vector(15 downto 0) := "0000000000010000";
  constant C_PATTERN03 : std_logic_vector(15 downto 0) := "0000000000001000";
  constant C_PATTERN02 : std_logic_vector(15 downto 0) := "0000000000000100";
  constant C_PATTERN01 : std_logic_vector(15 downto 0) := "0000000000000010";
  constant C_PATTERN00 : std_logic_vector(15 downto 0) := "0000000000000001";

begin

--! @brief ALU Architecture RTL
--! @details main calculate process including combinatorial logic for operation type

  calculate : process (clk_i, reset_i, start_i, finished_s, run_s, op1_i, op2_i, optype_i)

  variable logdual11_v : std_logic_vector(15 downto 0); -- variables to store result of bit test for logdual
  variable logdual10_v : std_logic_vector(15 downto 0);
  variable logdual09_v : std_logic_vector(15 downto 0);
  variable logdual08_v : std_logic_vector(15 downto 0);
  variable logdual07_v : std_logic_vector(15 downto 0);
  variable logdual06_v : std_logic_vector(15 downto 0);
  variable logdual05_v : std_logic_vector(15 downto 0);
  variable logdual04_v : std_logic_vector(15 downto 0);
  variable logdual03_v : std_logic_vector(15 downto 0);
  variable logdual02_v : std_logic_vector(15 downto 0);
  variable logdual01_v : std_logic_vector(15 downto 0);
  variable logdual00_v : std_logic_vector(15 downto 0);

  begin

    if reset_i = '1' then

      oddNumber_s <= "0000000000000001";  -- first odd number = 1
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
      cntval <= (others => '0');
      result_o <= (others => '0');
      finished_s <= '0';
      error_o <= '0';
      overflow_o <= '0';
      sign_o <= '0';
      run_s <= '0';
   
    elsif clk_i'event and clk_i = '1' then

      workNumber1_s(11 downto 0) <= op1_i;  -- make 16bit from 12bit operand1
      workNumber2_s(11 downto 0) <= op2_i;  -- make 16bit from 12bit operand2

      if finished_s = '1' and run_s = '0' then  -- after finished calculation reset
  
        oddNumber_s <= "0000000000000001";
        cntval <= (others => '0');
        finished_s <= '0';       

      end if;

      if start_i = '1' then -- store start signal from calculator control

        run_s <= '1';

      end if;

      if run_s = '1' then -- if start resp. run the calculation can start

        case optype_i is -- combinatorial logic to select type of calculation

          when "0110" => -- squareroot

            cntval <= unsigned (cntval) + 1;  -- increase counter for sro algorithm
            workNumber1_s <= unsigned (workNumber1_s) - unsigned (oddNumber_s);  -- subtract odd number

            if workNumber1_s(15) = '1' then -- number is getting negative when MSB changes to 1 for unsigned number
 
              result_o <= unsigned (cntval) - 1;  -- correct counter after MSB changed to 1
              finished_s <= '1';  -- send finished signal
              error_o <= '0';  -- no error
              overflow_o <= '0';  -- no overflow
              sign_o <= '0';  -- no sign
              cntval <= (others => '0'); -- prepare for next calculation
              workNumber1_s <= (others => '0');
              oddNumber_s <= (others => '0');
              run_s <= '0'; -- reset run signal

            else

              oddNumber_s <= unsigned (oddNumber_s) + 2;

            end if;
            
          when "0111" => -- logdual
  
            logdual11_v := workNumber1_s and C_PATTERN11; -- test all 12 bit for 1, zero flag = inverted bit of the position
            logdual10_v := workNumber1_s and C_PATTERN10;
            logdual09_v := workNumber1_s and C_PATTERN09;
            logdual08_v := workNumber1_s and C_PATTERN08;
            logdual07_v := workNumber1_s and C_PATTERN07;
            logdual06_v := workNumber1_s and C_PATTERN06;
            logdual05_v := workNumber1_s and C_PATTERN05;
            logdual04_v := workNumber1_s and C_PATTERN04;
            logdual03_v := workNumber1_s and C_PATTERN03;
            logdual02_v := workNumber1_s and C_PATTERN02;
            logdual01_v := workNumber1_s and C_PATTERN01;
            logdual00_v := workNumber1_s and C_PATTERN00;

            if logdual11_v /= "0000000000000000" then -- check zero flag from MSB to LSB

              result_o <= "0000000000001011";
              error_o <= '0';

            elsif logdual10_v /= "0000000000000000" then

              result_o <= "0000000000001010";
              error_o <= '0';
        
            elsif logdual09_v /= "0000000000000000" then

              result_o <= "0000000000001001";
              error_o <= '0';

            elsif logdual08_v /= "0000000000000000" then

              result_o <= "0000000000001000";
              error_o <= '0';

            elsif logdual07_v /= "0000000000000000" then

              result_o <= "0000000000000111";
              error_o <= '0';

            elsif logdual06_v /= "0000000000000000" then

              result_o <= "0000000000000110";
              error_o <= '0';

            elsif logdual05_v /= "0000000000000000" then

              result_o <= "0000000000000101";
              error_o <= '0';

            elsif logdual04_v /= "0000000000000000" then

              result_o <= "0000000000000100";
              error_o <= '0';

            elsif logdual03_v /= "0000000000000000" then

              result_o <= "0000000000000011";
              error_o <= '0';

            elsif logdual02_v /= "0000000000000000" then

              result_o <= "0000000000000010";
              error_o <= '0';

            elsif logdual01_v /= "0000000000000000" then

              result_o <= "0000000000000001";
              error_o <= '0';

            elsif logdual00_v /= "0000000000000000" then

              result_o <= "0000000000000000";
              error_o <= '0';

            else -- logarithm of 0 is not defined = error

              result_o <= (others => '0');
              error_o <= '1';

            end if;

            finished_s <= '1'; -- send finished pulse
            overflow_o <= '0'; -- no overflow
            sign_o <= '0'; -- no sing
            run_s <= '0'; -- reset run signal

          when "1010" => -- or

            result_o(11 downto 0) <= workNumber1_s(11 downto 0) or workNumber2_s(11 downto 0); -- or of 2 12bit numbers
            result_o(15 downto 12) <= "0000"; -- complete to 16bit output
            finished_s <= '1'; -- send finished pulse
            error_o <= '0'; -- no error 
            overflow_o <= '0'; -- no overflow
            sign_o <= '0'; -- no sign
            run_s <= '0'; -- reset run signal

          when "1101" => -- ror

            result_o(11) <= workNumber1_s(0); -- rotate right of 12bit number
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
            result_o(15 downto 12) <= "0000"; -- complete to 16bit output
            finished_s <= '1'; -- send finished pulse
            error_o <= '0'; -- no error
            overflow_o <= '0'; -- no overflow
            sign_o <= '0'; -- no sign
            run_s <= '0'; -- reset run signal

          when others =>

            result_o <= (others => '0'); -- no operation type given = error
            finished_s <= '1'; -- send finished pulse
            error_o <= '1'; -- error
            overflow_o <= '0'; -- no overflow
            sign_o <= '0'; -- no sign

        end case;

     end if;

    end if;

  finished_o <= finished_s; -- internal signal to output finished

  end process calculate;
 
end rtl;
