library IEEE;
use IEEE.std_logic_1164.all;

entity state_reg is
    port(
		DSI : in STD_LOGIC_VECTOR(3 downto 0);
		WE  : in STD_LOGIC;
		CLK : in STD_LOGIC;
		RST : in STD_LOGIC;
        DSO : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture state_reg_arch of state_reg is
	signal reg_state : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
begin 
	
	reg: process(CLK, RST)
	begin
		if CLK'event and CLK = '1' then
			if RST = '1' then
				reg_state <= (others => '0');
			elsif WE = '1' then
				reg_state <= DSI;
			end if;
		end if;		
	end process;
	
	DSO <= reg_state;
	
end architecture;