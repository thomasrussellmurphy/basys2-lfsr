library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity button_slow_repeat is
  port (
    -- Clock input
    CLK : in std_logic;
    -- Clock enable, synchronous to CLK
    c_en : in boolean;
    last_signal : out std_logic
  );
end button_slow_repeat;

architecture RTL of button_slow_repeat is
  -- internal signals
  signal internal_signal : std_logic := '0';
  variable internal_variable : std_logic := '0';
begin
  -- logic and processes
  registers: process (CLK)
  begin
    if rising_edge(CLK) then
      -- Set registers
    end if;
  end process registers;
end RTL;
