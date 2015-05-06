
# Loop constraints
directive set /red_tint/core/main CSTEPS_FROM {{. == 2}}

# IO operation constraints
directive set /red_tint/core/main/io_write(video_out:rsc.d) CSTEPS_FROM {{.. == 1}}

# Real operation constraints
