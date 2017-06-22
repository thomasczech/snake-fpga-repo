library ieee;
use ieee.std_logic_1164.all;

entity head is
	port (
		slow_clk : in std_logic;
		dir : in std_logic_vector(1 downto 0);
		head_x : out integer range 0 to 79;
		head_y : out integer range 0 to 59;
		head_dir : out std_logic_vector(2 downto 0)
	);
end head;


architecture behave of head is
	signal x_val : integer range 0 to 79 := 5;
	signal y_val : integer range 0 to 59 := 5;
	constant num : integer := 62937519;
	signal counter : integer := 0;
	
begin
  
	move : process(slow_clk)
		variable last_head_x : integer range 0 to 79 := 4;
		variable last_head_y : integer range 0 to 59 := 5;
	begin
	last_head_x := x_val;
	last_head_y := y_val;
		if slow_clk'event and slow_clk = '1' then
			if counter = num then
				counter <= 1;
				case dir is
					when "01" => head_dir <= "001";
						if y_val = 0 then
							y_val <= 59;
						else
							y_val <= y_val - 1;
						end if;
							
					when "10" => head_dir <= "010";
						if x_val = 79 then
							x_val <= 0;
						else
							x_val <= x_val + 1;
						end if;
							
					when "11" => head_dir <= "011";
						if y_val = 59 then
							y_val <= 0;
						else
							y_val <= y_val + 1;
						end if;
							
					when others => head_dir <= "100";
						if x_val = 0 then
							x_val <= 79;
						else
							x_val <= x_val - 1;
						end if;       
				end case;
			else
				counter <= counter + 1;		
			end if;
		end if;
		head_x <= last_head_x;
		head_y <= last_head_y;
	end process;
	
	
	
end behave;