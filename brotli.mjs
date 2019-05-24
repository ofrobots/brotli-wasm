
// node --experimental-modules --experimental-wasm-modules decoder.mjs

import * as brotli from './brotli.wasm';

console.dir(brotli);

console.dir(brotli.BrotliDecoderVersion().toString(16));


  const input = Int8Array.from([
    0x1b, 0x03, 0x00, 0x00, 0x00, 0x00, 0x80, 0xe3, 0xb4, 0x0d, 0x00, 0x00,
    0x07, 0x5b, 0x26, 0x31, 0x40, 0x02, 0x00, 0xe0, 0x4e, 0x1b, 0x41, 0x02
  ]);

const output = new Int8Array(100);

const state = brotli.BrotliDecoderCreateInstance();

brotli.BrotliDecoderDecompressStream(input.length, input, output.length, output);
console.log('output', output);