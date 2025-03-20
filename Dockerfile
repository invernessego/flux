#rolling back to last known working image
# Using official PyTorch image with CUDA 12.1 support
FROM runpod/base:dev-feat-update-comfyui-cuda12.2.0

# Set the working directory
WORKDIR /app

# Install additional dependencies
RUN pip install --upgrade pip
RUN pip install torch diffusers transformers accelerate safetensors runpod boto3 Pillow

# Copy your handler code into the container
COPY handler.py /app/handler.py

# Run the handler using python3
CMD ["python3", "-u", "handler.py"]
