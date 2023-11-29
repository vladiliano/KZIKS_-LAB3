-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : lab3
-- Author      : Gizmo
-- Company     : HP Inc.
--
-------------------------------------------------------------------------------
--
-- File        : C:\my_designs\lab3Habrukh\lab3\compile\hw_simple_des_fsm.vhd
-- Generated   : Wed Nov 29 17:27:16 2023
-- From        : C:\my_designs\lab3Habrukh\lab3\src\hw_simple_des_fsm.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;

entity hw_simple_des_fsm is
  port(
       IDB : in STD_LOGIC_VECTOR(7 downto 0);
       ODB : out STD_LOGIC_VECTOR(7 downto 0);
       KEY : in STD_LOGIC_VECTOR(9 downto 0);
       CLK : in STD_LOGIC;
       RST : in STD_LOGIC;
       MODE : in STD_LOGIC;
       START : in STD_LOGIC;
       LK : in STD_LOGIC;
       DRDY : out STD_LOGIC;
       KRDY : out STD_LOGIC
  );
end hw_simple_des_fsm;

architecture hw_simple_des_fsm of hw_simple_des_fsm is

---- Component declarations -----

component init_perm
  port(
       INDB : in STD_LOGIC_VECTOR(7 downto 0);
       OUDB : out STD_LOGIC_VECTOR(7 downto 0)
  );
end component;
component init_perm_inv
  port(
       INDB : in STD_LOGIC_VECTOR(7 downto 0);
       OUDB : out STD_LOGIC_VECTOR(7 downto 0)
  );
end component;
component key_mux
  port(
       IN1 : in STD_LOGIC_VECTOR(9 downto 0);
       IN2 : in STD_LOGIC_VECTOR(9 downto 0);
       MODE : in STD_LOGIC;
       SEL : out STD_LOGIC_VECTOR(9 downto 0)
  );
end component;
component output_mux
  port(
       IN1 : in STD_LOGIC_VECTOR(7 downto 0);
       IN2 : in STD_LOGIC_VECTOR(7 downto 0);
       MODE : in STD_LOGIC;
       SEL : out STD_LOGIC_VECTOR(7 downto 0)
  );
end component;
component perm_choice1
  port(
       KEYIN : in STD_LOGIC_VECTOR(9 downto 0);
       KEYST : out STD_LOGIC_VECTOR(9 downto 0)
  );
end component;
component perm_choice2
  port(
       KSIN : in STD_LOGIC_VECTOR(9 downto 0);
       RKEY : out STD_LOGIC_VECTOR(7 downto 0)
  );
end component;
component rk_ram
  port(
       RKI : in STD_LOGIC_VECTOR(7 downto 0);
       RK_SEL : in STD_LOGIC;
       WE : in STD_LOGIC;
       CLK : in STD_LOGIC;
       RST : in STD_LOGIC;
       RKO : out STD_LOGIC_VECTOR(7 downto 0)
  );
end component;
component rk_reg
  port(
       RKI : in STD_LOGIC_VECTOR(9 downto 0);
       WE : in STD_LOGIC;
       CLK : in STD_LOGIC;
       RST : in STD_LOGIC;
       RKO : out STD_LOGIC_VECTOR(9 downto 0)
  );
end component;
component rotate_rk
  port(
       IDB : in STD_LOGIC_VECTOR(9 downto 0);
       RS : in STD_LOGIC;
       ODB : out STD_LOGIC_VECTOR(9 downto 0)
  );
end component;
component round_func
  port(
       INDB : in STD_LOGIC_VECTOR(3 downto 0);
       INRK : in STD_LOGIC_VECTOR(7 downto 0);
       OUDB : out STD_LOGIC_VECTOR(3 downto 0)
  );
end component;
component sdes_fsm
  port(
       CLK : in STD_LOGIC;
       RST : in STD_LOGIC;
       MODE : in STD_LOGIC;
       START : in STD_LOGIC;
       LDNK : in STD_LOGIC;
       RSEL : out STD_LOGIC_VECTOR(1 downto 0);
       STLOCK : out STD_LOGIC;
       FINR : out STD_LOGIC;
       RKSTLD : out STD_LOGIC;
       RKSTWR : out STD_LOGIC;
       ROTSEL : out STD_LOGIC;
       RKYSEL : out STD_LOGIC;
       RKYWR : out STD_LOGIC;
       DRDY : out STD_LOGIC;
       KRDY : out STD_LOGIC
  );
end component;
component state_mux
  port(
       IN1 : in STD_LOGIC_VECTOR(3 downto 0);
       IN2 : in STD_LOGIC_VECTOR(3 downto 0);
       IN3 : in STD_LOGIC_VECTOR(3 downto 0);
       MODE : in STD_LOGIC_VECTOR(1 downto 0);
       SEL : out STD_LOGIC_VECTOR(3 downto 0)
  );
end component;
component state_reg
  port(
       DSI : in STD_LOGIC_VECTOR(3 downto 0);
       WE : in STD_LOGIC;
       CLK : in STD_LOGIC;
       RST : in STD_LOGIC;
       DSO : out STD_LOGIC_VECTOR(3 downto 0)
  );
