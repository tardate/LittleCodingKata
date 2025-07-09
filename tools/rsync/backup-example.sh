#!/usr/bin/env bash

./make_example_source.sh

source_path=./tmp/original/
destination_path=./tmp/copy/

function do_sync() {
    rsync -av ${source_path} ${destination_path}
}

echo "## performs the initial sync: ${source_path} to ${destination_path}"
rm -fR ${destination_path}
do_sync

echo "## handles new files added to the source: add 3.txt to source"
echo "3" > ${source_path}3.txt
do_sync

echo "## handles modified files in to the source: update 2.txt in source"
echo "2 - updated" > ${source_path}/2.txt
do_sync

echo "## handles files removed from the destination: removing 1.txt from dest"
rm ${destination_path}/1.txt
do_sync

echo "## ignores additional files in the destination: add bogus.txt to dest"
echo "ignore me" > ${destination_path}/bogus.txt
do_sync

echo "## updates modified files in the destination: update 2.txt in dest"
echo "2 - updated in dest" > ${destination_path}/2.txt
do_sync

echo "## shows the differences between source and destination"
diff ${source_path} ${destination_path}
