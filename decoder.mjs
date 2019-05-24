
// node --experimental-modules --experimental-wasm-modules decoder.mjs

import * as decoder from './brotlidec.wasm';

console.dir(decoder);

console.dir(decoder.BrotliDecoderVersion());