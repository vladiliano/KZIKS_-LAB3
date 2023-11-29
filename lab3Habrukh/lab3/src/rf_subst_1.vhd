library IEEE;
use IEEE.std_logic_1164.all;

entity rf_subst_1 is
    port(
        INDB : in STD_LOGIC_VECTOR(3 downto 0);
        OUDB : out STD_LOGIC_VECTOR(1 downto 0)
    );
end entity;

architecture rf_subst_1_arch of rf_subst_1 is
begin 
    -- S1([3 2 1 0]) = [1 0] by special table
    OUDB <= "00" when INDB = "0010" or INDB = "0111" or INDB = "1000" else
            "01" when INDB = "0000" or INDB = "0101" or INDB = "1011" or INDB = "1100" else
            "10" when INDB = "0011" or INDB = "0110" or INDB = "1010" or INDB = "1111" else
            "11"; -- when 0001 or 0100 or 1001 or 1101 or 1110
end architecture;