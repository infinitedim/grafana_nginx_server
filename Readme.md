# Grafana + Nginx Docker Setup

Project ini berisi setup Grafana dengan Nginx sebagai reverse proxy menggunakan Docker Compose.

## Struktur Project

```
.
├── docker-compose.yml
├── README.md
├── Makefile
├── .env.example
├── .gitignore
└── nginx/
    ├── Dockerfile
    └── default.conf
```

## Cara Menjalankan

### Prerequisites
- Docker
- Docker Compose

### Menjalankan Services

1. Clone repository ini
2. Jalankan docker compose:

```bash
docker-compose up -d
```

3. Akses aplikasi:
   - **Grafana**: http://localhost:4000
   - **Nginx (Reverse Proxy)**: http://localhost:80

### Login Grafana Default
- Username: `admin`
- Password: `admin`

## Menghentikan Services

```bash
docker-compose down
```

Untuk menghapus volume data juga:

```bash
docker-compose down -v
```

## Melihat Logs

```bash
# Semua services
docker-compose logs -f

# Grafana saja
docker-compose logs -f grafana

# Nginx saja
docker-compose logs -f nginx
```

## Konfigurasi

### Nginx
Edit file `nginx/default.conf.template` untuk kustomisasi konfigurasi Nginx reverse proxy.

Environment variables yang bisa diubah:
- `GRAFANA_HOST`: hostname Grafana service (default: `grafana`)
- `GRAFANA_PORT`: port Grafana service (default: `4000`)

## Port yang Digunakan
- **4000**: Grafana (internal)
- **80**: Nginx reverse proxy (akses utama)

## Network
Services berkomunikasi melalui Docker network `grafana-network`.