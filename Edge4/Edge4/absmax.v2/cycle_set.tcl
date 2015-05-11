
# Loop constraints
directive set /absmax/core/main CSTEPS_FROM {{. == 2}}

# IO operation constraints
directive set /absmax/core/main/x:io_read(x:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /absmax/core/main/io_write(absmax.return:rsc.d) CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /absmax/core/main/if:acc CSTEPS_FROM {{.. == 1}}
directive set /absmax/core/main/else:acc CSTEPS_FROM {{.. == 1}}
directive set /absmax/core/main/else:else:acc CSTEPS_FROM {{.. == 1}}
directive set /absmax/core/main/mux1h CSTEPS_FROM {{.. == 1}}
