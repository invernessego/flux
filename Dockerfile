# Use the official PyTorch image with CUDA 12.2 support
FROM runpod/base

# Set the working directory
WORKDIR /app

# Install additional dependencies
RUN pip install --no-cache-dir \
    diffusers transformers accelerate safetensors runpod boto3 Pillow

# Copy your handler code into the container
COPY handler.py .

# Run the handler using python3
CMD ["python3", "-u", "handler.py"]
