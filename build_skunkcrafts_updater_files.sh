#!/bin/bash

# Delete old files
rm -f skunkcrafts_updater_whitelist.txt || true
rm -f skunkcrafts_updater_sizeslist.txt || true

find plugins -type f -print0 | sort -z | while read -d $'\0' file; do
    echo "${file}"

    # Get CRC32 checksum
    checksum=$(crc32 "${file}")  # hexadecimal
    checksum=$((0x${checksum}))  # convert into decimal

    # Get file size in bytes
    if [[ "${OSTYPE}" == "linux"* ]]; then
        size=$(stat -c%s "${file}")
    elif [[ "${OSTYPE}" == "darwin"* ]]; then
        size=$(stat -f%z "${file}")
    fi

    # Write skunkcrafts_updater_whitelist.txt
    echo "${file}|${checksum}" >> skunkcrafts_updater_whitelist.txt

    # Write skunkcrafts_updater_sizeslist.txt
    echo "${file}|${size}" >> skunkcrafts_updater_sizeslist.txt
done

# Create empty skunkcrafts_updater_blacklist.txt file
touch skunkcrafts_updater_blacklist.txt
