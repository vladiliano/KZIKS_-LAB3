library IEEE;
use IEEE.std_logic_1164.all;

entity rotate_rk is
    port(
		IDB : in STD_LOGIC_VECTOR(9 downto 0);
		RS  : in STD_LOGIC;
        ODB : out STD_LOGIC_VECTOR(9 downto 0)
    );
end entity;

architecture rotate_rk_arch of rotate_rk is
	signal C : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
	signal D : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
begin 
	C <= IDB(8 downto 5) & IDB(9) when RS = '0' else
		 IDB(7 downto 5) & IDB(9 downto 8);
	D <= IDB(3 downto 0) & IDB(4) when RS = '0' else
		 IDB(2 downto 0) & IDB(4 downto 3);
	ODB <= C & D;
end architecture;