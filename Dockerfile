FROM python:3.11-alpine

WORKDIR /app

RUN pip install --no-cache-dir --upgrade wheel jaraco.context setuptools

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt || true

COPY . .

RUN adduser -D appuser && chown -R appuser /app
USER appuser

# Dummy entrypoint
CMD ["python", "-c", "print('Microservice running...')"]