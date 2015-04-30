
# Loop constraints
directive set /diff_detect/core/core:rlp CSTEPS_FROM {{. == 0}}
directive set /diff_detect/core/core:rlp/main CSTEPS_FROM {{. == 2} {.. == 0}}

# IO operation constraints
directive set /diff_detect/core/core:rlp/main/FRAME:io_read(vin:rsc_2_0.d)#2 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/FRAME:io_read(vin:rsc_1_0.d)#1 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/FRAME:io_read(vin:rsc_3_0.d)#3 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/FRAME:io_read(vin:rsc_0_0.d) CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/FRAME:io_read(vin:rsc_4_0.d)#4 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/ACC1:if:io_write(vout:rsc.d)#1 CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /diff_detect/core/core:rlp/main/SHIFT:mux CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:mux#1 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:mux#2 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:mux#3 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:mux#4 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:mux#5 CSTEPS_FROM {{.. == 1}}
directive set {/diff_detect/core/core:rlp/main/regs.operator[]:mux} CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/ACC1:if:acc CSTEPS_FROM {{.. == 1}}
directive set {/diff_detect/core/core:rlp/main/regs.operator[]#1:mux} CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/abs#1:acc CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/abs#1:and CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/ACC1:if:acc#1 CSTEPS_FROM {{.. == 1}}
directive set {/diff_detect/core/core:rlp/main/regs.operator[]#2:mux} CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/abs#2:acc CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/abs#2:and CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/ACC1:if:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/ACC1:mux CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/ACC1:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/ACC1:acc CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:if:else:else:else:acc CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:if:else:else:else:mux CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:and#2 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:mux#9 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:mux#10 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:mux#11 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:mux#12 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:mux#17 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:mux#18 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:mux#23 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:mux#24 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:mux#25 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:mux#26 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:mux#27 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/core:rlp/main/SHIFT:mux#29 CSTEPS_FROM {{.. == 1}}
