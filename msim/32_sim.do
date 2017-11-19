vsim -t ns -novopt -lib work work.tb_alu_cfg
view *
do alu_wave.do
run 35 ms
