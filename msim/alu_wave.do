onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -color cyan -format Logic /tb_alu/clk_i
add wave -noupdate -height 30 -color red -format Logic /tb_alu/reset_i
add wave -noupdate -height 30 -format Hexadecimal -color yellow -format Decimal /tb_alu/op1_i
add wave -noupdate -height 30 -format Hexadecimal -color yellow -format Decimal /tb_alu/op2_i
add wave -noupdate -height 30 -color yellow -format Logic /tb_alu/optype_i
add wave -noupdate -height 30 -color yellow -format Logic /tb_alu/start_i
add wave -noupdate -height 30 -color yellow -format Logic /tb_alu/finished_o
add wave -noupdate -height 30 -color yellow -format Decimal /tb_alu/result_o
add wave -noupdate -height 30 -color yellow -format Logic /tb_alu/sign_o
add wave -noupdate -height 30 -color yellow -format Logic /tb_alu/overflow_o
add wave -noupdate -height 30 -color yellow -format Logic /tb_alu/error_o
add wave -noupdate -height 30 -color yellow -format Decimal /tb_alu/i_alu/oddNumber_s
add wave -noupdate -height 30 -color yellow -format Decimal /tb_alu/i_alu/workNumber1_s
add wave -noupdate -height 30 -color yellow -format Decimal /tb_alu/i_alu/workNumber2_s
add wave -noupdate -height 30 -color yellow -format Decimal /tb_alu/i_alu/sqrtCount_s
add wave -noupdate -height 30 -color yellow -format Logic /tb_alu/i_alu/finished_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 300
configure wave -valuecolwidth 150
configure wave -signalnamewidth 0
configure wave -justifyvalue left
