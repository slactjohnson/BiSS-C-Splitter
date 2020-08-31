-- -------------------------------------------------------------
-- 
-- File Name: hdlsrc\BiSS_Splitter_Rev7\BiSS_Splitter_Rev7.vhd
-- Created: 2020-08-28 16:31:32
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 1e-05
-- Target subsystem base rate: 1e-05
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        1e-05
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- Encoder_MA                    ce_out        1e-05
-- DAQ_Out                       ce_out        1e-05
-- Motor_SLO                     ce_out        1e-05
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: BiSS_Splitter_Rev7
-- Source Path: BiSS_Splitter_Rev7
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY BiSS_Splitter_Rev7 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        Encoder_SLO                       :   IN    std_logic;
        DAQ_Trig                          :   IN    std_logic;
        Motor_MA                          :   IN    std_logic;
        ce_out                            :   OUT   std_logic;
        Encoder_MA                        :   OUT   std_logic;
        DAQ_Out                           :   OUT   std_logic;
        Motor_SLO                         :   OUT   std_logic
        );
END BiSS_Splitter_Rev7;


ARCHITECTURE rtl OF BiSS_Splitter_Rev7 IS

  -- Component Declarations
  COMPONENT BiSS_Splitter_Rev7_tc
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          enb                             :   OUT   std_logic;
          enb_1_1_1                       :   OUT   std_logic;
          enb_1_2_0                       :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT BiSS_C_Master
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2_0                       :   IN    std_logic;
          enb                             :   IN    std_logic;
          SLO_In                          :   IN    std_logic;
          MA_Out                          :   OUT   std_logic;
          Write_Clock                     :   OUT   std_logic;
          Error_rsvd                      :   OUT   std_logic;
          Buffer_Out                      :   OUT   std_logic;
          Bit_Number                      :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
          Write_Request                   :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT Motor_BiSS_C_Slave
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Buffer_In                       :   IN    std_logic;
          MA_In                           :   IN    std_logic;
          Motor_Done_In                   :   IN    std_logic;
          SLO_Out                         :   OUT   std_logic;
          Motor_Read_Clock                :   OUT   std_logic;
          Motor_Read_Request              :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT Buffer_rsvd
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          DAQ_Read_Request                :   IN    std_logic;
          DAQ_Read_Clock                  :   IN    std_logic;
          Write_Clock                     :   IN    std_logic;
          Error_rsvd                      :   IN    std_logic;
          Write_In                        :   IN    std_logic;
          Bit_Number_In                   :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          Write_Request                   :   IN    std_logic;
          Motor_Read_Clock                :   IN    std_logic;
          Motor_Read_Request              :   IN    std_logic;
          DAQ_Read_Out                    :   OUT   std_logic;
          DAQ_Read_Done                   :   OUT   std_logic;
          Motor_Read_Out                  :   OUT   std_logic;
          Motor_Read_Done                 :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT DAQ_BiSS_C_Slave
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Buffer_In                       :   IN    std_logic;
          Trig                            :   IN    std_logic;
          DAQ_Read_Done                   :   IN    std_logic;
          DAQ_Read_Clock                  :   OUT   std_logic;
          Data_Log_Out                    :   OUT   std_logic;
          DAQ_Read_Request                :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : BiSS_Splitter_Rev7_tc
    USE ENTITY work.BiSS_Splitter_Rev7_tc(rtl);

  FOR ALL : BiSS_C_Master
    USE ENTITY work.BiSS_C_Master(rtl);

  FOR ALL : Motor_BiSS_C_Slave
    USE ENTITY work.Motor_BiSS_C_Slave(rtl);

  FOR ALL : Buffer_rsvd
    USE ENTITY work.Buffer_rsvd(rtl);

  FOR ALL : DAQ_BiSS_C_Slave
    USE ENTITY work.DAQ_BiSS_C_Slave(rtl);

  -- Signals
  SIGNAL enb_1_2_0                        : std_logic;
  SIGNAL enb                              : std_logic;
  SIGNAL enb_1_1_1                        : std_logic;
  SIGNAL MA_to_Encoder                    : std_logic;
  SIGNAL Write_Clock                      : std_logic;
  SIGNAL error_rsvd                       : std_logic;
  SIGNAL BiSS_C_Master_out4               : std_logic;
  SIGNAL onDigit                          : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL request                          : std_logic;
  SIGNAL Motor_Read_Out                   : std_logic;
  SIGNAL motor_done                       : std_logic;
  SIGNAL Motor_BiSS_C_Slave_out1          : std_logic;
  SIGNAL Motor_BiSS_C_Slave_out2          : std_logic;
  SIGNAL Motor_BiSS_C_Slave_out3          : std_logic;
  SIGNAL DAQ_BiSS_C_Slave_out3            : std_logic;
  SIGNAL DAQ_BiSS_C_Slave_out1            : std_logic;
  SIGNAL DAQ_Read_Out                     : std_logic;
  SIGNAL Buffer_out2                      : std_logic;
  SIGNAL DAQ_BiSS_C_Slave_out2            : std_logic;

