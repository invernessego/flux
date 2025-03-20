#pushing a useless update cause I don't know how to make the endpoint redeploy the latest build
# Using official PyTorch image with CUDA 12.1 support
FROM pytorch/pytorch:2.1.-cuda12.1-cudnn8-runtime

# Set the working directory
WORKDIR /app

# Install additional dependencies
RUN pip install --upgrade pip
RUN pip install torch diffusers transformers accelerate safetensors runpod boto3 Pillow

# Copy your handler code into the container
COPY handler.py /app/handler.py

# Run the handler using python3
CMD ["python3", "-u", "handler.py"]
