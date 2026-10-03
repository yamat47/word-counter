import { defineConfig } from 'vitest/config';

export default defineConfig({
  // Relative, so the same build works at https://word-counter.yamat47.me/ and under
  // https://yamat47.github.io/word-counter/, whichever GitHub Pages serves it from.
  base: './',
  // The dev server runs in a container, so it has to listen beyond the container's loopback.
  server: { host: true },
  preview: { host: true },
});
