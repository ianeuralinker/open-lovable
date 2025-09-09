/** @type {import('next').NextConfig} */
const nextConfig = {
  // Evita que erros de TS/ESLint derrubem o build de produção
  typescript: { ignoreBuildErrors: true },
  eslint: { ignoreDuringBuilds: true },

  // Para Docker: empacota como standalone
  output: 'standalone',
};

module.exports = nextConfig;
