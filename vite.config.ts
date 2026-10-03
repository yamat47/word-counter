import { defineConfig } from 'vitest/config';

export default defineConfig({
  // GitHub Pages serves the site from https://yamat47.github.io/word-counter/.
  base: '/word-counter/',
  // The dev server runs in a container, so it has to listen beyond the container's loopback.
  server: { host: true },
  preview: { host: true },
});
