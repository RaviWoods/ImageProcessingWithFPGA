
# Loop constraints
directive set /red_tint/core/main CSTEPS_FROM {{. == 2}}

# IO operation constraints
directive set /red_tint/core/main/io_read(mouse_xy:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/io_read(video_in:rsc.d)#1 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/io_write(video_out:rsc.d) CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /red_tint/core/main/acc#4 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/acc CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/acc#8 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/acc#7 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/acc#12 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/acc#11 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/makepos:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/makepos:mux#1 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/makepos#1:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/makepos#1:mux#1 CSTEPS_FROM {{.. == 1}}
