library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity fruit is
	port (
		clk, eaten : in std_logic;
		entry : in std_logic_vector(2 downto 0);
		found : out std_logic;
		random_x, random_y : out integer
	);
end fruit;

architecture Behavioral of fruit is
	
	signal x_temp, y_temp, x2_temp, y2_temp : std_logic_vector (7 downto 0) := (others => '0');
	signal x, y, counter : integer := 0;
	signal temp_found : std_logic := '0';
	signal fill : std_logic_vector (2 downto 0);
	
begin
	
	generate_number : process (clk)
	begin
		if clk'event and clk = '1' then
			if counter = 8 and temp_found = '0' then
				x_temp(7 downto 1) <= x_temp(6 downto 0);
				x_temp(0) <= not(x_temp(7) xor x_temp(6) xor x_temp(4));
				y_temp(7 downto 1) <= y_temp(6 downto 0);
				y_temp(0) <= not(y_temp(5) xor y_temp(2) xor y_temp(0));	
				x2_temp <= x_temp;
				y2_temp <= y_temp;
				x2_temp(7) <= '0';
				x2_temp(6) <= '0';
				y2_temp(7) <= '0';
				y2_temp(6) <= '0';
				x <= to_integer(unsigned(x2_temp));
				y <= to_integer(unsigned(y2_temp));
				random_x <= x;
				random_y <= y;
			end if;
		end if;
	end process;
	
	
	process (clk)
	begin
		if clk'event and clk = '1' then
			if eaten = '1' then
				if counter = 30 then
					counter <= 1;
					if temp_found = '0' then
						if fill = "000" and y <= 59 then
							temp_found <= '1';
						end if;
					end if;
				else
					counter <= counter + 1;
					if counter = 14 then
						fill <= entry;
					end if;
				end if;
			else
				temp_found <= '0';
			end if;
		end if;
	end process;
	found <= temp_found;
	
end Behavioral;