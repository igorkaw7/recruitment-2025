# ---------- dependencies -----------------------------------------------------
ARG NODE_VERSION=20
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
      org.opencontainers.image.title="WeatherApp Frontend (Dev)" \
      org.opencontainers.image.description="Client with hot-reload" \
      org.opencontainers.image.source="https://github.com/igorkaw7/recruitment-2025" \
      org.opencontainers.image.licenses="MIT"
EXPOSE 8000
CMD ["npm","start"]

# ---------- build ------------------------------------------------------------
FROM node:${NODE_VERSION}-alpine AS build
WORKDIR /usr/src/app
COPY --from=deps /usr/src/app/node_modules ./node_modules
COPY . .
RUN npm run build

# ---------- prod image -------------------------------------------------------
FROM nginx:alpine AS prod
COPY --from=build /usr/src/app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
LABEL stage=prod \
      org.opencontainers.image.title="WeatherApp Frontend" \
      org.opencontainers.image.description="Optimised production build" \
      org.opencontainers.image.source="https://github.com/igorkaw7/recruitment-2025" \
      org.opencontainers.image.licenses="MIT"
EXPOSE 8000
CMD ["nginx", "-g", "daemon off;"]
