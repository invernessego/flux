# Use RunPod's base image with CUDA support for GPU 
FROM runpod/base:0.4.0-cuda11.8.0

# Set working directory
WORKDIR /app

# Install necessary Python packages
# (It's good practice to pin versions for reproducibility)
RUN pip install --no-cache-dir \
    torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu118 && \
    pip install --no-cache-dir diffusers==0.22.0 transformers accelerate safetensors runpod boto3

# Copy the handler script into the container
COPY handler.py .

# (Optional) If you have other scripts or files (e.g., a custom upload helper), copy them as well
# COPY utils.py .

# Define the command to run when the container starts:
# This will launch our handler using RunPod's serverless runtime.
CMD [ "python", "-u", "handler.py" ]
