vsim -t ns -novopt -lib work work.tb_io_ctrl_cfg
view *
do io_ctrl_wave.do
run 50 ms
