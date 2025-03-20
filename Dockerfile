#Installing system packages
RUN apt-get update && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

#installing python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

#adding fastAPI code
COPY app.py

#container startup
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]

#check to make sure runs app as non-root
RUN useradd -m -u 1000 appuser && chown -R appuser /app  
USER appuser  
