library IEEE;
use IEEE.std_logic_1164.all;

entity rf_subst_2 is
    port(
        INDB : in STD_LOGIC_VECTOR(3 downto 0);
        OUDB : out STD_LOGIC_VECTOR(1 downto 0)
    );
end entity;

architecture rf_subst_2_arch of rf_subst_2 is
begin 
    -- S2([3 2 1 0]) = [1 0] by special table
    OUDB <= "00" when INDB = "0000" or INDB = "0011" or INDB = "1010" or INDB = "1101" or INDB = "1110" else
            "01" when INDB = "0010" or INDB = "0101" or INDB = "1011" or INDB = "1100" else
            "10" when INDB = "0001" or INDB = "0100" or INDB = "1001" else
            "11"; -- when 0110 or 0111 or 1000 or 1111 
end architecture;