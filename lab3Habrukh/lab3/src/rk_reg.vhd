library IEEE;
use IEEE.std_logic_1164.all;

entity rk_reg is
    port(
		RKI : in STD_LOGIC_VECTOR(9 downto 0);
		WE  : in STD_LOGIC;
		CLK : in STD_LOGIC;
		RST : in STD_LOGIC;
        RKO : out STD_LOGIC_VECTOR(9 downto 0)
    );
end entity;

architecture rk_reg_arch of rk_reg is
	signal rk_state : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
begin 
	
	rk_reg: process(CLK, RST)
	begin
		if CLK'event and CLK = '1' then
			if RST = '1' then
				rk_state <= (others => '0');
			elsif WE = '1' then
				rk_state <= RKI;
			end if;
		end if;		
	end process;
	
	RKO <= rk_state;
	
end architecture;