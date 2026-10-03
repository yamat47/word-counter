FROM node:24-bookworm-slim

# Corepack installs the pnpm version named by "packageManager" in package.json.
ENV COREPACK_ENABLE_DOWNLOAD_PROMPT=0
RUN corepack enable pnpm

WORKDIR /app

# The node_modules volume is created from this directory and inherits its
# owner; without it the volume would belong to root and pnpm could not write.
RUN mkdir node_modules && chown node:node /app node_modules

COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh

USER node

# pnpm fetches its own binary on first use. Running it here keeps that
# download in the image; otherwise every new container repeats it.
COPY package.json ./
RUN corepack install && pnpm --version

ENTRYPOINT ["entrypoint.sh"]
CMD ["pnpm", "dev"]
