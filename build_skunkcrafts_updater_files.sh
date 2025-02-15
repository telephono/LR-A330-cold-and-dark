#!/bin/bash

# Check for crc32
if ! hash crc32 2>/dev/null; then
    printf "Command not found: crc32.\n"
    exit 1;
fi

# We only accept a directory as input argument
if [[ ! -d "$1" ]]; then
    printf "%s is not a directory. Aborting.\n" "$1"
    exit 1
fi

# Delete old files
rm -f skunkcrafts_updater_whitelist.txt || true
rm -f skunkcrafts_updater_sizeslist.txt || true
rm -f skunkcrafts_updater_blacklist.txt || true

# Prepare an empty array for ignored files
skunkcrafts_updater_ignore_files=()

# Read lines from skunkcrafts_updater_ignore.txt, skipping # comments
while IFS= read -r line; do
    # Trim whitespace
    line="$(echo -e "$line" | tr -d '[:space:]')"

    # Trim leading ./
    line=${line/#\.\//}

    # Skip empty lines
    [[ "$line" == "" ]] && continue

    # Skip files that don't exists
    [[ ! -f "$line" ]] && continue

    # Add line to ignored files
    skunkcrafts_updater_ignore_files+=("$line")
done < <(grep -v '^ *#' ./skunkcrafts_updater_ignore.txt | sort)

# Output ignored files, if there are any...
if [[ "${#skunkcrafts_updater_ignore_files[@]}" != 0 ]]; then
    printf "Ignoring files:\n"
    for value in "${skunkcrafts_updater_ignore_files[@]}"; do
        # Output filename in red
        printf "\033[0;31m%s\033[0m\n" "$value"
    done
    printf "\n"
fi

printf "Processing files:\n"
find "$1" -type f -print0 | sort -z | while read -rd $'\0' file; do
    # Trim leading ./ if present...
    file=${file/#\.\//}

    # Ignore .git*
    [[ $file == .git* ]] && continue

    # Skip files in skunkcrafts_updater_ignore.txt
    ignored=false
    for value in "${skunkcrafts_updater_ignore_files[@]}"; do
        [[ "$file" == "$value" ]] && ignored=true; break
    done
    [[ $ignored == true ]] && continue

    # Get CRC32 checksum
    checksum=$(crc32 "${file}")  # hexadecimal
    checksum=$((0x${checksum}))  # convert into decimal

    # Get file size in bytes
    if [[ "${OSTYPE}" == "linux"* ]]; then
        size=$(stat -c%s "${file}")
    elif [[ "${OSTYPE}" == "darwin"* ]]; then
        size=$(stat -f%z "${file}")
    fi

    # Output filename in green
    printf "\033[0;32m%s\033[0m\n" "${file}"

    # Write skunkcrafts_updater_whitelist.txt
    echo "${file}|${checksum}" >> skunkcrafts_updater_whitelist.txt

    # Write skunkcrafts_updater_sizeslist.txt
    echo "${file}|${size}" >> skunkcrafts_updater_sizeslist.txt
done

# Create empty skunkcrafts_updater_blacklist.txt file
touch skunkcrafts_updater_blacklist.txt
