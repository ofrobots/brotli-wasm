
BROTLI=third_party/brotli
SYSROOT=$$HOME/opt/wasi-sdk-5.0/opt/wasi-sdk/share/sysroot
TARGET=wasm32-unknown-wasi
COMMA:=,

SOURCES=$(wildcard ${BROTLI}/c/common/*.c) $(wildcard ${BROTLI}/c/dec/*.c) \
	$(wildcard ${BROTLI}/c/enc/*.c) main.o
OBJECTS=$(SOURCES:.c=.o)


EXPORTS=BrotliDecoderSetParameter BrotliDecoderCreateInstance BrotliDecoderDestroyInstance BrotliDecoderDecompress BrotliDecoderDecompressStream BrotliDecoderHasMoreOutput BrotliDecoderTakeOutput BrotliDecoderIsUsed BrotliDecoderIsFinished BrotliDecoderGetErrorCode BrotliDecoderErrorString BrotliDecoderVersion BrotliEncoderSetParameter BrotliEncoderCreateInstance BrotliEncoderDestroyInstance BrotliEncoderMaxCompressedSize BrotliEncoderCompress BrotliEncoderCompressStream BrotliEncoderIsFinished BrotliEncoderHasMoreOutput BrotliEncoderTakeOutput BrotliEncoderVersion _start malloc

EXPORT_FLAGS=$(addprefix -Wl$(COMMA)--export=,$(EXPORTS))

CFLAGS=-I${BROTLI}/c/include --sysroot $(SYSROOT) --target=$(TARGET)

.PHONY: all clean

all: brotli.wasm
clean:
	rm -f brotli.wasm $(OBJECTS)

brotli.wasm: $(OBJECTS)
	clang -Wl,--no-entry $(EXPORT_FLAGS) $(CFLAGS) -o $@ $^

%.o: %.c
	clang $(CFLAGS) -o $@ -c $<
