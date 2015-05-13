
# Loop constraints
directive set /static_anaglyph/core/main CSTEPS_FROM {{. == 3}}

# IO operation constraints
directive set /static_anaglyph/core/main/avg:io_read(avg:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/io_read(video_in:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:io_read(edge:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/io_write(video_out:rsc.d) CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/io_write(bw_out:rsc.d) CSTEPS_FROM {{.. == 2}}

# Real operation constraints
directive set /static_anaglyph/core/main/if:acc CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/else:if:acc CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/else:else:if:acc CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/else:else:else:if:acc CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/else:else:else:else:if:acc CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/else:else:else:else:else:if:acc CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/else:else:else:else:else:else:if:acc CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/else:else:else:else:else:else:else:if:acc CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/else:else:else:else:else:else:else:else:if:acc CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/else:else:else:else:else:else:else:else:mux CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#1 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:acc CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#2 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:acc#4 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:acc#3 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:acc#6 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:acc#5 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:acc#7 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#3 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:acc#9 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:acc#8 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/acc#4 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:acc#12 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:acc#14 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:acc#18 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:acc#10 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:acc#11 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:acc#13 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:acc#15 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:acc#19 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:acc#17 CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:if:acc CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:else:if:acc CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:else:else:if:acc CSTEPS_FROM {{.. == 1}}
directive set /static_anaglyph/core/main/if#8:else:else:else:if:acc CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/if#8:else:else:else:else:if:acc CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/if#8:else:else:else:else:else:if:acc CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/if#8:else:else:else:else:else:else:if:acc CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/if#8:else:else:else:else:else:else:else:if:acc CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/if#8:else:else:else:else:else:else:else:else:if:acc CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/if#8:else:else:else:else:else:else:else:else:mux CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/mux1h CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/acc CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/acc#12 CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/acc#7 CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/mux CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/acc#10 CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/mux#7 CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/mux#8 CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/mux#9 CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/acc#11 CSTEPS_FROM {{.. == 2}}
directive set /static_anaglyph/core/main/mux#4 CSTEPS_FROM {{.. == 1}}
