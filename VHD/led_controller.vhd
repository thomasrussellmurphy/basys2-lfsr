library IEEE;
  use IEEE.STD_LOGIC_1164.ALL;
  use IEEE.STD_LOGIC_ARITH.ALL;
  use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity led_controller is
  port (
    -- Clock input
    CLK : in std_logic;
    -- Clock enable, synchronous to CLK
    c_en : in boolean;
    c_next : in boolean;
    c_led : out std_logic_vector(7 downto 0)
  );
end led_controller;

architecture RTL of led_controller is
  -- internal signals
  signal c_lfsr_out : std_logic;
  signal c_lfsr_en : boolean := false;
  signal c_led_state : std_logic_vector(7 downto 0) := (others => '0');
  signal c_update_counter : unsigned(3 downto 0) := (others => '0');
begin
  -- logic and processes
  registers: process (CLK)
  begin
    if rising_edge(CLK) then
      if c_en then
      	-- Set updates
      end if;
    end if;
  end process registers;

  -- Create appropriate control signals

  -- Instantiate LFSR for creating the next LED state
  lfsr_inst : entity lfsr (RTL)
  port map (
    CLK => CLK,
    c_en => c_lfsr_en,
    c_load => false,
    c_load_data => (others => '0'),
    c_shift_out => c_lfsr_out
  );
end RTL;
