## Python with Docker and Postgres

### Common commands
```
docker compose up --build      # Build and start all services
docker compose up -d           # Run in background
docker compose down            # Stop services
docker compose down -v         # Stop and remove volumes (deletes db data)
docker compose logs -f web     # Follow logs for web service
docker compose exec db psql -U postgres -d flaskdb  # Connect to postgres
```

### Sample Dockerfile
```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "run.py"]
```

### Sample docker-compose.yml
```yaml
services:
  db:
    image: postgres:15
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: flaskdb
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 5s
      timeout: 5s
      retries: 5

  web:
    build: .
    ports:
      - "5001:5000" # AirPlay Receiver on Macs used port 5000
    environment:
      DATABASE_URL: postgresql://postgres:postgres@db:5432/flaskdb
    depends_on:
      db:
        condition: service_healthy
    volumes:
      - .:/app

volumes:
  postgres_data:
```
