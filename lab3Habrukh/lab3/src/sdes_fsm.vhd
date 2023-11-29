library IEEE;
use IEEE.std_logic_1164.all;

entity sdes_fsm is
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
end entity;

architecture sdes_fsm_arch of sdes_fsm is
	type state_type is (idle, key_lock, rk1_wr, rk2_wr, e_data_lock, e_round1, e_round2, d_data_lock, d_round1, d_round2);
	signal fsm_state, fsm_state_next : state_type := idle;
	signal round_sel : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal wr_state : STD_LOGIC := '0';
	signal final_round : STD_LOGIC := '0'; 
	signal rkst_load : STD_LOGIC := '0';
	signal rkst_write : STD_LOGIC := '0';
	signal rotate_select : STD_LOGIC := '0';
	signal rkey_select : STD_LOGIC := '0';
	signal rkey_write : STD_LOGIC := '0';
	signal ciph_finish : STD_LOGIC := '1';
	signal key_ready : STD_LOGIC := '0';
begin 
	
	fsm_reg: process(CLK, RST)
	begin
		if CLK'event and CLK = '1' then
			if RST = '1' then
				fsm_state <= idle;
				RSEL <= (others => '0');
				STLOCK <= '0';
				FINR <= '0';
				RKSTLD <= '0';
				RKSTWR <= '0';
				ROTSEL <= '0';
				RKYSEL <= '0';
				RKYWR <= '0';
				DRDY <= '1';
				KRDY <= '0';
			else
				fsm_state <= fsm_state_next;
				RSEL <= round_sel;
				STLOCK <= wr_state;
				FINR <= final_round;
				RKSTLD <= rkst_load;
				RKSTWR <= rkst_write;
				ROTSEL <= rotate_select;
				RKYSEL <= rkey_select;
				RKYWR <= rkey_write;
				DRDY <= ciph_finish;
				KRDY <= key_ready;
			end if;
		end if;
	end process;
	
	next_state_gen: process(fsm_state, MODE, START, LDNK)
	begin
		fsm_state_next <= fsm_state;
		round_sel <= (others => '0');
		wr_state <= '0';
		final_round <= '1';
		rkst_load <= '0';
		rkst_write <= '0';
		rotate_select <= '0';
		rkey_select <= '0';
		rkey_write <= '0';
		--ciph_finish <= '1';
		--key_ready <= '0';
		case (fsm_state) is
			when idle => -- default state
				if MODE = '0' and START = '1' then
					fsm_state_next <= e_data_lock;
					round_sel <= "00";
					wr_state <= '1';
					final_round <= '0';
					ciph_finish <= '0';
				elsif MODE = '1' and START = '1' then
					fsm_state_next <= d_data_lock;
					round_sel <= "00";
					wr_state <= '1';
					final_round <= '0';
					ciph_finish <= '0';
				elsif LDNK = '1' then
					fsm_state_next <= key_lock;
					rkst_load <= '0';
					rkst_write <= '1';
					key_ready <= '0';
				end if;
			-- key_exp
			when key_lock =>
				fsm_state_next <= rk1_wr;
				rotate_select <= '0';
				rkst_load <= '1';
				rkst_write <= '1';
				rkey_select <= '0';
				rkey_write <= '1';
			when rk1_wr =>
				fsm_state_next <= rk2_wr;
				rotate_select <= '1';
				rkey_select <= '1';
				rkey_write <= '1';
				rkst_write <= '0';
			when rk2_wr =>
				fsm_state_next <= idle;
				rkst_load <= '0';
				rkst_write <= '0';
				rotate_select <= '0';
				rkey_select <= '0';
				rkey_write <= '0';
				key_ready <= '1';
			-- encrypt
			when e_data_lock =>
				fsm_state_next <= e_round1;
				round_sel <= "01";
				wr_state <= '1';
				rkey_select <= '0';
				final_round <= '0';
			when e_round1 =>
				fsm_state_next <= e_round2;
				round_sel <= "10";
				wr_state <= '1';
				rkey_select <= '1';
				final_round <= '0';
			when e_round2 =>
				fsm_state_next <= idle;
				round_sel <= "00";
				wr_state <= '0';
				rkey_select <= '0';
				final_round <= '1';
				ciph_finish <= '1';
			-- decrypt
			when d_data_lock =>
				fsm_state_next <= d_round1;
				round_sel <= "01";
				wr_state <= '1';
				rkey_select <= '1';
				final_round <= '0';
			when d_round1 =>
				fsm_state_next <= d_round2;
				round_sel <= "10";
				wr_state <= '1';
				rkey_select <= '0';
				final_round <= '0';
			when d_round2 =>
				fsm_state_next <= idle;
				round_sel <= "00";
				wr_state <= '0';
				rkey_select <= '0';
				final_round <= '1';
				ciph_finish <= '1';
			when others => -- not going to happen
				fsm_state_next <= fsm_state;
		end case;
	end process;
	
end architecture;