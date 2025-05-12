for i in {1..5}; do
  SIZE=$((RANDOM % 40 + 10))    # between 10x10 and 50x50
  convert -size ${SIZE}x${SIZE} plasma:fractal noise_$i.png
done
