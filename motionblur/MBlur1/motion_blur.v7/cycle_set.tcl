
# Loop constraints
directive set /motion_blur/core/core:rlp CSTEPS_FROM {{. == 0}}
directive set /motion_blur/core/core:rlp/main CSTEPS_FROM {{. == 2} {.. == 0}}

# IO operation constraints
directive set /motion_blur/core/core:rlp/main/FRAME:io_write(vout:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/SHIFT:if:else:else:if:io_read(vin:rsc.d) CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /motion_blur/core/core:rlp/main/absmax:else:acc CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/absmax:else:and CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/absmax#2:else:acc CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/absmax#2:else:and CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/absmax#1:else:acc CSTEPS_FROM {{.. == 1}}
directive set /motion_blur/core/core:rlp/main/absmax#1:else:and CSTEPS_FROM {{.. == 1}}
