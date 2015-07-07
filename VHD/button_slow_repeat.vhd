library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity button_slow_repeat is
  generic (
    k_internal_counter_width : natural := 25
  );
  port (
    -- Clock input
    CLK : in std_logic;
    -- Clock enable, synchronous to CLK
    c_en : in boolean;
    -- Possibly noisy, metastable, annoying signal in
    a_trigger : in std_logic;
    -- Nice, rate-limited output pulse
    s_triggered : out boolean
  );
end button_slow_repeat;

architecture RTL of button_slow_repeat is
  -- clock division counter for slowness
  signal c_div_counter : std_logic_vector(k_internal_counter_width-1 downto 0)
    := (others => '0');
  -- Shift register for making the trigger not metastable
  signal a_trigger_shiftreg : std_logic_vector(2 downto 0);
  signal c_trigger : std_logic;
begin
  -- logic and processes
  registers: process (CLK)
  begin
    if rising_edge(CLK) then
      -- Set registers
    end if;
  end process registers;
end RTL;
