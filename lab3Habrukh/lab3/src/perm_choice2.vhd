library IEEE;
use IEEE.std_logic_1164.all;

entity perm_choice2 is
    port(
        KSIN : in STD_LOGIC_VECTOR(9 downto 0);
        RKEY : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;

architecture perm_choice2_arch of perm_choice2 is
    begin 
    -- PC2([9 8 7 6 5 4 3 2 1 0]) = [4 7 3 6 2 5 0 1]
    RKEY(7) <= KSIN(4);
    RKEY(6) <= KSIN(7);
    RKEY(5) <= KSIN(3);
    RKEY(4) <= KSIN(6);
    RKEY(3) <= KSIN(2);
    RKEY(2) <= KSIN(5);
    RKEY(1) <= KSIN(0);
    RKEY(0) <= KSIN(1);
end architecture;