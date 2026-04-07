FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir "ccproxy-api[plugins-codex]==0.2.7"

WORKDIR /app

CMD ["ccproxy", "serve", "--host", "0.0.0.0", "--port", "8000"]
