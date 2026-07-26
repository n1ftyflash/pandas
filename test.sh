#!/bin/bash

if [ "$1" = "--output_path" ]; then
    OUTPUT_PATH="$2"
    MODE="$3"
else
    MODE="$1"
    OUTPUT_PATH="$2"
fi

cd /app || exit 1

python -c "import sys; print(sys.executable); print(sys.path)"
python -c "import pandas; print(pandas.__file__)"

case "$MODE" in
    base)
        python -m pytest pandas/tests/io/test_parquet.py \
            -k "not test_roundtrip_arrow_list_string_dtype" \
            --junitxml="$OUTPUT_PATH"
        ;;
    new)
        python -m pytest pandas/tests/io/test_parquet.py \
            -k "test_roundtrip_arrow_list_string_dtype" \
            --junitxml="$OUTPUT_PATH"
        ;;
    *)
        echo "Usage: $0 [--output_path <path>] <base|new>"
        exit 1
        ;;
esac

exit $?