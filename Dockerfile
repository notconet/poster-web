FROM node:24-alpine AS web-build

WORKDIR /app

# ENV COREPACK_ENABLE_DOWNLOAD_PROMPT=0

RUN corepack enable && corepack prepare pnpm@12.8.1 --activate

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY . ./

ARG VITE_API_BASE_URL=/api
ARG HOST=0.0.0.0
ARG PORT=5173

ENV VITE_API_BASE_URL=${VITE_API_BASE_URL}
ENV HOST=${HOST}
ENV PORT=${PORT}

EXPOSE ${PORT}

CMD pnpm dev --host ${HOST} --port ${PORT}
