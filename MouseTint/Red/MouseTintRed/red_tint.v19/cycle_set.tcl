
# Loop constraints
directive set /red_tint/core/main CSTEPS_FROM {{. == 2}}

# IO operation constraints
directive set /red_tint/core/main/io_read(mouse_xy:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/io_read(video_in:rsc.d)#1 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/io_write(video_out:rsc.d) CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /red_tint/core/main/else:else:acc#4 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/else:else:acc#3 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/else:else:acc#6 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/else:else:acc#5 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/makepos:and CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/makepos#1:and CSTEPS_FROM {{.. == 1}}
