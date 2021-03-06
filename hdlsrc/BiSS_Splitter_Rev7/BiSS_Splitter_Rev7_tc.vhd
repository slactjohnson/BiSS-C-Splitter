-- -------------------------------------------------------------
-- 
-- File Name: hdlsrc\BiSS_Splitter_Rev7\BiSS_Splitter_Rev7_tc.vhd
-- Created: 2020-08-28 16:31:32
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: BiSS_Splitter_Rev7_tc
-- Source Path: BiSS_Splitter_Rev7_tc
-- Hierarchy Level: 1
-- 
-- Master clock enable input: clk_enable
-- 
-- enb         : identical to clk_enable
-- enb_1_1_1   : identical to clk_enable
-- enb_1_2_0   : 2x slower than clk with last phase
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY BiSS_Splitter_Rev7_tc IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        enb                               :   OUT   std_logic;
        enb_1_1_1                         :   OUT   std_logic;
        enb_1_2_0                         :   OUT   std_logic
        );
END BiSS_Splitter_Rev7_tc;


ARCHITECTURE rtl OF BiSS_Splitter_Rev7_tc IS

  -- Signals
  SIGNAL count2                           : std_logic;
  SIGNAL phase_all                        : std_logic;
  SIGNAL phase_0                          : std_logic;
  SIGNAL phase_0_tmp                      : std_logic;

BEGIN
  Counter2 : PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset = '1' THEN
        count2 <= '1';
      ELSIF clk_enable = '1' THEN
          count2 <= NOT count2;
      END IF;
    END IF; 
  END PROCESS Counter2;

  phase_all <= '1' WHEN clk_enable = '1' ELSE '0';

  temp_process1 : PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset = '1' THEN
        phase_0 <= '0';
      ELSIF clk_enable = '1' THEN
        phase_0 <= phase_0_tmp;
      END IF;
    END IF; 
  END PROCESS temp_process1;

  phase_0_tmp <= '1' WHEN count2 = '1' AND clk_enable = '1' ELSE '0';

  enb <=  phase_all AND clk_enable;

  enb_1_1_1 <=  phase_all AND clk_enable;

  enb_1_2_0 <=  phase_0 AND clk_enable;


END rtl;

