# Stage 1: Build Stage
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION} as builder

# Set the working directory
WORKDIR /app
COPY . .

# Stage 2: Run Stage
FROM python:${PYTHON_VERSION} as run

WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY --from=builder /app .

# Install dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Expose the Django app port
EXPOSE 8000

# Command to start the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
