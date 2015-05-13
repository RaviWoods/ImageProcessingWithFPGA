
# Loop constraints
directive set /static_anaglyph/core/main CSTEPS_FROM {{. == 4}}

# IO operation constraints
directive set /static_anaglyph/core/main/io_read(video_in:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if:io_read(avg:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/io_write(video_out:rsc.d) CSTEPS_FROM {{.. == 3}}

# Real operation constraints
directive set /static_anaglyph/core/main/acc#21 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#23 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#22 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#25 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#24 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#26 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#2 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#28 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#27 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#3 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#31 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#33 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#37 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#29 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#30 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#32 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#34 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#38 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#36 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/div CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#6 CSTEPS_FROM {{.. == 3}}
directive set /static_anaglyph/core/main/acc#7 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if:acc CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if:acc#4 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#12 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if:acc#3 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if:acc#2 CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/and CSTEPS_FROM {{.. == 3}}
directive set /static_anaglyph/core/main/mux#1 CSTEPS_FROM {{.. == 3}}
directive set /static_anaglyph/core/main/acc#19 CSTEPS_FROM {{.. == 3}}
directive set /static_anaglyph/core/main/acc#20 CSTEPS_FROM {{.. == 3}}
directive set /static_anaglyph/core/main/acc#14 CSTEPS_FROM {{.. == 3}}
directive set /static_anaglyph/core/main/rshift CSTEPS_FROM {{.. == 3}}
directive set /static_anaglyph/core/main/acc#17 CSTEPS_FROM {{.. == 3}}
directive set /static_anaglyph/core/main/rshift#4 CSTEPS_FROM {{.. == 3}}
directive set /static_anaglyph/core/main/rshift#2 CSTEPS_FROM {{.. == 3}}
directive set /static_anaglyph/core/main/rshift#5 CSTEPS_FROM {{.. == 3}}
directive set /static_anaglyph/core/main/acc#18 CSTEPS_FROM {{.. == 3}}
