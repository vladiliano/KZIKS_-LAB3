library IEEE;
use IEEE.std_logic_1164.all;

entity round_func is
    port(
        INDB : in STD_LOGIC_VECTOR(3 downto 0);
        INRK : in STD_LOGIC_VECTOR(7 downto 0);
        OUDB : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture round_func_arch of round_func is
    signal db_expanded : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal rf_state1 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal rf_state2 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
begin 

    rf_exp: entity work.rf_expand(rf_expand_arch)
    port map (
        INDB => INDB,
        OUDB => db_expanded
    );
    
    rf_xor_with_rk: entity work.rf_xor_8(rf_xor_8_arch)
    port map (
        IDB1 => db_expanded,
        IDB2 => INRK,
        OUDB => rf_state1
    );

    rf_s1: entity work.rf_subst_1(rf_subst_1_arch)
    port map (
        INDB => rf_state1(7 downto 4),
        OUDB => rf_state2(3 downto 2)
    );

    rf_s2: entity work.rf_subst_2(rf_subst_2_arch)
    port map (
        INDB => rf_state1(3 downto 0),
        OUDB => rf_state2(1 downto 0)
    );

    rf_perm: entity work.rf_permute(rf_permute_arch)
    port map (
        INDB => rf_state2,
        OUDB => OUDB
    );

end architecture;