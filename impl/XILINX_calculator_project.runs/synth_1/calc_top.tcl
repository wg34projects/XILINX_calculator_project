# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/helmutresch/WorkDir/XILINX_calculator_project/impl/XILINX_calculator_project.cache/wt [current_project]
set_property parent.project_path /home/helmutresch/WorkDir/XILINX_calculator_project/impl/XILINX_calculator_project.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
read_vhdl -library xil_defaultlib {
  /home/helmutresch/WorkDir/XILINX_calculator_project/vhdl/calc_ctrl_.vhd
  /home/helmutresch/WorkDir/XILINX_calculator_project/vhdl/io_ctrl_.vhd
  /home/helmutresch/WorkDir/XILINX_calculator_project/vhdl/alu_.vhd
  /home/helmutresch/WorkDir/XILINX_calculator_project/vhdl/calc_ctrl_rtl.vhd
  /home/helmutresch/WorkDir/XILINX_calculator_project/vhdl/io_ctrl_rtl.vhd
  /home/helmutresch/WorkDir/XILINX_calculator_project/vhdl/calc_top_.vhd
  /home/helmutresch/WorkDir/XILINX_calculator_project/vhdl/alu_rtl.vhd
  /home/helmutresch/WorkDir/XILINX_calculator_project/vhdl/calc_top_rtl.vhd
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/helmutresch/WorkDir/XILINX_calculator_project/impl/XILINX_calculator_project.srcs/constrs_1/new/XILINX_calculator_project_constrs.xdc
set_property used_in_implementation false [get_files /home/helmutresch/WorkDir/XILINX_calculator_project/impl/XILINX_calculator_project.srcs/constrs_1/new/XILINX_calculator_project_constrs.xdc]


synth_design -top calc_top -part xc7a35tcpg236-1


write_checkpoint -force -noxdef calc_top.dcp

catch { report_utilization -file calc_top_utilization_synth.rpt -pb calc_top_utilization_synth.pb }
