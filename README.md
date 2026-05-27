# EP2 Frontend (Docker + CI/CD)

Frontend React + Vite, dockerizado con multi-stage (IE1) y desplegado en EC2 pública (IE5).

## 1) Requisitos

- Node.js 18+ (para desarrollo local)
- Docker + Docker Compose (para contenedor / EC2)

## 2) Configuración de API (IE7)

Se eliminó el hardcode de IPs y ahora el Front usa:

- `VENTAS_URL`
- `DESPACHOS_URL`

En **producción** (Docker), esas variables se inyectan al iniciar el contenedor y generan `env.js`.

En **desarrollo local**, puedes usar variables de Vite:

```bash
cp .env.example .env
```

## 3) Desarrollo local

```bash
npm install
npm run dev
```

## 4) Dockerfile (IE1)

`Dockerfile` multi-stage:

- Stage 1: build Vite
- Stage 2: Nginx unprivileged (no root)

## 5) Despliegue en EC2 pública (IE5)

En la EC2 frontend (pública):

1) Instala Docker + Compose.
2) Clona el repo en `/home/ubuntu/ep2-frontend`.
3) Crea `.env` desde `.env.example` y define las URLs hacia tu EC2 backend privada (IP privada).
4) Ejecuta:
   ```bash
   docker compose pull
   docker compose up -d
   ```
5) Abre el Security Group del frontend para **HTTP 80** desde Internet.

## 6) CI/CD (IE4)

Workflow: `.github/workflows/deploy.yml`

**Trigger:** push a rama `deploy`  
**Acciones:** build → push a DockerHub → deploy por SSH en EC2

### Secrets requeridos en GitHub

- `DOCKERHUB_USERNAME`
- `DOCKERHUB_TOKEN`
- `EC2_FRONT_HOST` (IP/DNS pública de la EC2 frontend)
- `EC2_FRONT_USER` (ej: `ubuntu`)
- `EC2_FRONT_SSH_KEY` (llave privada)

> El workflow asume ruta `/home/ubuntu/ep2-frontend` en la EC2. Ajusta si cambia.

