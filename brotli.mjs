
// node --experimental-modules --experimental-wasm-modules decoder.mjs

import * as decoder from './brotli.wasm';

console.dir(decoder);

console.dir(decoder.BrotliDecoderVersion().toString(16));

// BROTLI_DEC_API BrotliDecoderResult BrotliDecoderDecompress(
//     size_t encoded_size,
//     const uint8_t encoded_buffer[BROTLI_ARRAY_PARAM(encoded_size)],
//     size_t* decoded_size,
//     uint8_t decoded_buffer[BROTLI_ARRAY_PARAM(*decoded_size)]);
// BROTLI_DEC_API BrotliDecoderResult BrotliDecoderDecompressStream(
//   BrotliDecoderState* state, size_t* available_in, const uint8_t** next_in,
//   size_t* available_out, uint8_t** next_out, size_t* total_out);



  const input = Int8Array.from([
    0x1b, 0x03, 0x00, 0x00, 0x00, 0x00, 0x80, 0xe3, 0xb4, 0x0d, 0x00, 0x00,
    0x07, 0x5b, 0x26, 0x31, 0x40, 0x02, 0x00, 0xe0, 0x4e, 0x1b, 0x41, 0x02
  ]);

const output = new Int8Array(100);

const state = decoder.BrotliDecoderCreateInstance();

decoder.BrotliDecoderDecompressStream(input.length, input, output.length, output);
console.log(output);