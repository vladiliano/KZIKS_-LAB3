library IEEE;
use IEEE.std_logic_1164.all;

entity init_perm is
    port(
        INDB : in STD_LOGIC_VECTOR(7 downto 0);
        OUDB : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;

architecture init_perm_arch of init_perm is
    begin 
    -- by description:
    -- X[1 2 3 4 5 6 7 8]
    -- IP(X) = [ X[2] X[6] X[3] X[1] X[4] X[8] X[5] X[7] ]
    -- by hardware notation:
    -- IP_INV([7 6 5 4 3 2 1 0]) = [6 2 5 7 4 0 3 1]
    OUDB(7) <= INDB(6);
    OUDB(6) <= INDB(2);
    OUDB(5) <= INDB(5);
    OUDB(4) <= INDB(7);
    OUDB(3) <= INDB(4);
    OUDB(2) <= INDB(0);
    OUDB(1) <= INDB(3);
    OUDB(0) <= INDB(1);
end architecture;