
datatype = "f16"
benchmark = "blackscholes"

set terminal svg
set output sprintf("%s-%s.svg", benchmark, datatype)

set title "Black-Scholes (Float16)"

array sizes = [100, 1000, 10000, 25000, 50000, 75000, 100000, 250000, 500000, 750000, 1000000, 2500000, 5000000, 7500000, 10000000]

function $filename(arch, size) <<EOF
  return sprintf("Current_run.bench-%s.%s_%s_%s_%d.wallClock.histogram.samples.tsv", \
      benchmark, \
      benchmark, \
      arch, \
      datatype, \
      size)
EOF

function $generate_data(arch) <<EOF
  print("# N min lo_quartile median up_quartile max mean ssd")
  do for [i = 1:15] {
    size = sizes[i]
    file = $filename(arch, size)

    stats file skip 1 nooutput
    if (GPVAL_ERRNO) {
      # printerr GPVAL_ERRMSG
      return 1
    }

    print sprintf("%d %f %f %f %f %f %f %f", \
        size,                                \
        STATS_min * 1e-6,                    \
        STATS_lo_quartile * 1e-6,            \
        STATS_median * 1e-6,                 \
        STATS_up_quartile * 1e-6,            \
        STATS_max * 1e-6,                    \
        STATS_mean * 1e-6,                   \
        STATS_ssd * 1e-6)
  }
  return 0
EOF

# Load data into separate data blocks
set print $cpu append
_ = $generate_data("cpu", datatype)
set print

set print $cpu_safe append
_ = $generate_data("cpu_generic_safe", datatype)
set print

set print $ptx append
_ = $generate_data("ptx", datatype)
set print

set print $cuda append
_ = $generate_data("cuda", datatype)
set print

set key on
set key top left

set xlabel "# Elements"
set logscale x
set xrange [50:15000000]

set ylabel "WallClock Time (ms)"
set logscale y

set grid xtics ytics

set errorbars 2
# set style fill empty

plot $ptx      using 1:3:2:6:5          with candlesticks      lt 1 lw 1 title 'Swift-to-PTX' whiskerbars 0.5, \
     ''        using 1:4:4:4:4          with candlesticks      lt 1 lw 1 notitle, \
     ''        using 1:7:7:7:7          with candlesticks dt 3 lt 1 lw 1 notitle, \
     ''        using 1:4                with lines        dt 3 lt 1 lw 1 notitle, \
     $cpu_safe using ($1-$1/20):3:2:6:5 with candlesticks      lt 2 lw 1 title 'Swift' whiskerbars 0.5, \
     ''        using ($1-$1/20):4:4:4:4 with candlesticks      lt 2 lw 1 notitle, \
     ''        using ($1-$1/20):7:7:7:7 with candlesticks dt 3 lt 2 lw 1 notitle, \
     ''        using ($1-$1/20):4       with lines        dt 3 lt 2 lw 1 notitle, \
     $cpu      using ($1-$1/20):3:2:6:5 with candlesticks      lt 3 lw 1 title 'Swift (unsafe)' whiskerbars 0.5, \
     ''        using ($1-$1/20):4:4:4:4 with candlesticks      lt 3 lw 1 notitle, \
     ''        using ($1-$1/20):7:7:7:7 with candlesticks dt 3 lt 3 lw 1 notitle, \
     ''        using ($1-$1/20):4       with lines        dt 3 lt 3 lw 1 notitle, \
     $cuda     using ($1+$1/20):3:2:6:5 with candlesticks      lt 4 lw 1 title 'CUDA' whiskerbars 0.5, \
     ''        using ($1+$1/20):4:4:4:4 with candlesticks      lt 4 lw 1 notitle, \
     ''        using ($1+$1/20):7:7:7:7 with candlesticks dt 3 lt 4 lw 1 notitle, \
     ''        using ($1+$1/20):4       with lines        dt 3 lt 4 lw 1 notitle

