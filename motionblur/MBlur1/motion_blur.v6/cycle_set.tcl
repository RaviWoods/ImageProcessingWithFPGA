
# Loop constraints
directive set /motion_blur/core/core:rlp CSTEPS_FROM {{. == 0}}
directive set /motion_blur/core/core:rlp/main CSTEPS_FROM {{. == 2} {.. == 0}}

# IO operation constraints
directive set /motion_blur/core/core:rlp/main/SHIFT:if:else:else:if:io_read(vin:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/FRAME:io_write(vout:rsc.d) CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /motion_blur/core/core:rlp/main/ACC1:if#1:acc#31 CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/ACC1:if#1:acc CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/ACC1:if#1:acc#30 CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/ACC2-5:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/ACC1:if#1:acc#32 CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/ACC1:if#1:acc#34 CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/ACC1:if#1:acc#33 CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/ACC2-5:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/ACC1:if#1:acc#35 CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/ACC1:if#1:acc#37 CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/ACC1:if#1:acc#36 CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/ACC2-5:acc#3 CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/absmax:if:acc CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/absmax:else:acc CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/absmax:else:and CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/absmax#1:if:acc CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/absmax#1:else:acc CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/absmax#1:else:and CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/absmax#2:if:acc CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/absmax#2:else:acc CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/absmax#2:else:and CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/absmax:or CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/absmax#2:or CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/absmax#1:or CSTEPS_FROM {{.. == 1}}
