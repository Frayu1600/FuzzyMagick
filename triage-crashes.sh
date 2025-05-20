#!/bin/bash

# create directory if not there 
mkdir -p "$UNIQUE_DIR"
declare -A seen_traces

# save current ASLR setting
ASLR_SETTING=$(cat /proc/sys/kernel/randomize_va_space)

# temporarily disable ASLR
echo 0 | sudo tee /proc/sys/kernel/randomize_va_space > /dev/null
echo "Temporarily disabled ASLR (was $ASLR_SETTING)"

# loop through all the crashes 
for crash in afl-tests/png-out/default/crashes/id:*; do
    [[ -f "$crash" ]] || continue

    # execute the line and filter the top line 
    trace_line=$(./ImageMagick-6.7.7-10/utilities/identify "$crash" 2>&1 | grep -m1 '^[[:space:]]*#0')

    # hash it for fast comparison 
    hash=$(echo "$trace_line" | md5sum | awk '{print $1}')

    # check if already exists
    if [[ -z "${seen_traces[$hash]}" ]]; then
        echo "Unique crash: $crash ($trace_line)"
        cp "$crash" unique_crashes/
        seen_traces["$hash"]=1
    fi
done

# restore ASLR settings
echo "$ASLR_SETTING" | sudo tee /proc/sys/kernel/randomize_va_space > /dev/null
echo "Restored ASLR to $ASLR_SETTING"