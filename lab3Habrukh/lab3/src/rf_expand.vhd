library IEEE;
use IEEE.std_logic_1164.all;

entity rf_expand is
    port(
        INDB : in STD_LOGIC_VECTOR(3 downto 0);
        OUDB : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;

architecture rf_expand_arch of rf_expand is
    begin 
    -- E([3 2 1 0]) = [0 3 2 1 2 1 0 3]
    OUDB(7) <= INDB(0);
    OUDB(6) <= INDB(3);
    OUDB(5) <= INDB(2);
    OUDB(4) <= INDB(1);
    OUDB(3) <= INDB(2);
    OUDB(2) <= INDB(1);
    OUDB(1) <= INDB(0);
    OUDB(0) <= INDB(3);
end architecture;