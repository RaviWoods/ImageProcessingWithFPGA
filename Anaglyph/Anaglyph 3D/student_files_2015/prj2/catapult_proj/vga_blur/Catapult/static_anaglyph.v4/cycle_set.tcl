
# Loop constraints
directive set /static_anaglyph/core/main CSTEPS_FROM {{. == 2}}

# IO operation constraints
directive set /static_anaglyph/core/main/io_read(video_in:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/io_read(vga_xy:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/io_write(video_out:rsc.d) CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /static_anaglyph/core/main/if:acc CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/oelse:acc CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/and CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/and#1 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/and#2 CSTEPS_FROM {{.. == 1}}
