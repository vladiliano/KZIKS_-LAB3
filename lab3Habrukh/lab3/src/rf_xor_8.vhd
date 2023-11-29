library IEEE;
use IEEE.std_logic_1164.all;

entity rf_xor_8 is
    port(
        IDB1 : in STD_LOGIC_VECTOR(7 downto 0);
        IDB2 : in STD_LOGIC_VECTOR(7 downto 0);
        OUDB : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;

architecture rf_xor_8_arch of rf_xor_8 is
begin 
    OUDB <= IDB1 xor IDB2;
end architecture;