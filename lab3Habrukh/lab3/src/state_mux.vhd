library IEEE;
use IEEE.std_logic_1164.all;

entity state_mux is
    port(
		IN1 : in STD_LOGIC_VECTOR(3 downto 0);
		IN2 : in STD_LOGIC_VECTOR(3 downto 0);
		IN3 : in STD_LOGIC_VECTOR(3 downto 0);
		MODE : in STD_LOGIC_VECTOR(1 downto 0);
        SEL : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture state_mux_arch of state_mux is
begin 
	SEL <= IN1 when MODE = "00" else
		   IN2 when MODE = "01" else
		   IN3 when MODE = "10" else
		   (others => '0');
end architecture;