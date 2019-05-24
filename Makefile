
BROTLI=third_party/brotli
COMMA:=,

SRCS=${BROTLI}/c/common/dictionary.c ${BROTLI}/c/common/transform.c ${BROTLI}/c/dec/bit_reader.c ${BROTLI}/c/dec/decode.c ${BROTLI}/c/dec/huffman.c ${BROTLI}/c/dec/state.c main.c
OBJS=$(SRCS:.c=.o)

SYSROOT=$$HOME/opt/wasi-sdk-5.0/opt/wasi-sdk/share/sysroot
TARGET=wasm32-unknown-wasi
EXPORTS=BrotliDecoderSetParameter BrotliDecoderCreateInstance BrotliDecoderDestroyInstance BrotliDecoderDecompress BrotliDecoderDecompressStream BrotliDecoderHasMoreOutput BrotliDecoderTakeOutput BrotliDecoderIsUsed BrotliDecoderIsFinished BrotliDecoderGetErrorCode BrotliDecoderErrorString BrotliDecoderVersion
EXPORT_FLAGS=$(addprefix -Wl$(COMMA)--export=,$(EXPORTS))

CFLAGS=-I${BROTLI}/c/include --sysroot $(SYSROOT) --target=$(TARGET)


all: brotlidec.wasm
clean:
	rm -f brotlidec.wasm $(OBJS)

brotlidec.wasm: $(OBJS)
	clang -Wl,--no-entry $(EXPORT_FLAGS) $(CFLAGS) -o $@ $^

%.o: %.c
	clang $(CFLAGS) -o $@ -c $<
