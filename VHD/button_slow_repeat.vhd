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
    c_triggered : out boolean
  );
end button_slow_repeat;

architecture RTL of button_slow_repeat is
  -- clock division counter for slowness
  signal c_div_counter : unsigned(k_internal_counter_width-1 downto 0)
    := (others => '0');
  -- Shift register for making the trigger not metastable
  signal a_trigger_shiftreg : std_logic_vector(2 downto 0);
  signal c_trigger : std_logic;
begin
  -- logic and processes
  registers: process (CLK)
  begin
    if rising_edge(CLK) then
      -- Always shift the synchronization regs
      a_trigger_shiftreg <= a_trigger_shiftreg(1 downto 0) & a_trigger;
      c_trigger <= a_trigger_shiftreg(2);

      -- Always increment counter to ensure 1-cycle output pulse
      c_div_counter <= c_div_counter + 1;
      
      -- Set the triggered flag based on these conditions
      c_triggered <= c_en and c_div_counter = 0 and c_trigger = '1';
    end if;
  end process registers;
end RTL;
