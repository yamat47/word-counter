# Word Counter

Counts the words and characters in your text as you type. It is a static single-page app: the text never leaves the browser.

https://yamat47.github.io/word-counter/

## What it counts

| Count                  | How                                                                                             |
| ---------------------- | ----------------------------------------------------------------------------------------------- |
| Words                  | Runs of text separated by whitespace. Text written without spaces counts as one word.           |
| Characters             | Characters as a reader sees them (grapheme clusters), so 👨‍👩‍👧 is 1. Spaces and line breaks count. |
| Characters (no spaces) | The same, with all whitespace removed first.                                                    |

## Development

Everything runs in Docker; nothing else needs to be installed on your machine.

```sh
docker compose up
```

Open http://localhost:5173/word-counter/. Edits under `src/` reload in the browser.

Dependencies are installed into a Docker volume when the container starts. The `node_modules` directory that appears on the host is an empty mount point.

### Checks

```sh
docker compose run --rm app pnpm test          # unit tests (Vitest)
docker compose run --rm app pnpm lint          # Oxlint, including type-aware rules
docker compose run --rm app pnpm typecheck     # tsc
docker compose run --rm app pnpm format        # Oxfmt (format:check only reports)
docker compose run --rm app pnpm build         # production build into dist/
```

To add or update a package, run pnpm the same way, for example `docker compose run --rm app pnpm add -D <package>`. The Node.js version is set in two places that must stay equal: `Dockerfile` for development and `.node-version` for CI. After changing it, or the pnpm version in `package.json`, rebuild with `docker compose build`.

## Deployment

Every push to `main` builds the site and publishes it to GitHub Pages through `.github/workflows/deploy.yml`. The site is served under `/word-counter/`, which is set as `base` in `vite.config.ts`.

## Project structure

```
src/
  counter.ts   # counting logic, no DOM
  app.ts       # connects the textarea to the counts
  main.ts      # entry point
  style.css
index.html
Dockerfile, compose.yaml, docker/   # development container
.github/workflows/                  # CI and deployment
.claude/skills/                     # agent skills from yamat47/github-toolkit
```

## Disclaimer

- Count results are for reference only and may vary based on language and character handling
- We are not responsible for any damages resulting from use of this tool
