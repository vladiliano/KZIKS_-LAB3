library IEEE;
use IEEE.std_logic_1164.all;

entity perm_choice1 is
    port(
        KEYIN : in STD_LOGIC_VECTOR(9 downto 0);
        KEYST : out STD_LOGIC_VECTOR(9 downto 0)
    );
end entity;

architecture perm_choice1_arch of perm_choice1 is
    begin 
    -- PC1([9 8 7 6 5 4 3 2 1 0]) = [7 5 8 3 6 0 9 1 2 4]
    KEYST(9) <= KEYIN(7);
    KEYST(8) <= KEYIN(5);
    KEYST(7) <= KEYIN(8);
    KEYST(6) <= KEYIN(3);
    KEYST(5) <= KEYIN(6);
    KEYST(4) <= KEYIN(0);
    KEYST(3) <= KEYIN(9);
    KEYST(2) <= KEYIN(1);
    KEYST(1) <= KEYIN(2);
    KEYST(0) <= KEYIN(4);
end architecture;