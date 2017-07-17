library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pixel is
	port (
		clk, video, reset : in std_logic;
		data : in std_logic_vector(2 downto 0);
		vga_addr : in integer range 0 to 4799;
		r, g, b : out std_logic_vector(3 downto 0)
	);
end pixel;

architecture behave of pixel is
	
	type ram_type is array (0 to 298) of integer range 1692 to 2310;
	signal rom : ram_type := 
		(1692, 1693, 1694, 1695, 1696, 1699, 1700, 1701, 1702, 1706, 1707, 1708, 1709, 1710, 1711,
		1715, 1716, 1717, 1718, 1727, 1728, 1729, 1730, 1733, 1734, 1736, 1737,
		1740, 1741, 1742, 1743, 1745, 1746, 1747, 1748, 1749, 1771, 1772, 1773, 1774, 1775, 1776, 
		1778, 1779, 1780, 1781, 1782, 1783, 1785, 1786, 1787, 1788, 1790, 1791, 1792,
		1794, 1795, 1796, 1797, 1798, 1806, 1807, 1808, 1809, 1810, 1811, 1813, 1814, 1816, 1817,
		1819, 1820, 1821, 1822, 1823, 1825, 1826, 1827, 1827, 1828, 1829, 1830,
		1851, 1852, 1858, 1859, 1862, 1863, 1865, 1866, 1868, 1869, 1871, 1872, 1874, 1875,
		1886, 1887, 1890, 1891, 1893, 1894, 1896, 1897, 1899, 1900, 1905, 1906, 1908, 1909, 1910,
		1931, 1932, 1934, 1935, 1936, 1938, 1939, 1942, 1943, 1945, 1946, 1948, 1949, 1951, 1952,
		1954, 1955, 1956, 1957, 1958, 1966, 1967, 1970, 1971, 1973, 1974, 1976, 1977,
		1979, 1980, 1981, 1982, 1983, 1985, 1986, 1988, 1989, 2011, 2012, 2014, 2015, 2016,
		2018, 2019, 2020, 2021, 2022, 2023, 2025, 2026, 2028, 2029, 2031, 2032, 2034, 2035, 2036, 2037, 2038,
		2046, 2047, 2050, 2051, 2053, 2054, 2056, 2057, 2059, 2060, 2061, 2062, 2063,
		2065, 2066, 2067, 2068, 2069, 2091, 2092, 2095, 2096, 2098, 2099, 2100, 2101, 2102, 2103,
		2105, 2106, 2108, 2109, 2111, 2112,	2114, 2115,	2126, 2127, 2130, 2131, 2133, 2134, 2136, 2137,
		2139, 2140, 2145, 2146, 2147, 2148, 2149, 2171, 2172, 2173, 2174, 2175, 2176,
		2178, 2179, 2182, 2183, 2185, 2186, 2188, 2189, 2191, 2192, 2194, 2195, 2196, 2197, 2198,
		2206, 2207, 2208, 2209, 2210, 2211, 2213, 2214, 2215, 2216, 2217, 2219, 2220, 2221, 2222, 2223,
		2225, 2226, 2228, 2229, 2230, 2252, 2253, 2254, 2255, 2256, 2258, 2259, 2262, 2263,
		2265, 2266, 2268, 2269, 2271, 2272, 2275, 2276, 2277, 2278, 2287, 2288, 2289, 2290,
		2293, 2294, 2295, 2296, 2300, 2301, 2302, 2303, 2305, 2306, 2308, 2309, 2310);
		
		signal i : integer range 0 to 298 := 0;
		
		
begin
	process(clk)
	begin
		if clk'event and clk = '1' then
			if reset = '1' then
				if i = 298 then
					i <= 0;
				elsif vga_addr = rom(i) then
					r <= "1111";
					g <= "1111";
					b <= "1111";
					i <= i + 1;
				else
					r <= "0000";
					g <= "0000";
					b <= "0000";
				end if;
			elsif video = '0' then
				r <= "0000";
				g <= "0000";
				b <= "0000";
			elsif data = "000" then
				r <= "0000";
				g <= "0000";
				b <= "0000";
			elsif data = "101" then -- fruit
				r <= "1111";
				g <= "0000";
				b <= "0000";
			elsif data = "110" then -- obstacle
				r <= "1111";
				g <= "1111";
				b <= "1111";
			else
				r <= "0000";
				g <= "1111";
				b <= "0000";
				i <= 0;
			end if;
		end if;
	end process;
	
end behave;

