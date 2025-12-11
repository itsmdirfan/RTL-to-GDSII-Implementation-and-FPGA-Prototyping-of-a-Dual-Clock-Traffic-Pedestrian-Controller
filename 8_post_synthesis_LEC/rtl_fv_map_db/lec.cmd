REAd IMplementation Information fv/top -revised fv_map
SET PARAllel Option -threads 1,4 -norelease_license
SET COmpare Options -threads 1,4
SET MUltiplier Implementation boothrca -both
SET UNDEfined Cell black_box -noascend -both
ADD SEarch Path /home/vlsi12/Downloads/scl_pdk/stdlib/fs120/liberty/lib_flow_ss -library -both
REAd LIbrary -liberty -both /home/vlsi12/Downloads/scl_pdk/stdlib/fs120/liberty/lib_flow_ss/tsl18fs120_scl_ss.lib
SET UNDRiven Signal 0 -golden
SET NAming Style genus -golden
SET NAming Rule %s[%d] -instance_array -golden
SET NAming Rule %s_reg -register -golden
SET NAming Rule %L.%s %L[%d].%s %s -instance -golden
SET NAming Rule %L.%s %L[%d].%s %s -variable -golden
SET NAming Rule -ungroup_separator _ -golden
SET HDl Options -const_port_extend
SET HDl Options -unsigned_conversion_overflow on
SET HDl Options -v_to_vd on
SET HDl Options -VERILOG_INCLUDE_DIR sep:src
DELete SEarch Path -all -design -golden
ADD SEarch Path /home/vlsi12/Desktop/EC1062/irfan_tra_ped_ctrl/1_src -design -golden
REAd DEsign -enumconstraint -define SYNTHESIS -merge bbox -golden -lastmod -noelab -sv09 /home/vlsi12/Desktop/EC1062/irfan_tra_ped_ctrl/1_src/top.v\
   /home/vlsi12/Desktop/EC1062/irfan_tra_ped_ctrl/1_src/traffic_fsm.v /home/vlsi12/Desktop/EC1062/irfan_tra_ped_ctrl/1_src/pedestrian_fsm.v\
   /home/vlsi12/Desktop/EC1062/irfan_tra_ped_ctrl/1_src/sync.v
ELAborate DEsign -golden -root top -rootonly
REAd DEsign -verilog95 -revised -lastmod -noelab fv/top/fv_map.v.gz
ELAborate DEsign -revised -root top
UNIQuify -all -nolib -golden
REPort DEsign Data
REPort BLack Box
SET FLatten Model -seq_constant
SET FLatten Model -seq_constant_x_to 0
SET FLatten Model -nodff_to_dlat_zero
SET FLatten Model -nodff_to_dlat_feedback
SET FLatten Model -hier_seq_merge
SET FLatten Model -balanced_modeling
CHEck VErification Information
SET ANalyze Option -auto -report_map
WRIte HIer_compare Dofile hier_tmp1.lec.do -verbose -noexact_pin_match -constraint -usage -replace -balanced_extraction\
   -input_output_pin_equivalence -prepend_string "report_design_data; report_unmapped_points -summary; report_unmapped_points -notmapped; analyze_datapath -module -verbose; eval analyze_datapath -flowgraph -verbose"
RUN HIer_compare hier_tmp1.lec.do -dynamic_hierarchy
REPort HIer_compare Result -dynamicflattened
REPort VErification -hier -verbose
SET SYstem Mode lec
WRIte COmpared Points noneq.compared_points.top.rtl.fv_map.tcl -class noneq -tclmode -replace
ANAlyze NOnequivalent -source_diagnosis
REPort NOnequivalent Analysis
REPort TEst Vector -noneq
SET SYstem Mode setup
WRIte VErification Information
REPort VErification Information
REPort IMplementation Information
SET SYstem Mode lec
ANAlyze RESults -logfiles fv/top/rtl_to_fv_map.log
REPort VErification -hier_result -detail -verbose
