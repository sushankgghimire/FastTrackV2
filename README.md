# FastTrackV2

A Django REST Framework remake of the original Fast Track Engineering Institute website, rebuilt for modern development and deployment. This project uses Docker for containerization and a `justfile` for streamlined development commands.

- Django 5.1 + Django REST Framework
- Python 3.13
- PostgreSQL 17
- Docker & Docker Compose
- `uv` for Python package management
- Linting, formatting, and testing tools: ruff, pytest, django-environ, and more

## Getting Started

### Prerequisites

- [Docker & Docker Compose](https://docs.docker.com/compose/install/)
- [uv](https://docs.astral.sh/uv/getting-started/installation/)
- [just](https://github.com/casey/just)

### Setup & Run

1. **Bootstrap the project** (builds images, sets up env, runs migrations):
   ```sh
   just bootstrap
   ```
2. **Start the app and infrastructure:**
   ```sh
   just start
   ```
3. **Stop all services:**
   ```sh
   just stop
   ```

### Common Development Commands

- Run Django management commands: `just manage <command>`
- Run tests: `just test`
- Run tests with coverage: `just test-cov`
- Lint & format code: `just ruff`
- Clean up cache files: `just clean`

All recipes are defined in the [`justfile`](justfile) for easy access..
