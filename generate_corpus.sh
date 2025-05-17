# AFL++ corpus generator  
# generates 5 noisy pictures inside afl-tests/png-in/
for i in {1..5}; do
  SIZE=$((RANDOM % 40 + 10))    # between 10x10 and 50x50
  ImageMagick-6.7.7-10/utilities/convert -size ${SIZE}x${SIZE} plasma:fractal afl-tests/png-in/noise_$i.png
done
