# simple-DES FSM edition testbench run
SetActiveLib -work
# compile round function files
comp -include "$dsn\src\rf_expand.vhd"
comp -include "$dsn\src\rf_xor_8.vhd"
comp -include "$dsn\src\rf_subst_1.vhd"
comp -include "$dsn\src\rf_subst_2.vhd"
comp -include "$dsn\src\rf_permute.vhd"
comp -include "$dsn\src\round_func.vhd"
# compile key expansion part
comp -include "$dsn\src\perm_choice1.vhd"
comp -include "$dsn\src\perm_choice2.vhd"
comp -include "$dsn\src\rk_reg.vhd"
comp -include "$dsn\src\rotate_rk.vhd"
comp -include "$dsn\src\key_mux.vhd"
comp -include "$dsn\src\rk_ram.vhd"
# compile main cipher components
comp -include "$dsn\src\init_perm.vhd"
comp -include "$dsn\src\init_perm_inv.vhd"
comp -include "$dsn\src\xor_4.vhd"
comp -include "$dsn\src\state_mux.vhd"
comp -include "$dsn\src\state_reg.vhd"
comp -include "$dsn\src\output_mux.vhd"
comp -include "$dsn\src\sdes_fsm.vhd"
comp -include "$dsn\src\hw_simple_des_fsm.bde"
# compile testbench
comp -include "$dsn\src\hw_simple_des_fsm_tb.vhd"
# begin simulation
asim +access +r hw_simple_des_fsm_tb
wave 
wave -noreg gclk
wave -noreg grst
wave -noreg -binary input_msg
wave -noreg cipher_mode
wave -noreg cipher_start
wave -noreg -binary cipher_key
wave -noreg load_new_key
wave -noreg -binary output_msg
wave -noreg ciph_finish
wave -noreg key_ready
wave -noreg UUT/U16/fsm_state
wave -noreg -color 0,150,150 -bold teststate
run 1130 ns