end component;
component xor_4
  port(
       IDB1 : in STD_LOGIC_VECTOR(3 downto 0);
       IDB2 : in STD_LOGIC_VECTOR(3 downto 0);
       OUDB : out STD_LOGIC_VECTOR(3 downto 0)
  );
end component;

---- Signal declarations used on the diagram ----

signal final_round : STD_LOGIC;
signal rkey_select : STD_LOGIC;
signal rkey_write : STD_LOGIC;
signal rkst_load : STD_LOGIC;
signal rkst_write : STD_LOGIC;
signal rotate_select : STD_LOGIC;
signal wr_state : STD_LOGIC;
signal BUS177 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS185 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS368 : STD_LOGIC_VECTOR(7 downto 0);
signal BUS393 : STD_LOGIC_VECTOR(9 downto 0);
signal BUS418 : STD_LOGIC_VECTOR(9 downto 0);
signal BUS515 : STD_LOGIC_VECTOR(9 downto 0);
signal BUS556 : STD_LOGIC_VECTOR(9 downto 0);
signal BUS597 : STD_LOGIC_VECTOR(7 downto 0);
signal BUS64 : STD_LOGIC_VECTOR(3 downto 0);
signal BUS68 : STD_LOGIC_VECTOR(3 downto 0);
signal data_state : STD_LOGIC_VECTOR(7 downto 0);
signal def : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
signal r1_state : STD_LOGIC_VECTOR(7 downto 0);
signal round_key : STD_LOGIC_VECTOR(7 downto 0);
signal round_sel : STD_LOGIC_VECTOR(1 downto 0);

begin

----  Component instantiations  ----

U1 : init_perm
  port map(
       INDB => IDB,
       OUDB => r1_state
  );

U10 : perm_choice1
  port map(
       KEYIN => KEY,
       KEYST => BUS393
  );

U11 : key_mux
  port map(
       IN1 => BUS393,
       IN2 => BUS556,
       MODE => rkst_load,
       SEL => BUS418
  );

U13 : rotate_rk
  port map(
       IDB => BUS515,
       RS => rotate_select,
       ODB => BUS556
  );

U14 : perm_choice2
  port map(
       KSIN => BUS556,
       RKEY => BUS597
  );

U15 : rk_ram
  port map(
       RKI => BUS597,
       RK_SEL => rkey_select,
       WE => rkey_write,
       CLK => CLK,
       RST => RST,
       RKO => round_key
  );

U16 : sdes_fsm
  port map(
       CLK => CLK,
       RST => RST,
       MODE => MODE,
       START => START,
       LDNK => LK,
       RSEL => round_sel,
       STLOCK => wr_state,
       FINR => final_round,
       RKSTLD => rkst_load,
       RKSTWR => rkst_write,
       ROTSEL => rotate_select,
       RKYSEL => rkey_select,
       RKYWR => rkey_write,
       DRDY => DRDY,
       KRDY => KRDY
  );

U17 : rk_reg
  port map(
       RKI => BUS418,
       WE => rkst_write,
       CLK => CLK,
       RST => RST,
       RKO => BUS515
  );

U2 : state_mux
  port map(
       IN1(3) => r1_state(7),
       IN1(2) => r1_state(6),
       IN1(1) => r1_state(5),
       IN1(0) => r1_state(4),
       IN2(3) => data_state(3),
       IN2(2) => data_state(2),
       IN2(1) => data_state(1),
       IN2(0) => data_state(0),
       IN3 => BUS185,
       MODE => round_sel,
       SEL => BUS64
  );

U3 : state_mux
  port map(
       IN1(3) => r1_state(3),
       IN1(2) => r1_state(2),
       IN1(1) => r1_state(1),
       IN1(0) => r1_state(0),
       IN2 => BUS185,
       IN3(3) => data_state(3),
       IN3(2) => data_state(2),
       IN3(1) => data_state(1),
       IN3(0) => data_state(0),
       MODE => round_sel,
       SEL => BUS68
  );

U4 : state_reg
  port map(
       DSI => BUS64,
       WE => wr_state,
       CLK => CLK,
       RST => RST,
       DSO(3) => data_state(7),
       DSO(2) => data_state(6),
       DSO(1) => data_state(5),
       DSO(0) => data_state(4)
  );

U5 : state_reg
  port map(
       DSI => BUS68,
       WE => wr_state,
       CLK => CLK,
       RST => RST,
       DSO(3) => data_state(3),
       DSO(2) => data_state(2),
       DSO(1) => data_state(1),
       DSO(0) => data_state(0)
  );

U6 : round_func
  port map(
       INDB(3) => data_state(3),
       INDB(2) => data_state(2),
       INDB(1) => data_state(1),
       INDB(0) => data_state(0),
       INRK => round_key,
       OUDB => BUS177
  );

U7 : xor_4
  port map(
       IDB1(3) => data_state(7),
       IDB1(2) => data_state(6),
       IDB1(1) => data_state(5),
       IDB1(0) => data_state(4),
       IDB2 => BUS177,
       OUDB => BUS185
  );

U8 : output_mux
  port map(
       IN1 => def,
       IN2 => data_state,
       MODE => final_round,
       SEL => BUS368
  );

U9 : init_perm_inv
  port map(
       INDB => BUS368,
       OUDB => ODB
  );


end hw_simple_des_fsm;
