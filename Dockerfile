FROM python:3.8-slim

WORKDIR /app

# Install system dependencies (based on official documentation)
RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y \
    build-essential \
    git \
    libgl1 \
    libglib2.0-0 \
    libxml2-dev \
    libxslt-dev \
    zlib1g-dev \
    wait-for-it \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . /app

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt
