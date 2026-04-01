#!/bin/sh
set -e

INPUT_DIR="${INPUT_DIR:-/input}"
CHDMAN_MODE="${CHDMAN_MODE:-createcd}"

CHDMAN_VERSION=$(chdman 2>&1 | head -1 || true)

echo "======================================="
echo " CHDMan Walker"
echo "======================================="
echo "Version   : $CHDMAN_VERSION"
echo "Mode      : $CHDMAN_MODE"
echo "Directory : $INPUT_DIR"
echo "======================================="

convert_to_chd() {
    src="$1"
    mode="$2"
    chd="${src%.*}.chd"

    if [ -f "$chd" ]; then
        echo "[SKIP]    $chd already exists"
        return 0
    fi

    echo "[CONVERT] $src"
    chdman "$mode" -i "$src" -o "$chd"
    echo "[DONE]    $chd"
}

extract_from_chd() {
    src="$1"
    mode="$2"
    ext="$3"
    out="${src%.*}.${ext}"

    if [ -f "$out" ]; then
        echo "[SKIP]    $out already exists"
        return 0
    fi

    echo "[EXTRACT] $src"
    chdman "$mode" -i "$src" -o "$out"
    echo "[DONE]    $out"
}

case "$CHDMAN_MODE" in
    createcd)
        echo "Scanning for GDI, CUE and ISO files..."
        find "$INPUT_DIR" -type f \( -iname "*.gdi" -o -iname "*.cue" -o -iname "*.iso" \) | sort | while read -r f; do
            convert_to_chd "$f" createcd
        done
        ;;
    createdvd)
        echo "Scanning for ISO files..."
        find "$INPUT_DIR" -type f -iname "*.iso" | sort | while read -r f; do
            convert_to_chd "$f" createdvd
        done
        ;;
    extractcd)
        echo "Scanning for CHD files..."
        find "$INPUT_DIR" -type f -iname "*.chd" | sort | while read -r f; do
            extract_from_chd "$f" extractcd cue
        done
        ;;
    extractdvd)
        echo "Scanning for CHD files..."
        find "$INPUT_DIR" -type f -iname "*.chd" | sort | while read -r f; do
            extract_from_chd "$f" extractdvd iso
        done
        ;;
    *)
        echo "[ERROR] Unknown mode: $CHDMAN_MODE"
        echo "Valid modes: createcd, createdvd, extractcd, extractdvd"
        exit 1
        ;;
esac

echo "======================================="
echo " All done!"
echo "======================================="
