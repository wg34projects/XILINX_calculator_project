onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -divider -height 30 "CLK, RESET"
add wave -noupdate -height 30 -format Logic /tb_calc_top/clk_i
add wave -noupdate -height 30 -format Logic /tb_calc_top/reset_i
add wave -divider -height 30 "INPUT"
add wave -noupdate -height 30 -format Logic /tb_calc_top/sw_i
add wave -noupdate -height 30 -format Logic /tb_calc_top/pb_i
add wave -divider -height 30 "OUTPUT"
add wave -noupdate -height 30 -format Logic /tb_calc_top/ss_o
add wave -noupdate -height 30 -format Logic /tb_calc_top/ss_sel_o
add wave -noupdate -height 30 -format Logic /tb_calc_top/led_o
add wave -divider -height 30 "INTERNAL SIGNALS"
add wave -noupdate -height 30 -format Logic /tb_calc_top/i_calc_top/dig0
add wave -noupdate -height 30 -format Logic /tb_calc_top/i_calc_top/dig1
add wave -noupdate -height 30 -format Logic /tb_calc_top/i_calc_top/dig2
add wave -noupdate -height 30 -format Logic /tb_calc_top/i_calc_top/dig3
add wave -noupdate -height 30 -format Logic /tb_calc_top/i_calc_top/led
add wave -noupdate -height 30 -format Logic /tb_calc_top/i_calc_top/swsync
add wave -noupdate -height 30 -format Logic /tb_calc_top/i_calc_top/pbsync
add wave -noupdate -height 30 -format Logic /tb_calc_top/i_calc_top/finished
add wave -noupdate -height 30 -format Decimal /tb_calc_top/i_calc_top/result
add wave -noupdate -height 30 -format Logic /tb_calc_top/i_calc_top/sign
add wave -noupdate -height 30 -format Logic /tb_calc_top/i_calc_top/overflow
add wave -noupdate -height 30 -format Logic /tb_calc_top/i_calc_top/errors
add wave -noupdate -height 30 -format Decimal /tb_calc_top/i_calc_top/op1
add wave -noupdate -height 30 -format Decimal /tb_calc_top/i_calc_top/op2
add wave -noupdate -height 30 -format Logic /tb_calc_top/i_calc_top/optype
add wave -noupdate -height 30 -format Logic /tb_calc_top/i_calc_top/start
add wave -divider -height 30 "FMS state"
add wave -noupdate -height 30 -format Logic /tb_calc_top/i_calc_top/i_calc_ctrl/buttonstate_s
add wave -noupdate -height 30 -format Logic /tb_calc_top/i_calc_top/i_calc_ctrl/state_s 
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 300
configure wave -valuecolwidth 200
configure wave -signalnamewidth 0
configure wave -justifyvalue left
