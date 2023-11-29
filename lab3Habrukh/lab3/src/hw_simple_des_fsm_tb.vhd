library IEEE;
use IEEE.std_logic_1164.all;

entity hw_simple_des_fsm_tb is
end entity;

architecture hw_simple_des_fsm_tb_arch of hw_simple_des_fsm_tb is
	signal gclk : STD_LOGIC := '0';
	signal grst : STD_LOGIC := '0';
	signal input_msg : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal cipher_mode : STD_LOGIC := '0';
	signal cipher_start : STD_LOGIC := '0';
	signal cipher_key : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
    signal load_new_key : STD_LOGIC := '0';
	signal output_msg : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal ciph_finish : STD_LOGIC := '0';
	signal key_ready : STD_LOGIC := '0';
	constant GCLK_PERIOD: time := 10 ns;
	type teststate_t is (reset, key_expansion, cipher, ok, error);
	signal teststate : teststate_t := reset; 
begin 

    UUT: entity work.hw_simple_des_fsm(hw_simple_des_fsm)
    port map (
		IDB => input_msg,
	   	MODE => cipher_mode,
		START => cipher_start,
		KEY => cipher_key,
        LK => load_new_key,
		CLK => gclk,
		RST => grst,
		ODB => output_msg,
		DRDY =>	ciph_finish,
		KRDY =>	key_ready
    );
    
    gclk_gen: process
	begin
		gclk <= '1';
		wait for GCLK_PERIOD/2;
		gclk <= '0';
		wait for GCLK_PERIOD/2;	
	end process;

	stim_gen: process
	begin
		-- reset actions
		grst <= '1';
		wait for GCLK_PERIOD*2;
		grst <= '0';
		wait for GCLK_PERIOD*2;
		
		-- initial key schedule/expansion
		teststate <= key_expansion;
		cipher_key <= "0010010111";	-- x"097"
		load_new_key <= '1';
		wait for GCLK_PERIOD;
		load_new_key <= '0';
		wait until key_ready = '1';
		wait for GCLK_PERIOD*5;
		
		-- test case 1: data = 10001000 (88) mode = enc|dec expect = 01100101 (65)
		teststate <= cipher;
		input_msg <= "10001000"; -- x"88"
		cipher_mode <= '0'; -- encryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "01100101" then -- if not x"65"
			teststate <= error;
			report "test case 1: encryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;
		
		wait for GCLK_PERIOD*5;
		
		teststate <= cipher;
		input_msg <= "01100101"; -- x"65"
		cipher_mode <= '1'; -- decryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "10001000" then -- if not x"88"
			teststate <= error;
			report "test case 1: decryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;

		wait for GCLK_PERIOD*5;
		
		-- test case 2: data = 00100011 (23) mode = enc|dec expect = 01101001 (69)
		teststate <= cipher;
		input_msg <= "00100011"; -- x"23"
		cipher_mode <= '0'; -- encryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "01101001" then -- if not x"69"
			teststate <= error;
			report "test case 2: encryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;
		
		wait for GCLK_PERIOD*5;
		
		teststate <= cipher;
		input_msg <= "01101001"; -- x"69"
		cipher_mode <= '1'; -- decryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "00100011" then -- if not x"23"
			teststate <= error;
			report "test case 2: decryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;

		wait for GCLK_PERIOD*5;
		
		-- test case 3: data = 11110001 (F1) mode = enc|dec expect = 00000001 (01)
		teststate <= cipher;
		input_msg <= "11110001"; -- x"F1"
		cipher_mode <= '0'; -- encryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "00000001" then -- if not x"01"
			teststate <= error;
			report "test case 3: encryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;
		
		wait for GCLK_PERIOD*5;
		
		teststate <= cipher;
		input_msg <= "00000001"; -- x"01"
		cipher_mode <= '1'; -- decryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "11110001" then -- if not x"23"
			teststate <= error;
			report "test case 3: decryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;

		wait for GCLK_PERIOD*5;
		
		-- test case 4: data = 10001101 (8D) mode = enc|dec expect = 00110101 (35)
		teststate <= cipher;
		input_msg <= "10001101"; -- x"8D"
		cipher_mode <= '0'; -- encryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "00110101" then -- if not x"35"
			teststate <= error;
			report "test case 4: encryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;
		
		wait for GCLK_PERIOD*5;
		
		teststate <= cipher;
		input_msg <= "00110101"; -- x"35"
		cipher_mode <= '1'; -- decryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "10001101" then -- if not x"8D"
			teststate <= error;
			report "test case 4: decryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;

		wait for GCLK_PERIOD*5;
		
		-- test case 5: data = 01100000 (60) mode = enc|dec expect = 00010001 (11)
		teststate <= cipher;
		input_msg <= "01100000"; -- x"60"
		cipher_mode <= '0'; -- encryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "00010001" then -- if not x"11"
			teststate <= error;
			report "test case 5: encryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;
		
		wait for GCLK_PERIOD*5;
		
		teststate <= cipher;
		input_msg <= "00010001"; -- x"11"
		cipher_mode <= '1'; -- decryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "01100000" then -- if not x"60"
			teststate <= error;
			report "test case 5: decryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;

		wait for GCLK_PERIOD*5;
		
		-- key re-schedule/expansion - change ckey during operation
		teststate <= key_expansion;
		cipher_key <= "0011000101";	-- x"0C5"
		load_new_key <= '1';
		wait for GCLK_PERIOD;
		load_new_key <= '0';
		wait until key_ready = '1';
		wait for GCLK_PERIOD*5;
		
		-- test case 6: data = 10111000 (B8) mode = dec|enc expect = 10111100 (BC)
		teststate <= cipher;
		input_msg <= "10111000"; -- x"B8"
		cipher_mode <= '1'; -- decryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "10111100" then -- if not x"BC"
			teststate <= error;
			report "test case 6: encryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;
		
		wait for GCLK_PERIOD*5;
		
		teststate <= cipher;
		input_msg <= "10111100"; -- x"BC"
		cipher_mode <= '0'; -- encryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "10111000" then -- if not x"B8"
			teststate <= error;
			report "test case 6: decryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;

		wait for GCLK_PERIOD*5;
		
		-- test case 7: data = 01000001 (41) mode = dec|enc expect = 11000010 (C2)
		teststate <= cipher;
		input_msg <= "01000001"; -- x"41"
		cipher_mode <= '1'; --decryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "11000010" then -- if not x"C2"
			teststate <= error;
			report "test case 7: encryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;
		
		wait for GCLK_PERIOD*5;
		
		teststate <= cipher;
		input_msg <= "11000010"; -- x"C2"
		cipher_mode <= '0'; -- encryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "01000001" then -- if not x"41"
			teststate <= error;
			report "test case 7: decryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;

		wait for GCLK_PERIOD*5;
		
		-- test case 8: data = 10011110 (9E) mode = dec|enc expect = 00111100 (3C)
		teststate <= cipher;
		input_msg <= "10011110"; -- x"9E"
		cipher_mode <= '1'; -- decryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "00111100" then -- if not x"3C"
			teststate <= error;
			report "test case 8: encryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;
		
		wait for GCLK_PERIOD*5;
		
		teststate <= cipher;
		input_msg <= "00111100"; -- x"3C"
		cipher_mode <= '0'; -- encryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "10011110" then -- if not x"9E"
			teststate <= error;
			report "test case 8: decryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;

		wait for GCLK_PERIOD*5;
		
		-- test case 9: data = 11011101 (DD) mode = dec|enc expect = 10100010 (A2)
		teststate <= cipher;
		input_msg <= "11011101"; -- x"DD"
		cipher_mode <= '1'; -- decryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "10100010" then -- if not x"A2"
			teststate <= error;
			report "test case 9: encryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;
		
		wait for GCLK_PERIOD*5;
		
		teststate <= cipher;
		input_msg <= "10100010"; -- x"A2"
		cipher_mode <= '0'; -- encryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "11011101" then -- if not x"DD"
			teststate <= error;
			report "test case 9: decryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;

		wait for GCLK_PERIOD*5;
		
		-- test case 10: data = 00101000 (28) mode = dec|enc expect = 11011011 (DB)
		teststate <= cipher;
		input_msg <= "00101000"; -- x"28"
		cipher_mode <= '1'; -- decryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "11011011" then -- if not x"DB"
			teststate <= error;
			report "test case 10: encryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;
		
		wait for GCLK_PERIOD*5;
		
		teststate <= cipher;
		input_msg <= "11011011"; -- x"DB"
		cipher_mode <= '0'; -- encryption
		cipher_start <= '1';
		wait for GCLK_PERIOD;
		cipher_start <= '0';
		wait for GCLK_PERIOD;
		wait until ciph_finish = '1';
		wait for GCLK_PERIOD/2;
		if output_msg /= "00101000" then -- if not x"28"
			teststate <= error;
			report "test case 10: decryption error!" severity ERROR;
		else 
			teststate <= ok; 
		end if;
		wait for GCLK_PERIOD/2;

		wait for GCLK_PERIOD*5;
		
		-- end test process
		wait;
	end process;

end architecture;