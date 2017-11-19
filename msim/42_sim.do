vsim -t ns -novopt -lib work work.tb_calc_top
view *
do calc_top_wave.do
run 40 ms
