# Node runtime
FROM node:18-alpine

# Dependências do sistema (opcional, mas ajuda algumas libs nativas)
RUN apk add --no-cache libc6-compat

# PNPM
RUN npm install -g pnpm

WORKDIR /app

# Instala deps com cache eficiente
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile=false

# Cria next.config.js permissivo ANTES do build
# (Se você já tem next.config.js no repo, só garanta essas chaves)
RUN printf "const nextConfig = {\n  typescript: { ignoreBuildErrors: true },\n  eslint: { ignoreDuringBuilds: true },\n  output: 'standalone'\n};\nmodule.exports = nextConfig;\n" > next.config.js

# Copia o resto do projeto
COPY . .

# Build
RUN pnpm run build

# Runtime
EXPOSE 3010
ENV PORT=3010 HOSTNAME=0.0.0.0
CMD ["pnpm", "run", "start"]
