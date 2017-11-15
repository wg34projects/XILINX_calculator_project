onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -color cyan -format Logic /tb_io_ctrl/clk_i
add wave -noupdate -height 30 -color red -format Logic /tb_io_ctrl/reset_i
add wave -noupdate -height 30 -format Logic /tb_io_ctrl/dig0_i
add wave -noupdate -height 30 -format Logic /tb_io_ctrl/dig1_i
add wave -noupdate -height 30 -format Logic /tb_io_ctrl/dig2_i
add wave -noupdate -height 30 -format Logic /tb_io_ctrl/dig3_i
add wave -noupdate -height 30 -color blue -format Logic /tb_io_ctrl/led_i
add wave -noupdate -height 30 -color blue -format Logic /tb_io_ctrl/led_o
add wave -noupdate -height 30 -color green -format Logic /tb_io_ctrl/sw_i
add wave -noupdate -height 30 -color green -format Logic /tb_io_ctrl/pb_i
add wave -noupdate -height 30 -color magenta -format Logic /tb_io_ctrl/ss_o
add wave -noupdate -height 30 -color magenta -format Logic /tb_io_ctrl/ss_sel_o
add wave -noupdate -height 30 -color yellow -format Logic /tb_io_ctrl/swsync_o
add wave -noupdate -height 30 -color yellow -format Logic /tb_io_ctrl/pbsync_o
add wave -noupdate -height 30 -format Unsigned /tb_io_ctrl/i_io_ctrl/s_enctr
add wave -noupdate -height 30 -format Logic /tb_io_ctrl/i_io_ctrl/s_1khzen
add wave -noupdate -height 30 -format Logic /tb_io_ctrl/i_io_ctrl/swsync
add wave -noupdate -height 30 -format Logic /tb_io_ctrl/i_io_ctrl/pbsync
add wave -noupdate -height 30 -format Logic /tb_io_ctrl/i_io_ctrl/s_ss_sel
add wave -noupdate -height 30 -format Logic /tb_io_ctrl/i_io_ctrl/s_ss
add wave -noupdate -height 30 -format Unsigned /tb_io_ctrl/i_io_ctrl/s_muxcnt
add wave -noupdate -height 30 -format Unsigned /tb_io_ctrl/i_io_ctrl/s_debcnt
add wave -noupdate -height 30 -format Unsigned /tb_io_ctrl/i_io_ctrl/s_button
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 250
configure wave -valuecolwidth 150
configure wave -signalnamewidth 0
configure wave -justifyvalue left
