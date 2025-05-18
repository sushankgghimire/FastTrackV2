FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim AS builder

# Build argument to control dev dependencies
ARG UV_INSTALL_DEV=false

WORKDIR /app


ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy

RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    if [ "$UV_INSTALL_DEV" = "false" ] || [ "$UV_INSTALL_DEV" = "0" ]; then \
        uv sync --frozen --no-install-project --no-dev; \
    else \
        uv sync --frozen --no-install-project --group dev --group test; \
    fi

COPY ./src /app/src
COPY ./scripts /app/scripts

RUN sed -i 's/\r$//g' /app/scripts/django

FROM python:3.13-slim-bookworm

# Copy the application from the builder
COPY --from=builder /app /app

# Ensure scripts are executable in the final image
RUN chmod +x /app/scripts/django

# Place executables in the environment at the front of the path
ENV PATH="/app/.venv/bin:$PATH" \
    USER="app"

WORKDIR /app/src

ARG DJANGO_DEBUG=false

CMD ["granian", "--interface", "asgi", "config.asgi:application", "--host", "0.0.0.0", "--port", "8000"]
