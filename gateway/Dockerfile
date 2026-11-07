# --- BUILD STAGE ---
FROM node:24-alpine AS web-build

# ENV COREPACK_ENABLE_DOWNLOAD_PROMPT=0

RUN corepack enable && corepack prepare pnpm@12.8.1 --activate

WORKDIR /build

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY . ./

ARG VITE_API_BASE_URL=/api
ENV VITE_API_BASE_URL=${VITE_API_BASE_URL}

RUN pnpm build


# --- SERVE STAGE ---
FROM caddy:2-alpine

COPY gateway/Caddyfile /etc/caddy/Caddyfile
COPY --from=web-build /build/dist /srv

EXPOSE 80
EXPOSE 443
EXPOSE 443/udp
