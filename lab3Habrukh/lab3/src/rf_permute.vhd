library IEEE;
use IEEE.std_logic_1164.all;

entity rf_permute is
    port(
        INDB : in STD_LOGIC_VECTOR(3 downto 0);
        OUDB : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture rf_permute_arch of rf_permute is
    begin 
    -- P([3 2 1 0]) = [2 0 1 3]
    OUDB(3) <= INDB(2);
    OUDB(2) <= INDB(0);
    OUDB(1) <= INDB(1);
    OUDB(0) <= INDB(3);
end architecture;