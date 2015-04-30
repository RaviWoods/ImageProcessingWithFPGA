
# Loop constraints
directive set /diff_detect/core/main CSTEPS_FROM {{. == 2}}

# IO operation constraints
directive set /diff_detect/core/main/FRAME:io_read(vin:rsc.d)#1 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/main/ACC1:if:io_write(vout:rsc.d)#1 CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /diff_detect/core/main/ACC1:if:acc CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/main/abs#1:acc CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/main/abs#1:and CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/main/ACC1:if:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/main/abs#2:acc CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/main/abs#2:and CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/main/ACC1:if:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /diff_detect/core/main/ACC1:mux CSTEPS_FROM {{.. == 1}}
