#!/bin/bash
set -e

mkdir -p postgres_data
mkdir -p initdb

cat > initdb/init.sql <<'EOF'
-- Initialize database schema and tables
CREATE DATABASE testdb;

\connect testdb;

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(200) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0
);
EOF

cat > docker-compose.yml <<'EOF'
version: '3.8'

services:
  postgres:
    image: postgres:16
    container_name: test-postgres
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: testdb
    ports:
      - "5432:5432"
    volumes:
      - ./postgres_data:/var/lib/postgresql/data
      - ./initdb:/docker-entrypoint-initdb.d
    restart: unless-stopped
EOF

docker compose up -d