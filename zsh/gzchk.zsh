# gzchk returns the CRC32 checksum encoded in the trailed of a gzip-encoded
# file.
function gzsum() {
    [ $# -ge 1 -a -f "$1" ] && input="$1" || input="-"
    cat $input | tail -c8 | head -c4 | xxd -p
}
