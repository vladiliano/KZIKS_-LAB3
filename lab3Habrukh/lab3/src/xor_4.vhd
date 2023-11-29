library IEEE;
use IEEE.std_logic_1164.all;

entity xor_4 is
    port(
        IDB1 : in STD_LOGIC_VECTOR(3 downto 0);
        IDB2 : in STD_LOGIC_VECTOR(3 downto 0);
        OUDB : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture xor_4_arch of xor_4 is
begin 
    OUDB <= IDB1 xor IDB2;
end architecture;