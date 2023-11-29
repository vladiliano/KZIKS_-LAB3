library IEEE;
use IEEE.std_logic_1164.all;

entity rk_ram is
    port(
		RKI : in STD_LOGIC_VECTOR(7 downto 0);
		RK_SEL  : in STD_LOGIC;
		WE  : in STD_LOGIC;
		CLK : in STD_LOGIC;
		RST : in STD_LOGIC;
        RKO : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;

architecture rk_ram_arch of rk_ram is
	signal rk1_state : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal rk2_state : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin 
	
	rk_ram_proc: process(CLK, RST)
	begin
		if CLK'event and CLK = '1' then
			if RST = '1' then
				rk1_state <= (others => '0');
				rk2_state <= (others => '0');
			elsif WE = '1' then
				if RK_SEL = '0' then
					rk1_state <= RKI;
				else -- RK_SEL = '1'
					rk2_state <= RKI;
				end if;
			end if;
		end if;		
	end process;
	
	RKO <= rk1_state when RK_SEL = '0' else rk2_state;
	
end architecture;