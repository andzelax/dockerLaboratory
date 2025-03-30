# Etap 1: Budowanie aplikacji webowej
FROM node:alpine AS builder

ARG VERSION="1.0.0"
WORKDIR /app

# Kopiowanie plików zależności
COPY package.json ./

# Instalacja zależności
RUN npm install

# Kopiowanie reszty plików aplikacji
COPY . .

# Informacja o porcie wewnętrznym
EXPOSE 8080

# Ustawienie zmiennej środowiskowej
ENV VERSION=${VERSION}

# Etap 2: Serwer Nginx
FROM nginx:alpine AS production

# Kopiowanie aplikacji z pierwszego etapu
COPY --from=builder /app /usr/share/nginx/html

# Ustawienie konfiguracji Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Otwieranie portu 80
EXPOSE 80

# Sprawdzanie poprawności działania
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s \ 
  CMD curl -f http://localhost || exit 1

# Uruchomienie Nginx
CMD ["nginx", "-g", "daemon off;"]