BEGIN
  u_BiSS_Splitter_Rev7_tc : BiSS_Splitter_Rev7_tc
    PORT MAP( clk => clk,
              reset => reset,
              clk_enable => clk_enable,
              enb => enb,
              enb_1_1_1 => enb_1_1_1,
              enb_1_2_0 => enb_1_2_0
              );

  u_BiSS_C_Master : BiSS_C_Master
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2_0 => enb_1_2_0,
              enb => enb,
              SLO_In => Encoder_SLO,
              MA_Out => MA_to_Encoder,
              Write_Clock => Write_Clock,
              Error_rsvd => error_rsvd,
              Buffer_Out => BiSS_C_Master_out4,
              Bit_Number => onDigit,  -- uint8
              Write_Request => request
              );

  u_Motor_BiSS_C_Slave : Motor_BiSS_C_Slave
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              Buffer_In => Motor_Read_Out,
              MA_In => Motor_MA,
              Motor_Done_In => motor_done,
              SLO_Out => Motor_BiSS_C_Slave_out1,
              Motor_Read_Clock => Motor_BiSS_C_Slave_out2,
              Motor_Read_Request => Motor_BiSS_C_Slave_out3
              );

  u_Buffer : Buffer_rsvd
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              DAQ_Read_Request => DAQ_BiSS_C_Slave_out3,
              DAQ_Read_Clock => DAQ_BiSS_C_Slave_out1,
              Write_Clock => Write_Clock,
              Error_rsvd => error_rsvd,
              Write_In => BiSS_C_Master_out4,
              Bit_Number_In => onDigit,  -- uint8
              Write_Request => request,
              Motor_Read_Clock => Motor_BiSS_C_Slave_out2,
              Motor_Read_Request => Motor_BiSS_C_Slave_out3,
              DAQ_Read_Out => DAQ_Read_Out,
              DAQ_Read_Done => Buffer_out2,
              Motor_Read_Out => Motor_Read_Out,
              Motor_Read_Done => motor_done
              );

  u_DAQ_BiSS_C_Slave : DAQ_BiSS_C_Slave
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              Buffer_In => DAQ_Read_Out,
              Trig => DAQ_Trig,
              DAQ_Read_Done => Buffer_out2,
              DAQ_Read_Clock => DAQ_BiSS_C_Slave_out1,
              Data_Log_Out => DAQ_BiSS_C_Slave_out2,
              DAQ_Read_Request => DAQ_BiSS_C_Slave_out3
              );

  ce_out <= enb_1_1_1;

  Encoder_MA <= MA_to_Encoder;

  DAQ_Out <= DAQ_BiSS_C_Slave_out2;

  Motor_SLO <= Motor_BiSS_C_Slave_out1;

END rtl;

