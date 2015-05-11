
# Loop constraints
directive set /edge_detect/core/core:rlp CSTEPS_FROM {{. == 0}}
directive set /edge_detect/core/core:rlp/main CSTEPS_FROM {{. == 3} {.. == 0}}

# IO operation constraints
directive set /edge_detect/core/core:rlp/main/SHIFT:if:else:else:if:io_read(vin:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/FRAME:io_write(vout:rsc.d) CSTEPS_FROM {{.. == 2}}

# Real operation constraints
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc#26 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc#25 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc#28 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc#27 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc#29 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc#31 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc#30 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc#33 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc#32 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc#34 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc#23 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc#36 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc#35 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc#38 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc#37 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc#39 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/ACC1:if:acc#24 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/absmax:if:acc CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/absmax:else:if:acc CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/absmax:else:else:acc CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/absmax#1:if:acc CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/absmax#1:else:if:acc CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/absmax#1:else:else:acc CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/absmax#2:if:acc CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/absmax#2:else:if:acc CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/absmax#2:else:else:acc CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/absmax#1:mux1h CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/absmax#2:mux1h CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/absmax:mux1h CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/acc CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#5 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#4 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#7 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#3 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#6 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#8 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/acc#1 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#9 CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#10 CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/acc#2 CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#12 CSTEPS_FROM {{.. == 1}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#14 CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#16 CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#23 CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#18 CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#20 CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#22 CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#11 CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#13 CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#15 CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#17 CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#19 CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#21 CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/FRAME:avg:acc#1 CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/absmax#3:if:acc CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/absmax#3:else:acc CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/absmax#3:else:else:acc CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/absmax#3:else:and CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/absmax#3:or CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/absmax#3:else:mux#1 CSTEPS_FROM {{.. == 2}}
directive set /edge_detect/core/core:rlp/main/absmax#3:or#1 CSTEPS_FROM {{.. == 2}}
