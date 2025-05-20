@echo off
REM Stop running containers
docker-compose down -v

REM Remove existing images
docker rmi $(docker images -q) -f

REM Remove existing volumes
docker volume prune -f

REM Rebuild images without cache to force git clone
docker-compose build --no-cache

REM Start containers
docker-compose up -d