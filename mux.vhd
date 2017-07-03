library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
	port (
		clk,reset : in std_logic;
		reset_counter : in integer range 0 to 4799;
		--Logic
		found : in std_logic;
		head_dir : in std_logic_vector(2 downto 0);
		head_addr, tail_addr, del_addr, new_head_addr, fruit_addr : in integer range 0 to 4799;
		ram_addr : out integer range 0 to 4799;
		data : out std_logic_vector(2 downto 0);
		we : out std_logic
	);
end mux;

architecture Behavioral of mux is

	signal state : integer range 0 to 5 := 0; -- 0:	read head,
															-- 1: read tail,
															-- 2: read fruit,
															-- 3: write head, 
															-- 4: delete tail,
															-- 5: write fruit
															-- 6: reset ram
	signal counter : integer range 0 to 10 := 0;
	
begin
			
	process(clk)
	begin
		if clk'event and clk = '1' then
			if reset = '1' then
			ram_addr <= reset_counter;
				if reset_counter >= 2358 and reset_counter <= 2361 then
					data <= "010";
				elsif reset_counter = fruit_addr then
					data <= "101";
				else
					data <= "000";
				end if;
				we <= '1';
			else 
				case state is
					when 0 =>
						ram_addr <= new_head_addr;
						we <= '0';
					when 1 =>
						ram_addr <= tail_addr;
						we <= '0';
					when 2 =>
						ram_addr <= fruit_addr;
						we <= '0';
					when 3 =>
						ram_addr <= head_addr;
						data <= head_dir;
						we <= '1';
					when 4 =>
						ram_addr <= del_addr;
						data <= "000";
						we <= '1';
					when 5 =>
						if found = '1' then
							ram_addr <= fruit_addr;
							data <= "101";
							we <= '1';
						end if;
				end case;
			end if;
		end if;
	end process;
	
	count : process(clk)
	begin
		if clk'event and clk = '1' then
			if reset = '1' then
				counter <= 0;
				state <= 0;
			else
				if counter = 5 then
					counter <= 1;
					if state = 5 then
						state <= 0;
					else
						state <= state + 1;
					end if;
				else
					counter <= counter + 1;
				end if;
			end if;
		end if;
	end process;
	
end Behavioral;