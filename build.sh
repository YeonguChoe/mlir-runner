INPUT_FILE="$1"
EXECUTABLE="$2"

echo "Start building script"

mlir-opt "$INPUT_FILE" --allow-unregistered-dialect --convert-to-llvm \
| mlir-translate --mlir-to-llvmir \
| clang -x ir - -o "$EXECUTABLE"

if [ $? -eq 0 ]; then
    echo "Building executable file: $EXECUTABLE"
else
    echo "Error: Build failed."
    exit 1
fi


# Run executable file
./"$EXECUTABLE"
echo $?