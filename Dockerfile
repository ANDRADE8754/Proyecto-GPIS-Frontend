# ========================================
# Dockerfile para Frontend (React + Vite)
# ========================================

# Etapa 1: Construcción
FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

# Etapa 2: Servidor de producción
FROM nginx:alpine

# Copiar configuración de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copiar archivos construidos
COPY --from=build /app/dist /usr/share/nginx/html

# Puerto del frontend (actualizado)
EXPOSE 5175

# Comando de inicio
CMD ["nginx", "-g", "daemon off;"]
