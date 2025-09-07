# Use a base image com Node
FROM node:18-alpine

# Instala pnpm
RUN npm install -g pnpm

# Define diretório de trabalho
WORKDIR /app

# Copia package.json e lockfile
COPY package*.json pnpm-lock.yaml ./

# Instala dependências ignorando o frozen lockfile
RUN pnpm install --no-frozen-lockfile

# Copia o restante do código
COPY . .

# Build do Next.js
RUN pnpm run build

# Expõe a porta (ajuste se você usa outra porta)
EXPOSE 3010

# Comando para iniciar a aplicação
CMD ["pnpm", "run", "start"]
