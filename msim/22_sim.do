vsim -t ns -novopt -lib work work.tb_calc_ctrl
view *
do calc_ctrl_wave.do
run 120 ms
