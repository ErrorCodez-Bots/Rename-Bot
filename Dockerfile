# Use a modern, actively supported Python base image
FROM python:3.10-slim

# Install system dependencies & clean apt cache to keep image lightweight
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    git \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install Python dependencies first (leverages Docker layer caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -U pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy application source code
COPY . .

# Start the bot
CMD ["python3", "bot.py"]
