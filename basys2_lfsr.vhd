library IEEE;
  use IEEE.STD_LOGIC_1164.ALL;
  use IEEE.STD_LOGIC_ARITH.ALL;
  use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity basys2_lfsr is
  port (
    -- Clock inputs
    MCLK      : in    std_logic;
    UCLK      : in    std_logic;
    -- User physical inputs
    BTN       : in    std_logic_vector (3 downto 0);
    SW        : in    std_logic_vector (7 downto 0);
    -- User LED/Display outputs
    LED       : out   std_logic_vector (7 downto 0);
    SEG       : out   std_logic_vector (6 downto 0);
    AN        : out   std_logic_vector (3 downto 0);
    DP        : out   std_logic;
    -- VGA Interface
    VGA_RED   : out   std_logic_vector (2 downto 0);
    VGA_GREEN : out   std_logic_vector (2 downto 0);
    VGA_BLUE  : out   std_logic_vector (2 downto 1);
    VGA_HS    : out   std_logic;
    VGA_VS    : out   std_logic;
    -- PS2
    PS2C      : inout std_logic;
    PS2D      : inout std_logic;
    -- Expansion headers (6-pin, 4 data connections each)
    -- JA: 1 to 4 are 72 to 75
    -- JB: 1 to 4 are 76 to 79
    -- JC: 1 to 4 are 80 to 83
    -- JD: 1 to 4 are 84 to 87
    PIO       : inout std_logic_vector (87 downto 72);
    -- Data interface to PC via USB
    EppAstb   : in    std_logic;
    EppDstb   : in    std_logic;
    EppWr     : in    std_logic;
    EppWait   : out   std_logic;
    EppDB     : inout std_logic_vector (7 downto 0)
  );

end basys2_lfsr;

architecture Structural of basys2_lfsr is
  signal s_led_controller_trigger : boolean;
begin
  -- Set unused LED indicators dark
  SEG <= (others => '1');
  AN <= (others => '1');
  DP <= '1';
  
  -- Set VGA all low
  VGA_RED <= (others => '0');
  VGA_GREEN <= (others => '0');
  VGA_BLUE <= (others => '0');
  VGA_HS <= '0';
  VGA_VS <= '0';
  
  -- Set EppWait to no-ack
  EppWait <= '0';
  
  -- Tristate all INOUTs
  PS2C <= 'Z';
  PS2D <= 'Z';
  PIO <= (others => '0') when (false) else (others => 'Z');
  EppDB <= (others => '0') when (false) else (others => 'Z');
  
  -- Instantiate the button trigger processor
  button_slow_repeat_inst : entity button_slow_repeat (RTL)
  port map (
    CLK => UCLK,
    c_en => true,
    a_trigger => BTN(0),
    c_triggered => s_led_controller_trigger
  );
  
  -- Instantiate the LED controller
  led_controller_inst : entity led_controller (RTL)
  port map (
    CLK => UCLK,
    c_en => true,
    c_next => s_led_controller_trigger,
    c_led => LED
  );
end Structural;
