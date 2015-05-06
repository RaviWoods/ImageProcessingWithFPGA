
# Loop constraints
directive set /red_tint/core/main CSTEPS_FROM {{. == 2}}

# IO operation constraints
directive set /red_tint/core/main/io_read(video_in:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/io_read(mouse_xy:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/io_write(video_out:rsc.d) CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /red_tint/core/main/acc CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/else:acc CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/else:else:acc#3 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/makepos:else:or CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/makepos:else:or#1 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/makepos:and CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/makepos:and#1 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/else:else:acc CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/makepos#1:else:or CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/makepos#1:else:or#1 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/makepos#1:and CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/makepos#1:and#1 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/else:and CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/else:and#1 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/else:and#2 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/and CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/mux#3 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/mux#4 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/else:mux#5 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/and#1 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/else:mux#6 CSTEPS_FROM {{.. == 1}}
directive set /red_tint/core/main/and#2 CSTEPS_FROM {{.. == 1}}
