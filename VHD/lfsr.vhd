library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lfsr is
  port (
  	-- Clock input
    CLK : in std_logic;
    -- Clock enable, synchronous to CLK
    c_en : in boolean;
    -- Initial state loading, synchronous to CLK
    c_load : in boolean;
    c_load_data : in std_logic_vector(31 downto 0);
    -- Current LFSR output, synchronous to CLK
    c_shift_out : out std_logic
  );

end lfsr;

architecture RTL of lfsr is
  -- Internal value for the linear feedback shift register
  -- synchronous to CLK
  signal c_shift_reg : std_logic_vector(31 downto 0) := (others => '0');
  -- Generated next value
  signal c_shift_reg_next : std_logic_vector(31 downto 0);
  
  -- Creating bit to shift in
  signal c_next_input_bit : std_logic;
begin
  registers: process (CLK)
  begin
    if rising_edge(CLK) then
      c_shift_reg <= c_shift_reg_next;
    end if;
  end process registers;
  
  next_state: process (c_en, c_load, c_load_data)
  begin
    -- Default: retain current shift register value
    c_shift_reg_next <= c_shift_reg;
    
    -- Every other action depends on the enable
    if c_en then
      if c_load then
        c_shift_reg_next <= c_load_data;
      else
        -- Actual shifting operation here
        c_shift_reg_next <= c_shift_reg_next(30 downto 0) & c_next_input_bit;
      end if;
    end if;
  end process next_state;
  
  -- Continuously determine the next input bit
  -- Bits chosen from table on page 5 of
  -- http://www.xilinx.com/support/documentation/application_notes/xapp052.pdf
  c_next_input_bit <= c_shift_reg(31) xnor
                c_shift_reg(21) xnor
                c_shift_reg(1) xnor
                c_shift_reg(0);

end RTL;
