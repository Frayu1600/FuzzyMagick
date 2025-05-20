for crash in unique_crashes/id:*; do
    echo $'\n'"$crash"
    ./ImageMagick-6.7.7-10/utilities/identify "$crash"
done 