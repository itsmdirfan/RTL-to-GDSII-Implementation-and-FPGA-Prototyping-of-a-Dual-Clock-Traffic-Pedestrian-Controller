setAnalysisMode -analysisType onChipVariation -cppr both
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postRoute
addFiller -cell feedth9 -prefix FILLER -doDRC
addFiller -cell feedth3 -prefix FILLER -doDRC
addFiller -cell feedth -prefix FILLER -doDRC
saveDesign top_post_route_and_filler
