library IEEE;
use IEEE.std_logic_1164.all;

entity init_perm_inv is
    port(
        INDB : in STD_LOGIC_VECTOR(7 downto 0);
        OUDB : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;

architecture init_perm_inv_arch of init_perm_inv is
    begin 
    -- by description:
    -- X[1 2 3 4 5 6 7 8]
    -- IP_inv(X) = [ X[4] X[1] X[3] X[5] X[7] X[2] X[8] X[6] ]
    -- by hardware notation:
    -- IP_INV([7 6 5 4 3 2 1 0]) = [4 7 5 3 1 6 0 2]
    OUDB(7) <= INDB(4);
    OUDB(6) <= INDB(7);
    OUDB(5) <= INDB(5);
    OUDB(4) <= INDB(3);
    OUDB(3) <= INDB(1);
    OUDB(2) <= INDB(6);
    OUDB(1) <= INDB(0);
    OUDB(0) <= INDB(2);
end architecture;