FROM python:3.11-alpine

WORKDIR /app

# Upgrade vulnerable default Python packages to pass Trivy scan
RUN pip install --no-cache-dir --upgrade wheel jaraco.context setuptools

# Create a dummy requirements.txt if you don't have one
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt || true

COPY . .

# Security Best Practice: Run as non-root user
RUN adduser -D appuser && chown -R appuser /app
USER appuser

# Dummy entrypoint
CMD ["python", "-c", "print('Microservice running...')"]