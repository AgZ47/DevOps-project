FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt || true

COPY . .

# Security Best Practice: Run as non-root user (Prevents some Checkov/Trivy flags)
RUN useradd -m appuser && chown -R appuser /app
USER appuser

# Dummy entrypoint
CMD ["python", "-c", "print('Microservice running...')"]