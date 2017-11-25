onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -divider -height 30 "CLK, RESET"
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/clk_i
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/reset_i
add wave -divider -height 30 "INPUT"
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/swsync_i
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/pbsync_i
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/finished_i
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/result_i
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/sign_i
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/overflow_i
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/error_i
add wave -divider -height 30 "OUTPUT"
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/dig0_o
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/dig1_o
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/dig2_o
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/dig3_o
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/led_o
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/op1_o
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/op2_o
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/optype_o
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/start_o
add wave -divider -height 30 "INTERNAL SIGNALS"
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/i_calc_ctrl/state_s
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/i_calc_ctrl/readystate_s
add wave -noupdate -height 30 -format Logic /tb_calc_ctrl/i_calc_ctrl/buttonstate_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 300
configure wave -valuecolwidth 150
configure wave -signalnamewidth 0
configure wave -justifyvalue left
