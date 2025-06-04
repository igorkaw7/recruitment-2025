ARG NODE_VERSION=20

# ---------- dependencies -----------------------------------------------------
FROM node:${NODE_VERSION}-alpine AS deps
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci

# ---------- dev image --------------------------------------------------------
FROM node:${NODE_VERSION}-alpine AS dev
WORKDIR /usr/src/app
COPY --from=deps /usr/src/app/node_modules ./node_modules
COPY . .
ENV NODE_ENV=development
LABEL stage=dev \
      org.opencontainers.image.title="WeatherApp Backend (Dev)" \
      org.opencontainers.image.description="API with hot-reload" \
      org.opencontainers.image.source="https://github.com/igorkaw7/recruitment-2025" \
      org.opencontainers.image.licenses="MIT"
EXPOSE 9000
CMD ["npx","nodemon","src/index.js"]

# ---------- prod image -------------------------------------------------------
FROM node:${NODE_VERSION}-alpine AS prod
WORKDIR /usr/src/app
COPY --from=deps /usr/src/app/node_modules ./node_modules
COPY . .
ENV NODE_ENV=production
LABEL stage=prod \
      org.opencontainers.image.title="WeatherApp Backend" \
      org.opencontainers.image.description="Optimised production build" \
      org.opencontainers.image.source="https://github.com/igorkaw7/recruitment-2025" \
      org.opencontainers.image.licenses="MIT"
EXPOSE 9000
CMD ["node","src/index.js"]
